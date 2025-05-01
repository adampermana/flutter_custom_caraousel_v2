part of '../../flutter_custom_caraousel_v2.dart';

/// A controller for [CarouselView].
///
/// Using a carousel controller helps to show the first visible item on the
/// carousel list.
class CarouselController extends ScrollController {
  /// Creates a carousel controller.
  CarouselController({
    this.initialItem = 0,
  });

  /// The item that expands to the maximum size when first creating the [CarouselView].
  final int initialItem;

  CarouselViewState? _carouselState;

  // ignore: use_setters_to_change_properties
  void _attach(CarouselViewState anchor) {
    _carouselState = anchor;
  }

  void _detach(CarouselViewState anchor) {
    if (_carouselState == anchor) {
      _carouselState = null;
    }
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition? oldPosition) {
    assert(_carouselState != null);
    return _CarouselPosition(
      physics: physics,
      context: context,
      initialItem: initialItem,
      itemExtent: _carouselState!._itemExtent,
      consumeMaxWeight: _carouselState!._consumeMaxWeight,
      flexWeights: _carouselState!._flexWeights,
      oldPosition: oldPosition,
    );
  }

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    final _CarouselPosition carouselPosition = position as _CarouselPosition;
    carouselPosition.flexWeights = _carouselState!._flexWeights;
    carouselPosition.itemExtent = _carouselState!._itemExtent;
    carouselPosition.consumeMaxWeight = _carouselState!._consumeMaxWeight;
  }
}
