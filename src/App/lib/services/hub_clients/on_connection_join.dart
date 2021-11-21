import 'package:racket_match/services/hub_clients/base_hub_connection.dart';

class OnConnectionJoin extends BaseHubConnection {
  late String _groupName;
  Function(List<Object>?)? _onMemberChangedCallback;

  OnConnectionJoin(String groupName, Function(List<Object>?) onMemberChangedCallback) : super() {
    _groupName = groupName;
    _onMemberChangedCallback = onMemberChangedCallback;
  }


  @override
  Future<OnConnectionJoin> initialize() async{
    await super.initialize();
    BaseHubConnection.hubConnection!.on("MemberChanged", (arguments) => memberChanged(arguments));

    await BaseHubConnection.hubConnection!.invoke("AddToGroup", args: <Object>[_groupName as Object]);

    return this;
  }

  void memberChanged(List<Object>? object) async{
    await _onMemberChangedCallback!(object);
  }

@override
  Future<void> unregisterEvents() {
    // TODO: implement unregisterEvents
    throw UnimplementedError();
  }
}