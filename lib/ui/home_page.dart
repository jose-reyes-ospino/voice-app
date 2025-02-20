part of ui;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Visibility(
                          visible: !ref.watch(userProvider).isRecording,
                          replacement: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 4,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              CustomSpacing.verticalSpace8,
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(userProvider.notifier)
                                      .stopRecording();
                                },
                                child: Text(
                                  'Stop recording',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: CustomColors.primaryYellow,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              ref.read(userProvider.notifier).startRecording();
                            },
                            child: Text(
                              'New voice note',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: CustomColors.primaryYellow,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
