using System.Collections.Generic;

namespace Racket.Match.RestApi.Models
{
    public class Room
    {
        public int Id { get; set; }
        public List<Match> Matches { get; set; }
    }
}