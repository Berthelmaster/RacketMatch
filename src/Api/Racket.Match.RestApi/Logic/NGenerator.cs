using System;

namespace Racket.Match.RestApi.Logic
{
    public class NGenerator
    {
        private static readonly Random Random = new Random();
        public static int GenerateUniqueIdentifier()
        {
            return Random.Next(100000000, 999999999);
        }
    }
}