using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Racket.Match.RestApi.AppDbContext;
using Racket.Match.RestApi.Extensions;
using Racket.Match.RestApi.Hubs;

namespace Racket.Match.RestApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo {Title = "Racket.Match.RestApi", Version = "v1"});
            });
            services.AddObjectLifetime();

            var connectionString = "server=localhost;user=root;password=root;database=ef";
            var serverVersion = new MySqlServerVersion(new Version(8, 0, 27));
            
            services.AddDbContext<DatabaseContext>(contextOptions =>
            {
                contextOptions.UseMySql(connectionString, serverVersion);
            });
            
            services.AddSignalR();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, DatabaseContext context)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Racket.Match.RestApi v1"));
            }
            else
            {
                app.UseHttpsRedirection();   
            }

            app.UseRouting();

            app.UseAuthorization();
            
            context.Database.Migrate();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapHub<RoomHub>("/roomhub");
            });
        }
    }
}