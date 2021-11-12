using System;

namespace Racket.Match.RestApi.Logic
{
    public static class NGenerator
    {
        private static readonly Random Random = new Random();
        public static int GenerateUniqueIdentifier()
        {
            return Random.Next(10000, 99999);
        }
    }
}