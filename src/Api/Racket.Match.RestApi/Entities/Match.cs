using System.Collections.Generic;

namespace Racket.Match.RestApi.Entities
{
    public class Match
    {
        public int Id { get; set; }
        public List<Player> Players { get; set; }
    }
}