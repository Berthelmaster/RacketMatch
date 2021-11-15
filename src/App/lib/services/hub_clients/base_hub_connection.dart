import 'package:flutter/cupertino.dart';
import 'package:racket_match/services/hub_clients/base_hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../constants.dart';

abstract class BaseHubConnection{
  @protected
  HubConnection? hubConnection;
  bool _isSetup = false;

  BaseHubConnection(String groupName) {
    hubConnection ??= HubConnectionBuilder()
        .withUrl("$httpBaseEndpoint/roomhub")
        .build();
  }

  Future<void> dispose() async {
    _isSetup = false;
    await hubConnection!.stop();
  }

  Future<void> start() async {
    await hubConnection!.start();
  }

  Future<void> onClose() async{
    hubConnection!.onclose( ({error}) async => print("Connection Closed"));
  }

  Future<void> initialize() async{
    await setupBaseConnection();
  }

  Future<void> setupBaseConnection() async{
    if(_isSetup) {
      return;
    }
    _isSetup = true;
    await onClose();
    await start();
  }
}