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

  /// Animates the controlled [CarouselView] to the given item index.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> animateToItem(
    int itemIndex, {
    required Duration duration,
    required Curve curve,
  }) async {
    if (!hasClients) {
      return;
    }

    final _CarouselPosition carouselPosition = position as _CarouselPosition;
    double pixel = carouselPosition.getPixelsFromItem(itemIndex.toDouble(),
        carouselPosition.flexWeights, carouselPosition.itemExtent);

    return animateTo(
      pixel,
      duration: duration,
      curve: curve,
    );
  }

  /// Jumps the controlled [CarouselView] to the given item index.
  ///
  /// This is an instantaneous movement to the given item.
  void jumpToItem(int itemIndex) {
    if (!hasClients) {
      return;
    }

    final _CarouselPosition carouselPosition = position as _CarouselPosition;
    double pixel = carouselPosition.getPixelsFromItem(itemIndex.toDouble(),
        carouselPosition.flexWeights, carouselPosition.itemExtent);

    jumpTo(pixel);
  }

  /// Returns the current visible item index
  int? get currentItem {
    if (!hasClients) {
      return null;
    }

    final _CarouselPosition carouselPosition = position as _CarouselPosition;
    return carouselPosition
        .getItemFromPixels(
            carouselPosition.pixels, carouselPosition.viewportDimension)
        .round();
  }
}
