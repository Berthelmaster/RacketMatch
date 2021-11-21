using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Racket.Match.RestApi.Dtos;
using Racket.Match.RestApi.Entities;
using Racket.Match.RestApi.Interfaces;

namespace Racket.Match.RestApi.Hubs
{
    public class RoomHub : Hub
    {
        private readonly IDatabaseContext _context;

        public RoomHub(IDatabaseContext context)
        {
            _context = context;
        }
        
        public async Task AddToGroup(string groupName)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);

            await Clients.Group(groupName).SendAsync("MemberChanged", $"A player has joined the room");
        }
        
        public async Task RemoveFromGroup(string groupName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, groupName);

            await Clients.Group(groupName).SendAsync("MemberChanged", $"{Context.ConnectionId} has left the room");
        }

        public async Task AddPlayersToMatch(string groupName, Player player)
        {
            await Clients.Group(groupName).SendAsync("PlayerAdded", player);
        }

        public async Task MatchChangeInProgress(string groupName, int matchId, bool inProgress)
        {
            var matchChange = new MatchChangeInProgress()
            {
                MatchId = matchId,
                InProgress = inProgress
            };
            
            await Clients.Group(groupName).SendAsync("MatchChangeInProgress", matchChange);
        }

        public override Task OnConnectedAsync()
        {
            return base.OnConnectedAsync();
        }

        public override Task OnDisconnectedAsync(Exception? exception)
        {
            return base.OnDisconnectedAsync(exception);
        }
    }
}