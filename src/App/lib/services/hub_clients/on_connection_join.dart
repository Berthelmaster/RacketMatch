import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../constants.dart';

class OnConnectionJoin {
  HubConnection? _hubConnection;
  String? _groupName;
  Function(List<Object>?)? _onMemberChangedCallback;

  OnConnectionJoin(String groupName, Function(List<Object>?) onMemberChangedCallback){
    _groupName = groupName;
    _onMemberChangedCallback = onMemberChangedCallback;
    _hubConnection ??= HubConnectionBuilder()
        .withUrl("$httpBaseEndpoint/roomhub")
        .build();
    print('HubConnection build with groupName $groupName');
  }


  Future<OnConnectionJoin> initialize() async{
    _hubConnection!.onclose( ({error}) async => print("Connection Closed"));
    _hubConnection!.on("MemberChanged", (arguments) => memberChanged(arguments));
    await _hubConnection!.start();
    
    final AddMemberToGroup = await _hubConnection!.invoke("AddToGroup", args: <Object>[_groupName as Object]);

    return this;
  }

  void memberChanged(List<Object>? object) async{
    await _onMemberChangedCallback!(object);
  }

  Future<void> dispose() async {
    await _hubConnection!.stop();
  }





}