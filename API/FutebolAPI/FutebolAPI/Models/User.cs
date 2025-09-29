using System;
using System.Collections.Generic;

namespace FutebolAPI.Models;

public partial class User
{
    public Guid Id { get; set; }
    public string Username { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string PasswordHash { get; set; } = null!;
    public string Role { get; set; } = null!;
    public DateTime CreatedAt { get; set; }
    public bool IsActive { get; set; }
}