part of ui;

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.message = 'Loading...',
  });

  final String message;

  static const String routeName = '/loading-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSpacing.verticalSpace16,
            const LinearProgressIndicator(
              color: CustomColors.primaryYellow,
            ),
            CustomSpacing.verticalSpace16,
            Text(
              message,
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
