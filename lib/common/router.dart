part of common;

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

GoRoute _getRoute({
  required String path,
  required Widget child,
  String? Function(BuildContext, GoRouterState)? redirect,
}) =>
    GoRoute(
      path: path,
      redirect: redirect,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: child,
      ),
    );

final router = GoRouter(
  initialLocation: HomePage.route,
  routes: [
    _getRoute(
      path: HomePage.route,
      child: const HomePage(),
    ),
  ],
);
