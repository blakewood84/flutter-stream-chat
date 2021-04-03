import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = StreamChatClient('r6r4cy6u4qvg', logLevel: Level.INFO);

  await client.connectUser(
    User(id: 'bishop-wood', extraData: {
      'image':
          'http://local.getstream.io:9000/random_png/?id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGFtcC1tb3JuaW5nLTQifQ.CgiMxzAi89jQgsAPmtfJeVRiP2clhiC4KlOhvOl-gHM&amp;name=damp-morning-4'
    }),
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZGFtcC1tb3JuaW5nLTQifQ.CgiMxzAi89jQgsAPmtfJeVRiP2clhiC4KlOhvOl-gHM',
  );

  // create channel
  final channel = client.channel('messaging', id: 'godevs');

  channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  MyApp(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) {
          return StreamChat(
            child: widget,
            client: client,
          );
        },
        home: StreamChannel(
          channel: channel,
          child: ChannelPage(),
        ));
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      )
    );
  }
}
