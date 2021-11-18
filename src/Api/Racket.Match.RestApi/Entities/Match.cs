using System.Collections.Generic;

namespace Racket.Match.RestApi.Entities
{
    public class Match
    {
        public int Id { get; set; }
        public ICollection<Player> Players { get; set; }
        
        public Room Room { get; set; }
        public int RoomId { get; set; }
    }
}