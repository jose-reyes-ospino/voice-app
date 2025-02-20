part of ui;

class RecordedWidget extends StatelessWidget {
  const RecordedWidget({super.key});

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
          isPlaying: false,
          onPlay: () {},
          onPause: () {},
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
                onPressed: () {},
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
