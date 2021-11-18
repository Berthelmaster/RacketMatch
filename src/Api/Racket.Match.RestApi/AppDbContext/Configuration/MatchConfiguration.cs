using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Racket.Match.RestApi.AppDbContext.Configuration
{
    public class MatchConfiguration : IEntityTypeConfiguration<Entities.Match>
    {
        public void Configure(EntityTypeBuilder<Entities.Match> builder)
        {
            builder.HasKey(k => k.Id);

            builder.HasMany(a => a.Players)
                .WithMany(b => b.Matches);

            builder.HasOne(a => a.Room)
                .WithMany(b => b.Matches)
                .HasForeignKey(c => c.RoomId);
        }
    }
}