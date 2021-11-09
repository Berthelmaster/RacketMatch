using System;
using System.Linq;
using System.Threading;
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
    public class RoomController : ControllerBase
    {
        private readonly IDatabaseContext _context;
        public RoomController(IDatabaseContext context)
        {
            _context = context;
        }
        
        [HttpPost]
        public async Task<IActionResult> CreateRoom([FromQuery] string roomName)
        {
            if (string.IsNullOrEmpty(roomName))
                return BadRequest();
            
            var findExistingRoomWithIdenticalName =
                await _context.Rooms.Where(x => x.RoomName == roomName).FirstOrDefaultAsync();

            if (findExistingRoomWithIdenticalName != null)
                return Conflict();

            var createdRoom = new Room()
            {
                RoomName = roomName,
                Matches = null
            };

            await _context.Rooms.AddAsync(createdRoom);

            var nChanges = await _context.SaveChangesAsync();

            if (nChanges == 0) return BadRequest();
            
            var newRoom = await _context.Rooms.Where(x => x.RoomName == roomName).FirstOrDefaultAsync();
            return Ok(newRoom);
        }
    }
}