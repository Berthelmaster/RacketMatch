using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Racket.Match.RestApi.AppDbContext;
using Racket.Match.RestApi.Interfaces;

namespace Racket.Match.RestApi.Extensions
{
    public static class DependencyInjectionLifetime
    {
        public static void AddObjectLifetime(this IServiceCollection services)
        {
            services.AddScoped<IDatabaseContext, DatabaseContext>();
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.TryAddSingleton<IActionContextAccessor, ActionContextAccessor>();
        }   
    }
}