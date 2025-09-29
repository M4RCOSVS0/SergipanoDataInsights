using FutebolAPI.Models;
using System.Security.Claims;

namespace FutebolAPI.Services
{
    public interface IJwtService
    {
        string GenerateToken(User user);
        ClaimsPrincipal ValidateToken(string token);
    }
}