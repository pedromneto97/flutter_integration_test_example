import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_example/main.dart' as app;
import 'package:mock_web_server/mock_web_server.dart';

import 'responses/get_pokemon.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late final MockWebServer server;

  setUpAll(() {
    server = MockWebServer(port: 3000)..start();
    server.enqueue(
      body: jsonEncode(getPokemonResponse),
      httpCode: HttpStatus.ok,
    );
    server.enqueue(
      body: jsonEncode({'name': 'charmander'}),
      httpCode: HttpStatus.ok,
    );
  });

  testWidgets("Main test", (WidgetTester tester) async {
    app.main();
    await binding.waitUntilFirstFrameRasterized;
    await tester.pumpAndSettle();

    await tester.tap(
      find.text('REQUEST'),
    );

    await tester.pumpAndSettle();

    expect(find.text(getPokemonResponse['name']), findsOneWidget);
  });

  testWidgets("Main test 2", (WidgetTester tester) async {
    app.main();
    await binding.waitUntilFirstFrameRasterized;
    await tester.pumpAndSettle();

    await tester.tap(
      find.text('REQUEST'),
    );

    await tester.pumpAndSettle();

    expect(find.text('charmander'), findsOneWidget);
  });
}
