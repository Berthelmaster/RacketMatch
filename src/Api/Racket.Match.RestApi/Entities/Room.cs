using System.Collections.Generic;

namespace Racket.Match.RestApi.Entities
{
    public class Room
    {
        public int Id { get; set; }
        public List<Match> Matches { get; set; }
    }
}