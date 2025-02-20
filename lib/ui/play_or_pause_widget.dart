part of ui;

class PlayOrPauseWidget extends StatelessWidget {
  const PlayOrPauseWidget({
    super.key,
    required this.isPlaying,
    required this.onPlay,
    required this.onPause,
  });

  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.primaryYellow,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          if (isPlaying) {
            onPause();
          } else {
            onPlay();
          }
        },
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
