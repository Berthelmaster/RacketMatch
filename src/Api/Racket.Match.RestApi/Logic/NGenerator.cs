using System;

namespace Racket.Match.RestApi.Logic
{
    public static class NGenerator
    {
        private static readonly Random Random = new();
        public static int GenerateUniqueIdentifier() => Random.Next(10000, 99999);
    }
}