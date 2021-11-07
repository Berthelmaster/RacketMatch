namespace Racket.Match.RestApi.Entities
{
    public class Player
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Team Team { get; set; }
        public Match Match { get; set; }
    }

    public enum Team
    {
        Team1,
        Team2
    }
}