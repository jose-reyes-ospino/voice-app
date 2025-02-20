part of ui;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message = 'Loading...',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
    );
  }
}
