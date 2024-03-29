﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Racket.Match.RestApi.AppDbContext;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Hubs;
using Racket.Match.RestApi.Interfaces;
using System.Text.Json;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Racket.Match.RestApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PlayerController : ControllerBase
    {
        private readonly IDatabaseContext _context;
        private readonly IHubContext<RoomHub> _hubContext;
        
        public PlayerController(IDatabaseContext context, IHubContext<RoomHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }

        [HttpPost]
        public async Task<IActionResult> CreatePlayers([FromQuery] int roomId, [FromQuery] string groupName,[FromBody] Player player)
        {
            if (string.IsNullOrEmpty(player.Name))
                return BadRequest();
            
            var roomExist = await _context.Rooms.FindAsync(roomId);
            if (roomExist == null)
                return BadRequest();


            var createdPlayer = new Player()
            {
                Name = player.Name,
                RoomId = roomId,
                Team = null
            };

            var playerExist = await _context.Players
                .Where(x => x.Name == createdPlayer.Name && x.RoomId == createdPlayer.RoomId).AnyAsync();

            if (playerExist)
                return BadRequest();
            
            await _context.Players.AddAsync(createdPlayer);
            var nChanges = await _context.SaveChangesAsync();
            
            if (nChanges == 0) return BadRequest();

            var newPlayer = await _context.Players.Where(x => x.Name == player.Name).FirstOrDefaultAsync();
            
            var pam = new JsonSerializerSettings
            {
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                ContractResolver = new CamelCasePropertyNamesContractResolver() 
            };
            var jsonConvert = JsonConvert.SerializeObject(newPlayer, pam);
            
            await _hubContext.Clients.Group(groupName).SendAsync("PlayerAdded", jsonConvert);
            
            return Ok();
        }

        [HttpGet]
        public async Task<IActionResult> GetPlayersFromRoom([FromQuery] int roomId)
        {
            var player = await _context.Players
                .Where(x => x.RoomId == roomId)
                .ToListAsync();
            
            return Ok(player);
        }

        [HttpPut]
        public async Task<IActionResult> DeletePlayerFromRoom([FromQuery] int roomId, [FromQuery] string groupName,
            [FromQuery] int playerId)
        {
            var fetchPlayer = await _context.Players.Where(x => x.RoomId == roomId && x.Id == playerId).FirstOrDefaultAsync();
            if (fetchPlayer == null)
                return BadRequest();
            
            _context.Players.Remove(fetchPlayer);
            var nChanges = await _context.SaveChangesAsync();

            if (nChanges == 0)
                return BadRequest();

            var pam = new JsonSerializerSettings
            {
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                ContractResolver = new CamelCasePropertyNamesContractResolver() 
            };
            var jsonConvert = JsonConvert.SerializeObject(fetchPlayer, pam);
            
            await _hubContext.Clients.Group(groupName).SendAsync("PlayerRemoved", jsonConvert);
            
            return Ok();
        }
        
    }
}