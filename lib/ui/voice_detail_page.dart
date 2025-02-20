part of ui;

class VoiceDetailPage extends ConsumerWidget {
  const VoiceDetailPage({super.key});

  static const routeName = '/voice-note-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('Voice Detail Page')),
    );
  }
}
