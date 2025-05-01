import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';

void main() {
  testWidgets('CarouselView with all indicator styles',
      (WidgetTester tester) async {
    for (final style in StyleIndicator.values) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CarouselViewV2(
                    itemExtent: 200,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CarouselIndicator(
                    styleIndicator: style,
                    count: 5,
                    currentIndex: 2,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the indicator is rendered
      expect(find.byType(CarouselIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    }
  });

  testWidgets('CarouselView with vertical scrolling',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CarouselViewV2(
            itemExtent: 200,
            scrollDirection: Axis.vertical,
            indicator: const CarouselIndicator(
              styleIndicator: StyleIndicator.dotIndicator,
              count: 5,
              currentIndex: 0,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            children: List.generate(
              5,
              (index) => Container(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Item 0'), findsOneWidget);

    // Simulate vertical scroll
    await tester.drag(find.byType(CarouselViewV2), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Item 1 should be visible after scrolling
    expect(find.text('Item 1'), findsOneWidget);
  });

  testWidgets('CarouselView responds to tap events',
      (WidgetTester tester) async {
    int tappedIndex = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CarouselViewV2(
            itemExtent: 200,
            onTap: (index) {
              tappedIndex = index;
            },
            children: List.generate(
              5,
              (index) => Container(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Tap on the first item
    await tester.tap(find.text('Item 0'));
    await tester.pumpAndSettle();

    // Verify the onTap callback was called with the correct index
    expect(tappedIndex, 0);
  });
}
