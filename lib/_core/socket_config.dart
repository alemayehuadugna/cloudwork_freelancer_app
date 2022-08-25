import 'package:socket_io_client/socket_io_client.dart' as io;

io.Socket initSocket() {
  io.Socket socket = io.io(
      'http://localhost:3030',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  return socket;
}
