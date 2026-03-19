using Microsoft.AspNetCore.Mvc;
using EnhanzerAPI.Services;

namespace EnhanzerAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            if (string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.Password))
            {
                return BadRequest("Email and Password are required");
            }

            var (success, message, token) = await _authService.LoginAsync(request.Email, request.Password);

            if (!success)
            {
                return BadRequest(message);
            }

            return Ok(new { message, token, email = request.Email });
        }

        [HttpGet("locations")]
        public async Task<IActionResult> GetLocations()
        {
            try
            {
                var locations = await _authService.GetLocationsAsync();
                return Ok(locations);
            }
            catch (Exception ex)
            {
                return BadRequest($"Error retrieving locations: {ex.Message}");
            }
        }
    }

    public class LoginRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }
}
