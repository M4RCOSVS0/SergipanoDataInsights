namespace FutebolAPI.DTOs
{
    public class RegisterRequest
    {
        public string Username { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
    }

    public class LoginRequest
    {
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
    }

    public class AuthResponse
    {
        public string AccessToken { get; set; } = null!;
        public int ExpiresIn { get; set; }
        public UserResponse User { get; set; } = null!;
    }

    public class UserResponse
    {
        public Guid Id { get; set; }
        public string Username { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Role { get; set; } = null!;
    }
}