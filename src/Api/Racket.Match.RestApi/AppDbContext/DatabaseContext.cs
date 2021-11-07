using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.Entities;

namespace Racket.Match.RestApi.AppDbContext
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options)
            : base(options)
        {
            
        }

        public DbSet<Room> Rooms { get; set; }
        public DbSet<Entities.Match> Matches { get; set; }
        public DbSet<Player> Players { get; set; }
        
        
    }
}