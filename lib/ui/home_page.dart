part of ui;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSpacing.verticalSpace8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacing.verticalSpace8,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'The Amazing Recording App',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primaryYellow,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
              ],
            ),
            Expanded(
              child: Visibility(
                visible: ref.watch(userProvider).isRecording,
                replacement: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ref.read(userProvider.notifier).startRecording();
                          },
                          child: Text(
                            'New voice note',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: CustomColors.primaryYellow,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final wave = sin(
                                        (_animationController.value * 2 * pi) +
                                            (index * 0.5));
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Container(
                                        width: 4,
                                        height: 20.0 + (wave * 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Recording',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryYellow,
                            ),
                      ),
                      CustomSpacing.verticalSpace16,
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            ref
                                .read(userProvider.notifier)
                                .stopRecording(context);
                          },
                          icon: const Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
