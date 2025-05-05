## 0.2.0 - 05/05/2025
* Updates minimum supported SDK version to Flutter 3.19.0/Dart 3.3.0
* General compatibility improvements.

## 0.1.1 - 05/03/2025
### Bug Fixes and Package Improvements
* Fixed static analysis issues by replacing deprecated `withOpacity()` with `withAlpha()` to avoid precision loss warnings
* Shortened package description to meet pub.dev validation requirements (under 180 characters)
* Improved package score on pub.dev

## 0.1.0 - 05/03/2025

### intial Release of Flutter Custom Carousel V2
* Implemented core carousel functionality based on Material Design 3 principles
* Added support for multiple layout models:
  * Uncontained layout (default)
  * Hero layout
  * Multi-browse layout
  * Full-screen layout
* Introduced weighted layout system with flexible item sizing via `flexWeights` parameter
* Added comprehensive controller API (CarouselControllerv2) for programmatic navigation
* Implemented five indicator styles:
  * Dot indicator
  * Bar indicator
  * Circular indicator
  * Sequential fill indicator
  * Expanding dot indicator
* Added auto-play functionality with customizable intervals and pause-on-interaction
* Optimized handling for web platforms (mouse wheel and drag support)
* Added support for both horizontal and vertical scrolling
* Implemented item snapping capability with improved physics
* Added full customization options:
  * Item appearance (elevation, shape, background color)
  * Indicator properties (colors, sizes, spacing)
  * Transition animations
* Ensured cross-platform compatibility (Android, iOS, web, desktop, macOS, Linux)