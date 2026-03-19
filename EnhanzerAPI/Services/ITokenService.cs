namespace EnhanzerAPI.Services
{
    public interface ITokenService
    {
        string GenerateToken(string email);
    }
}
