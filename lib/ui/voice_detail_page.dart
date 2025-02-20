part of ui;

class VoiceDetailPage extends ConsumerStatefulWidget {
  const VoiceDetailPage({
    super.key,
    required this.voiceNote,
  });

  final VoiceNote? voiceNote;

  static const routeName = '/voice-note-detail';

  @override
  ConsumerState<VoiceDetailPage> createState() => _VoiceDetailPageState();
}

class _VoiceDetailPageState extends ConsumerState<VoiceDetailPage> {
  @override
  void initState() {
    super.initState();
    if (widget.voiceNote == null) {
      router.go(HomePage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Detail'),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            router.push(HomePage.route);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uploaded on\n${CustomDateFormat.formatDate(widget.voiceNote!.createdAt)}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primaryYellow,
                  ),
            ),
            CustomSpacing.verticalSpace16,
            PlayOrPauseWidget(
              isPlaying: ref.watch(playerProvider.notifier).isPlaying,
              onPlay: () async {
                setState(() {});
                await ref.read(userProvider.notifier).playVoiceNote(context);
                setState(() {});
              },
              onPause: () {
                ref.read(userProvider.notifier).pauseVoiceNote();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
