import 'package:flutter/material.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SCYoutubeVideoPlayerContainer extends StatefulWidget {
  const SCYoutubeVideoPlayerContainer({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<SCYoutubeVideoPlayerContainer> createState() => _SCYoutubeVideoPlayerContainerState();
}

class _SCYoutubeVideoPlayerContainerState extends State<SCYoutubeVideoPlayerContainer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false, forceHD: true),
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
    return SizedBox(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}