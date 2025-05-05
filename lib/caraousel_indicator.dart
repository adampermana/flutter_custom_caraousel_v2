part of './flutter_custom_caraousel_v2.dart';

/// Defines the available styles for carousel indicators
/// - [StyleIndicator.dotIndicator]: Shows Standard circular dots.
/// - [StyleIndicator.barIndicator]: Horizontal bars with customizable width.
/// - [StyleIndicator.circularIndicator]: Shows Circular indicators with border emphasis.
/// - [StyleIndicator.sequentialFillIndicator]: Shows Dots that fill up sequentially to the current position.
/// - [StyleIndicator.expandingDotIndicator]: Shows Dots that expand horizontally for the active item.
///
enum StyleIndicator {
  dotIndicator,
  barIndicator,
  circularIndicator,
  sequentialFillIndicator,
  expandingDotIndicator,
}

/// Base class for all carousel indicators
///
/// This abstract class provides common properties and functionality
/// that all carousel indicators should implement.
abstract class _BaseCarouselIndicator extends StatelessWidget {
  const _BaseCarouselIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.enableAnimation = true,
  });

  /// Total number of carousel items
  final int count;

  /// Current active index
  final int currentIndex;

  /// Color for the active indicator
  final Color? activeColor;

  /// Color for inactive indicators
  final Color? inactiveColor;

  /// Whether to enable animation when indicators change state
  final bool enableAnimation;

  @override
  Widget build(BuildContext context);
}

/// Main carousel indicator that supports multiple styles
///
/// This class serves as a factory for creating different indicator styles
class CarouselIndicator extends _BaseCarouselIndicator {
  const CarouselIndicator({
    required this.styleIndicator,
    super.key,
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.size = 8.0,
    this.spacing = 8.0,
    this.activeSize,
    this.width,
    this.height,
    this.activeWidth,
    this.borderRadius,
    this.borderWidth,
    this.dotHeight,
    this.dotWidth,
    this.activeDotWidth,
  });

  /// The style of indicator to use
  final StyleIndicator styleIndicator;

  /// Base size for indicators
  final double size;

  /// Spacing between indicators
  final double spacing;

  /// Size of the active indicator for dotIndicator
  final double? activeSize;

  /// Width for barIndicator
  final double? width;

  /// Height for barIndicator
  final double? height;

  /// Width of active indicator for barIndicator
  final double? activeWidth;

  /// Border radius for barIndicator
  final BorderRadius? borderRadius;

  /// Border width for circularIndicator
  final double? borderWidth;

  /// Height of dots for expandingDotIndicator
  final double? dotHeight;

  /// Width of dots for expandingDotIndicator
  final double? dotWidth;

  /// Width of active dot for expandingDotIndicator
  final double? activeDotWidth;

  @override
  Widget build(BuildContext context) {
    switch (styleIndicator) {
      case StyleIndicator.dotIndicator:
        return _CarouselDotIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          size: size,
          spacing: spacing,
          activeSize: activeSize ?? size * 1.5,
        );

      case StyleIndicator.barIndicator:
        return _CarouselBarIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          width: width ?? 20.0,
          height: height ?? 4.0,
          activeWidth: activeWidth ?? 32.0,
          spacing: spacing,
          borderRadius: borderRadius,
        );

      case StyleIndicator.circularIndicator:
        return _CircularIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          size: size,
          spacing: spacing,
          borderWidth: borderWidth ?? 2.0,
        );

      case StyleIndicator.sequentialFillIndicator:
        return _SequentialFillIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          size: size,
          spacing: spacing,
        );

      case StyleIndicator.expandingDotIndicator:
        return _ExpandingDotIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          dotHeight: dotHeight ?? 8.0,
          dotWidth: dotWidth ?? 8.0,
          activeDotWidth: activeDotWidth ?? 24.0,
          spacing: spacing,
        );
    }
  }
}

