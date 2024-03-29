using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Racket.Match.RestApi.Dtos;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Hubs;
using Racket.Match.RestApi.Interfaces;

namespace Racket.Match.RestApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MatchController : ControllerBase
    {
        private readonly IDatabaseContext _context;
        private readonly IHubContext<RoomHub> _hubContext;

        public MatchController(IDatabaseContext context, IHubContext<RoomHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }

        [HttpPost]
        public async Task<IActionResult> CreateOrEditMatch([FromQuery] int roomId, [FromQuery] string groupName, [FromBody] CreateOrEditMatchDto createOrEditMatchDto)
        {
            if (createOrEditMatchDto.Match == null)
            {
                return Ok();
            }

            return Ok();
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteMatch([FromBody] Entities.Match match)
        {
            var findMatch = await _context.Matches.FindAsync(match.Id);

            if (findMatch == null)
                return BadRequest();

            _context.Matches.Remove(findMatch);

            var nChanges = await _context.SaveChangesAsync();

            if (nChanges == 0)
                return BadRequest();

            return Ok();

        }
        
    }
}