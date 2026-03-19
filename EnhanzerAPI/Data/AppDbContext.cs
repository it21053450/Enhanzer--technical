using EnhanzerAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace EnhanzerAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<Location> Location_Details { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Location>(entity =>
            {
                entity.ToTable("Location_Details");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Location_Code).IsRequired();
                entity.Property(e => e.Location_Name).IsRequired();
            });
        }
    }
}
