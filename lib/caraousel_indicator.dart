part of './flutter_custom_caraousel_v2.dart';

// part of 'flutter_custom_caraousel_v2.dart';

enum StyleIndicator {
  dotIndicator,
  barIndicator,
  circularIndicator,
  sequentialFillIndicator,
  expandingDotIndicator,
}

abstract class BaseCarouselIndicator extends StatelessWidget {
  const BaseCarouselIndicator({
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

class CarouselIndicator extends BaseCarouselIndicator {
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
        return CarouselDotIndicator(
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
        return CarouselBarIndicator(
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
        return CircularIndicator(
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
        return SequentialFillIndicator(
          count: count,
          currentIndex: currentIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          enableAnimation: enableAnimation,
          size: size,
          spacing: spacing,
        );

      case StyleIndicator.expandingDotIndicator:
        return ExpandingDotIndicator(
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
class CarouselDotIndicator extends BaseCarouselIndicator {
  const CarouselDotIndicator({
    super.key,
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
class CarouselBarIndicator extends BaseCarouselIndicator {
  const CarouselBarIndicator({
    super.key,
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
class CircularIndicator extends BaseCarouselIndicator {
  const CircularIndicator({
    super.key,
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
class SequentialFillIndicator extends BaseCarouselIndicator {
  const SequentialFillIndicator({
    super.key,
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
class ExpandingDotIndicator extends BaseCarouselIndicator {
  const ExpandingDotIndicator({
    super.key,
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
