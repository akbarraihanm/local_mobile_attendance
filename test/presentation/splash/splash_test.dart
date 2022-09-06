import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/presentation/dashboard/dashboard_screen.dart';
import 'package:hash_micro_test/presentation/splash/splash_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class RouteFake extends Fake implements Route {}

void main() {
  late MockNavigatorObserver observer;

  setUpAll(() {
    observer = MockNavigatorObserver();
    registerFallbackValue(RouteFake());
  });

  Widget createSplash() => MaterialApp(
    routes: {
      SplashScreen.routeName: (context) => const SplashScreen(),
      DashboardScreen.routeName: (context) => const DashboardScreen()
    },
    initialRoute: SplashScreen.routeName,
    navigatorObservers: [observer],
  );

  testWidgets(
      'Given splash screen '
      'When splash screen appears '
      'Then should return splash layout and go to dashboard '
          'after 3 second delay', (tester) async {

        await tester.pumpWidget(createSplash());
        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(find.byType(Container), findsOneWidget);

        verify(() => observer.didPush(captureAny(), any()));
  });
}