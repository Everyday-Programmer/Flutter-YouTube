import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Player Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: YouTubeVideoPlayer(),
    );
  }
}

class YouTubeVideoPlayer extends StatefulWidget {
  const YouTubeVideoPlayer({super.key});

  @override
  _YouTubeVideoPlayerState createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=dQw4w9WgXcQ");

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        isLive: false,
        hideControls: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YouTube Player"),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Column(
            children: [
              player,
              Center(
                child: IconButton(
                  onPressed: () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                  icon: _controller.value.isPlaying ? Icon(Icons.pause_rounded, size: 48) : Icon(Icons.play_arrow_rounded, size: 48),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(_controller.metadata.title,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("By: ${_controller.metadata.author}"),
                    ),
                  ],
                )
              ),
            ],
          );
        },
      ),
    );
  }
}
