using System.Collections.Generic;

namespace Racket.Match.RestApi.Entities
{
    public class Room
    {
        public int Id { get; set; }
        public string RoomName { get; set; }
        public int UniqueRoomIdentifier { get; set; }
        public ICollection<Match> Matches { get; set; }
        public ICollection<Player> Players { get; set; }
    }
}