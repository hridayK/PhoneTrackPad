import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TrackPad extends StatefulWidget {
  const TrackPad({super.key});

  @override
  State<TrackPad> createState() => _TrackPadState();
}

class _TrackPadState extends State<TrackPad> {
  Offset currentPosition = Offset.zero;
  GlobalKey containerKey = GlobalKey();

  void printGlobalPosition() {
    RenderBox renderBox =
        containerKey.currentContext!.findRenderObject() as RenderBox;
    Offset globalPosition = renderBox.localToGlobal(Offset.zero);
    print('Global position: (${globalPosition.dx}, ${globalPosition.dy})');
  }

  Socket socket = io(
      'http://<your_server_address>:3000',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());
  @override
  void initState() {
    socket.connect();
    socket.onConnect((data) {
      setState(() {});
      socket.emit('msg', 'Connection successful');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          final Offset position = details.globalPosition;
          socket.emit('msg', '${position.dx},${position.dy}');
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trackpad'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.amber.shade800,
        )),
      ),
    );
  }
}
