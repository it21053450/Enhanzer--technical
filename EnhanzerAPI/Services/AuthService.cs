using EnhanzerAPI.Data;
using EnhanzerAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace EnhanzerAPI.Services
{
    public class AuthService : IAuthService
    {
        private readonly AppDbContext _context;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ITokenService _tokenService;
        private const string EXTERNAL_API_URL = "https://ez-staging-api.azurewebsites.net/api/External_Api/POS_Api/Invoke";

        public AuthService(AppDbContext context, IHttpClientFactory httpClientFactory, ITokenService tokenService)
        {
            _context = context;
            _httpClientFactory = httpClientFactory;
            _tokenService = tokenService;
        }

        public async Task<(bool Success, string Message, string? Token)> LoginAsync(string email, string password)
        {
            try
            {
                // Prepare external API request
                var externalRequest = new
                {
                    API_Action = "GetLoginData",
                    Device_Id = "D001",
                    Sync_Time = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"),
                    Company_Code = email,
                    API_Body = new
                    {
                        Username = email,
                        Pw = password
                    }
                };

                // Call external API
                var client = _httpClientFactory.CreateClient();
                var jsonContent = new StringContent(
                    JsonSerializer.Serialize(externalRequest),
                    System.Text.Encoding.UTF8,
                    "application/json"
                );

                var response = await client.PostAsync(EXTERNAL_API_URL, jsonContent);

                if (!response.IsSuccessStatusCode)
                {
                    return (false, "Login Failed", null);
                }

                var responseContent = await response.Content.ReadAsStringAsync();
                var jsonDoc = JsonDocument.Parse(responseContent);
                var root = jsonDoc.RootElement;

                // Check if login was successful
                if (!root.TryGetProperty("IsSuccess", out var isSuccess) || !isSuccess.GetBoolean())
                {
                    return (false, "Login Failed", null);
                }

                // Extract and save User_Locations
                if (root.TryGetProperty("ResponseData", out var responseData) &&
                    responseData.TryGetProperty("User_Locations", out var locationsArray))
                {
                    // Clear existing locations
                    _context.Location_Details.RemoveRange(_context.Location_Details);
                    await _context.SaveChangesAsync();

                    // Insert new locations
                    var locations = new List<Location>();
                    foreach (var location in locationsArray.EnumerateArray())
                    {
                        if (location.TryGetProperty("Location_Code", out var code) &&
                            location.TryGetProperty("Location_Name", out var name))
                        {
                            locations.Add(new Location
                            {
                                Location_Code = code.GetString() ?? string.Empty,
                                Location_Name = name.GetString() ?? string.Empty
                            });
                        }
                    }

                    if (locations.Any())
                    {
                        _context.Location_Details.AddRange(locations);
                        await _context.SaveChangesAsync();
                    }
                }

                // Generate JWT token
                var token = _tokenService.GenerateToken(email);

                return (true, "Login successful", token);
            }
            catch (Exception ex)
            {
                return (false, $"Login Failed: {ex.Message}", null);
            }
        }

        public async Task<List<LocationDto>> GetLocationsAsync()
        {
            try
            {
                var locations = await _context.Location_Details
                    .Select(l => new LocationDto
                    {
                        Id = l.Id,
                        Location_Code = l.Location_Code,
                        Location_Name = l.Location_Name
                    })
                    .ToListAsync();

                return locations;
            }
            catch
            {
                return new List<LocationDto>();
            }
        }
    }
}