/// Standard dot indicator for carousels
class _CarouselDotIndicator extends _BaseCarouselIndicator {
  const _CarouselDotIndicator({
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.size = 8.0,
    this.spacing = 8.0,
    this.activeSize = 12.0,
  });

  /// Size of inactive indicators
  final double size;

  /// Size of the active indicator
  final double activeSize;

  /// Spacing between indicators
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurface.withAlpha(61);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: enableAnimation
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isActive ? activeSize : size,
                  width: isActive ? activeSize : size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                  ),
                )
              : Container(
                  height: isActive ? activeSize : size,
                  width: isActive ? activeSize : size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                  ),
                ),
        );
      }),
    );
  }
}

/// Bar style indicator for carousels
class _CarouselBarIndicator extends _BaseCarouselIndicator {
  const _CarouselBarIndicator({
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.width = 20.0,
    this.height = 4.0,
    this.activeWidth = 32.0,
    this.spacing = 8.0,
    this.borderRadius,
  });

  /// Width of inactive indicators
  final double width;

  /// Width of the active indicator
  final double activeWidth;

  /// Height of all indicators
  final double height;

  /// Spacing between indicators
  final double spacing;

  /// Border radius for indicators
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurface.withAlpha(61);
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(height / 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: enableAnimation
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? activeWidth : width,
                  height: height,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    borderRadius: effectiveBorderRadius,
                  ),
                )
              : Container(
                  width: isActive ? activeWidth : width,
                  height: height,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    borderRadius: effectiveBorderRadius,
                  ),
                ),
        );
      }),
    );
  }
}

/// Circular indicator with border for carousels
class _CircularIndicator extends _BaseCarouselIndicator {
  const _CircularIndicator({
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.size = 10.0,
    this.spacing = 8.0,
    this.borderWidth = 2.0,
  });

  /// Size of all indicators
  final double size;

  /// Spacing between indicators
  final double spacing;

  /// Border width for active indicator
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurface.withAlpha(61);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: enableAnimation
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isActive ? effectiveActiveColor : Colors.transparent,
                      width: borderWidth,
                    ),
                  ),
                )
              : Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isActive ? effectiveActiveColor : Colors.transparent,
                      width: borderWidth,
                    ),
                  ),
                ),
        );
      }),
    );
  }
}

/// Sequential fill indicator for carousels (fills dots up to current index)
class _SequentialFillIndicator extends _BaseCarouselIndicator {
  const _SequentialFillIndicator({
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.size = 8.0,
    this.spacing = 8.0,
  });

  /// Size of all indicators
  final double size;

  /// Spacing between indicators
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurface.withAlpha(61);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index <= currentIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: enableAnimation
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                  ),
                )
              : Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    shape: BoxShape.circle,
                  ),
                ),
        );
      }),
    );
  }
}

/// A customizable animated indicator that expands the active dot
class _ExpandingDotIndicator extends _BaseCarouselIndicator {
  const _ExpandingDotIndicator({
    required super.count,
    required super.currentIndex,
    super.activeColor,
    super.inactiveColor,
    super.enableAnimation = true,
    this.dotHeight = 8.0,
    this.dotWidth = 8.0,
    this.activeDotWidth = 24.0,
    this.spacing = 8.0,
  });

  /// Height of all indicators
  final double dotHeight;

  /// Width of inactive indicators
  final double dotWidth;

  /// Width of active indicator
  final double activeDotWidth;

  /// Spacing between indicators
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurface.withAlpha(61);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: enableAnimation
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: dotHeight,
                  width: isActive ? activeDotWidth : dotWidth,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    borderRadius: BorderRadius.circular(dotHeight / 2),
                  ),
                )
              : Container(
                  height: dotHeight,
                  width: isActive ? activeDotWidth : dotWidth,
                  decoration: BoxDecoration(
                    color: isActive
                        ? effectiveActiveColor
                        : effectiveInactiveColor,
                    borderRadius: BorderRadius.circular(dotHeight / 2),
                  ),
                ),
        );
      }),
    );
  }
}
