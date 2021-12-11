using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
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
        public async Task<IActionResult> CreateOrEditMatch([FromQuery] int roomId, [FromQuery] string groupName, [FromBody] List<Player> players, [FromBody] Entities.Match match = null)
        {
            if (match == null)
            {
                return Ok();
            }

            return Ok();
        }
        
    }
}