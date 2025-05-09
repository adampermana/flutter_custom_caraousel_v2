import 'package:flutter/material.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarouselView Tests', () {
    testWidgets('CarouselView renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselViewV2(
              itemExtent: 200,
              children: List.generate(
                5,
                (index) => Container(
                  color: Colors.blue,
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
      expect(find.text('Item 1'), findsOneWidget);
    });

    group('Carousel Indicators Tests', () {
      testWidgets('CarouselDotIndicator displays correct number of dots',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CarouselIndicator(
                count: 5,
                currentIndex: 2,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                styleIndicator: StyleIndicator.dotIndicator,
              ),
            ),
          ),
        );

        // Find all containers (dots)
        final dotsFinder = find.byType(Container);
        expect(dotsFinder, findsNWidgets(5));
      });

      testWidgets('CarouselView with indicator displays correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CarouselViewV2(
                itemExtent: 200,
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
                    color: Colors.blue,
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        // Find carousel content
        expect(find.text('Item 0'), findsOneWidget);

        // Find indicator
        expect(find.byType(CarouselIndicator), findsOneWidget);
      });
    });

    testWidgets('CarouselView with different indicator styles',
        (WidgetTester tester) async {
      // Test ExpandingDotIndicator
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselViewV2(
              itemExtent: 200,
              indicator: const CarouselIndicator(
                styleIndicator: StyleIndicator.expandingDotIndicator,
                count: 3,
                currentIndex: 1,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              children: List.generate(
                3,
                (index) => Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CarouselIndicator), findsOneWidget);

      // Test CircularIndicator
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselViewV2(
              itemExtent: 200,
              indicator: const CarouselIndicator(
                styleIndicator: StyleIndicator.circularIndicator,
                count: 3,
                currentIndex: 1,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              children: List.generate(
                3,
                (index) => Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CarouselIndicator), findsOneWidget);
    });
  });
}
