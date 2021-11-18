using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.AppDbContext;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Interfaces;

namespace Racket.Match.RestApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PlayerController : ControllerBase
    {
        private readonly IDatabaseContext _context;
        
        public PlayerController(IDatabaseContext context)
        {
            _context = context;
        }

        [HttpPost]
        public async Task<IActionResult> CreatePlayers([FromQuery] int roomId, [FromBody] List<Player> players)
        {
            var roomExist = await _context.Rooms.FindAsync(roomId);
            if (roomExist == null)
                return BadRequest();
            
            var playerCollection = players
                .Select(player => new Player {Name = player.Name, RoomId = roomId})
                .ToList();

            if (playerCollection.Count == 0)
                return BadRequest();

            await _context.Players.AddRangeAsync(playerCollection);
            var nChanges = await _context.SaveChangesAsync();
            
            if (nChanges == 0) return BadRequest();
            
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