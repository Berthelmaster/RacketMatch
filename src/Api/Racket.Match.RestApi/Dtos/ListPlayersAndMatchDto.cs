﻿using Racket.Match.RestApi.Entities;
using System.Collections.Generic;

namespace Racket.Match.RestApi.Dtos
{
    public class CreateOrEditMatchDto
    {
        public List<Player> Players { get; set; }
        public Entities.Match Match { get; set; }
    }
}
