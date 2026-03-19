namespace EnhanzerAPI.Services
{
    public interface IAuthService
    {
        Task<(bool Success, string Message, string? Token)> LoginAsync(string email, string password);
        Task<List<LocationDto>> GetLocationsAsync();
    }

    public class LocationDto
    {
        public int Id { get; set; }
        public string Location_Code { get; set; } = string.Empty;
        public string Location_Name { get; set; } = string.Empty;
    }

    public class LoginResponseDto
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public string? Token { get; set; }
    }
}
