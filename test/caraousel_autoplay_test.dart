import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';

void main() {
  testWidgets('Carousel stops autoplay when disabled',
      (WidgetTester tester) async {
    bool autoPlay = true;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: CarouselViewV2(
                      itemExtent: 200,
                      autoPlay: autoPlay,
                      autoPlayInterval: const Duration(seconds: 1),
                      children: List.generate(
                        5,
                        (index) => Container(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          child: Center(
                            child: Text('Item $index'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => autoPlay = !autoPlay),
                    child: Text(autoPlay ? 'Stop AutoPlay' : 'Start AutoPlay'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Initial state
    expect(find.text('Item 0'), findsOneWidget);

    // Wait for autoplay to trigger
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // After autoplay should show item 1
    expect(find.text('Item 1'), findsOneWidget);

    // Disable autoplay
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Wait for the same duration as before
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Should still show item 1 because autoplay is disabled
    expect(find.text('Item 1'), findsOneWidget);
  });
}
