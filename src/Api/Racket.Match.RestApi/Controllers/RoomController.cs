using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace Racket.Match.RestApi.Controllers
{
    public class RoomController : ControllerBase
    {
        public RoomController()
        {
            
        }
        
        [HttpPost]
        public async Task<IActionResult> CreateRoom([FromQuery] string roomName, [FromQuery] string roomHost)
        {
            return null;
        }
    }
}