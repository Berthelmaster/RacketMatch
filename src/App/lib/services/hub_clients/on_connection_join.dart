import 'package:racket_match/services/hub_clients/base_hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../constants.dart';

class OnConnectionJoin extends BaseHubConnection {
  String? _groupName;
  Function(List<Object>?)? _onMemberChangedCallback;

  OnConnectionJoin(String groupName, Function(List<Object>?) onMemberChangedCallback) : super(groupName) {
    _groupName = groupName;
    _onMemberChangedCallback = onMemberChangedCallback;
    print('HubConnection build with groupName $groupName');
  }


  @override
  Future<OnConnectionJoin> initialize() async{
    await super.initialize();
    hubConnection!.on("MemberChanged", (arguments) => memberChanged(arguments));

    await hubConnection!.invoke("AddToGroup", args: <Object>[_groupName as Object]);

    return this;
  }

  void memberChanged(List<Object>? object) async{
    await _onMemberChangedCallback!(object);
  }
}