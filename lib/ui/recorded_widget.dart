part of ui;

class RecordedWidget extends ConsumerStatefulWidget {
  const RecordedWidget({super.key});

  @override
  ConsumerState<RecordedWidget> createState() => _RecordedWidgetState();
}

class _RecordedWidgetState extends ConsumerState<RecordedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(flex: 3),
        Text(
          'Voice note recorded',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        CustomSpacing.verticalSpace24,
        Container(
          decoration: BoxDecoration(
            color: CustomColors.primaryYellow,
            borderRadius: BorderRadius.circular(16),
          ),
          width: 200,
          height: 5,
        ),
        CustomSpacing.verticalSpace24,
        PlayOrPauseWidget(
          isPlaying: ref.watch(playerProvider.notifier).isPlaying,
          onPlay: () async {
            setState(() {});
            await ref.read(userProvider.notifier).playVoiceNote();
            setState(() {});
          },
          onPause: () {
            setState(() {});
            ref.read(userProvider.notifier).pauseVoiceNote();
          },
        ),
        const Spacer(flex: 2),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () =>
                    ref.read(userProvider.notifier).discardVoiceNote(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Discard',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child:
                    Text('Save', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
