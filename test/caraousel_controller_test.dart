import 'package:flutter/material.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CarouselController currentItem returns null when no clients',
      (WidgetTester tester) async {
    final controller = CarouselControllerv2();

    // Controller without any attached carousel should return null for currentItem
    expect(controller.currentItem, isNull);
  });

  testWidgets('CarouselController works with weighted carousel',
      (WidgetTester tester) async {
    final controller = CarouselControllerv2();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CarouselViewV2.weighted(
            flexWeights: const [1, 2, 1],
            controller: controller,
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

    await tester.pumpAndSettle();

    // Jump to item 3
    controller.jumpToItem(3);
    await tester.pumpAndSettle();

    // Check if the controller moved to the specified item
    expect(controller.currentItem, 3);
  });
}
