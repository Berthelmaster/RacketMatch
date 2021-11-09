using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Interfaces;

namespace Racket.Match.RestApi.AppDbContext
{
    public class DatabaseContext : DbContext, IDatabaseContext
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