using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.AppDbContext;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Hubs;
using Racket.Match.RestApi.Interfaces;
using System.Text.Json;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Racket.Match.RestApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PlayerController : ControllerBase
    {
        private readonly IDatabaseContext _context;
        private readonly IHubContext<RoomHub> _hubContext;
        
        public PlayerController(IDatabaseContext context, IHubContext<RoomHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }

        [HttpPost]
        public async Task<IActionResult> CreatePlayers([FromQuery] int roomId, [FromQuery] string groupName,[FromBody] Player player)
        {
            var roomExist = await _context.Rooms.FindAsync(roomId);
            if (roomExist == null)
                return BadRequest();


            var createdPlayer = new Player()
            {
                Name = player.Name,
                RoomId = roomId,
                Team = null
            };
                
            await _context.Players.AddAsync(createdPlayer);
            var nChanges = await _context.SaveChangesAsync();
            
            if (nChanges == 0) return BadRequest();

            var newPlayer = await _context.Players.Where(x => x.Name == player.Name).FirstOrDefaultAsync();
            
            var pam = new JsonSerializerSettings
            {
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                ContractResolver = new CamelCasePropertyNamesContractResolver() 
            };
            var jsonConvert = JsonConvert.SerializeObject(newPlayer, pam);
            
            await _hubContext.Clients.Group(groupName).SendAsync("PlayerAdded", jsonConvert);
            
            return Ok();
        }

        [HttpGet]
        public async Task<IActionResult> GetPlayersFromRoom([FromQuery] int roomId)
        {
            var player = await _context.Players
                .Where(x => x.RoomId == roomId)
                .ToListAsync();
            
            return Ok(player);
        }
        
    }
}