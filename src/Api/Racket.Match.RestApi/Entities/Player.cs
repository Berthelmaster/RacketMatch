using System.Collections.Generic;

namespace Racket.Match.RestApi.Entities
{
    public class Player
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Team? Team { get; set; }
        
        public ICollection<Match> Matches { get; set; }
        public Room Room { get; set; }
        public int RoomId { get; set; }
    }

    public enum Team
    {
        Team1,
        Team2
    }
}