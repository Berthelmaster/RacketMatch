using System.Collections.Generic;

namespace Racket.Match.RestApi.Models
{
    public class Match
    {
        public int Id { get; set; }
        public List<Player> Players { get; set; }
    }
}