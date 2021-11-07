using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Racket.Match.RestApi.Dtos;
using Racket.Match.RestApi.Models;

namespace Racket.Match.RestApi.Hubs
{
    public class RoomHub : Hub
    {
        public async Task AddToGroup(string groupName)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);

            await Clients.Group(groupName).SendAsync("MemberChanged", $"{Context.ConnectionId} has joined the group {groupName}.");
        }
        
        public async Task RemoveFromGroup(string groupName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, groupName);

            await Clients.Group(groupName).SendAsync("MemberChanged", $"{Context.ConnectionId} has left the group {groupName}.");
        }

        public async Task AddPlayersToMatch(string groupName, List<Player> players)
        {
            // Find match
            
            // Update Match
            
            // Send updated Match to Room
            
            await Clients.Group(groupName).SendAsync("MatchUpdate", players);
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