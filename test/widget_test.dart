
import 'package:flutter_test/flutter_test.dart';
import 'package:clima_app/main.dart';

void main() {
  testWidgets('ClimaApp se inicia correctamente',
      (WidgetTester tester) async {

    await tester.pumpWidget(const ClimaApp());

    expect(find.text('CLIMA APP'), findsOneWidget);
    expect(find.text('Consulta el clima de cualquier ciudad'),
        findsOneWidget);
  });
}
