using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.Entities;

namespace Racket.Match.RestApi.Interfaces
{
    public interface IDatabaseContext
    {
        public DbSet<Room> Rooms { get; set; }
        public DbSet<Entities.Match> Matches { get; set; }
        public DbSet<Player> Players { get; set; }
        
        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
        int SaveChanges();
    }
}