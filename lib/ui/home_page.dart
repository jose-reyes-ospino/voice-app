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
                    FirestoreQueryBuilder<VoiceNote>(
                      query:
                          ref.read(userProvider.notifier).allVoiceNotesQuery(),
                      builder: (context, snapshot, _) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Error fetching voice notes',
                            ),
                          );
                        }

                        if (snapshot.docs.isEmpty) {
                          return const Center(
                            child: Text('No hay datos para mostrar...'),
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.docs.length,
                            itemBuilder: (context, index) {
                              VoiceNote voiceNote = snapshot.docs[index].data();
                              return InkWell(
                                onTap: () {
                                  ref
                                      .read(userProvider.notifier)
                                      .goToVoiceDetailPage(voiceNote);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      CustomDateFormat.formatDate(
                                        voiceNote.createdAt,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
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
