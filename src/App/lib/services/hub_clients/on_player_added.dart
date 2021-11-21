import 'package:racket_match/models/player.dart';
import 'package:racket_match/services/hub_clients/base_hub_connection.dart';

class OnPlayerAdded extends BaseHubConnection{
  late String _groupName;
  Function(List<Object>?)? _onPlayerAddedCallback;
  Function(List<Object>?)? _onPlayerDeletedCallback;

  OnPlayerAdded(String groupName, Function(List<Object>?) onPlayerAddedCallback, Function(List<Object>?) onPlayerDeletedCallback) : super(){
    _groupName = groupName;
    _onPlayerAddedCallback = onPlayerAddedCallback;
    _onPlayerDeletedCallback = onPlayerDeletedCallback;
  }

  @override
  Future<OnPlayerAdded> initialize() async{
    await super.initialize();

    BaseHubConnection.hubConnection!.on("PlayerAdded", (arguments) async => await playerAdded(arguments));
    BaseHubConnection.hubConnection!.on("PlayerRemoved", (arguments) async => await playerDeleted(arguments));

    return this;
  }

  Future<void> playerAdded(List<Object>? arguments) async{
    await _onPlayerAddedCallback!(arguments);
  }

  Future<void> playerDeleted(List<Object>? arguments) async{
    await _onPlayerDeletedCallback!(arguments);
  }

  Future<void> invokePlayerAdded(int roomId, Player player) async{
    var obj = [_groupName, roomId, player];
    BaseHubConnection.hubConnection!.invoke("AddPlayersToMatch", args: obj);
  }

  @override
  void unregisterEvents() {
    BaseHubConnection.hubConnection!.off("PlayerAdded");
    BaseHubConnection.hubConnection!.off("PlayerRemoved");
  }
}