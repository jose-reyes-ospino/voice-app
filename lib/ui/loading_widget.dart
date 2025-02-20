part of ui;

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({
    super.key,
    this.message = 'Loading...',
  });

  final String message;
  static const String routeName = '/loading-screen';

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(userProvider).uploadProgress;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSpacing.verticalSpace16,
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
                color: CustomColors.primaryYellow,
                backgroundColor: CustomColors.primaryYellow.withOpacity(0.2),
              ),
            ),
            CustomSpacing.verticalSpace16,
            Text(
              '${widget.message} ${(progress * 100).toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: CustomColors.primaryYellow,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
