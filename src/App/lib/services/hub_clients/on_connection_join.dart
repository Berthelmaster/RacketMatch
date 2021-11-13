import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../constants.dart';

class OnConnectionJoin {
  HubConnection? _hubConnection;

  OnConnectionJoin(){
    _hubConnection ??= HubConnectionBuilder()
        .withUrl("$httpBaseEndpoint/roomhub")
        .build();
    print('HubConnection build!');
  }


  void initialize() async{
    _hubConnection!.onclose( ({error}) async => print("Connection Closed"));
    await _hubConnection!.start();
    print(_hubConnection!.connectionId.toString());
  }


}