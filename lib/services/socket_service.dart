import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  Function get emit => _socket.emit;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  SocketService(){
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    _socket = IO.io('http://localhost:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    _socket.on('connect', (_) {
      
      _serverStatus = ServerStatus.Online;
      notifyListeners();
      // socket.emit('msg', 'test');
    });
    // socket.on('event', (data) => print(data));
    _socket.on('disconnect', (_) {

      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    
    _socket.on('disconnect', (_) {

      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ) {
    //   print( 'nuevo-mensaje:');
    //   print('nombre: ' + payload['nombre']);
    //   print('mensaje: ' + payload['mensaje']);
    //   print( payload.containsKey('mensaje2') ? payload['mensaje2']: 'no hay');
    // });
    // socket.on('fromServer', (_) => print(_));
  }

}