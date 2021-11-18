using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Racket.Match.RestApi.Entities;

namespace Racket.Match.RestApi.AppDbContext.Configuration
{
    public class RoomConfiguration : IEntityTypeConfiguration<Room>
    {
        public void Configure(EntityTypeBuilder<Room> builder)
        {
            builder.HasKey(k => k.Id);

            builder.HasMany(a => a.Players)
                .WithOne(b => b.Room)
                .HasForeignKey(c => c.RoomId);
            
                
            builder.Navigation(b => b.Players)
                .UsePropertyAccessMode(PropertyAccessMode.Property);
        }
    }
}