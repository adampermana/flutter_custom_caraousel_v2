# Flutter Custom Carousel v2

[![pub package](https://img.shields.io/pub/v/flutter_custom_caraousel_v2)](https://pub.dartlang.org/packages/flutter_custom_caraousel_v2)
[![likes](https://img.shields.io/pub/likes/flutter_custom_caraousel_v2)](https://pub.dev/packages/flutter_custom_caraousel_v2/score)
[![pub points](https://img.shields.io/pub/points/flutter_custom_caraousel_v2)](https://pub.dev/packages/flutter_custom_caraousel_v2/score)
[![GitHub stars](https://img.shields.io/github/stars/adampermana/flutter_custom_caraousel_v2?logo=github)](https://github.com/adampermana/flutter_custom_caraousel_v2/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/adampermana/flutter_custom_caraousel_v2?logo=github)](https://github.com/adampermana/flutter_custom_caraousel_v2/network)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A versatile, feature-rich carousel implementation for Flutter based on Material Design 3 principles. This package offers multiple carousel layouts, auto-play functionality, custom indicators, and complete controller capabilities.

## ☕ Support My Work
If you find my work valuable, your support means the world to me! It helps me focus on creating more, learning, and growing.
Thank you for your generosity and support! ☕

[![Sponsor](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/adampermana)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/adampermana)

## Demo

<h3>
<a href="https://adampermana.github.io/flutter_custom_caraousel_v2/" target="_blank">
  Click here to experience the demo in a Web App
</a>
</h3>


## Table of Contents

- [Support My Work](#support-my-work)
- [Features](#features)
- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Basic Carousel](#basic-carousel)
  - [Weighted Layout (Hero Style)](#weighted-layout-hero-style)
  - [With Indicators](#with-indicators)
  - [Auto Play](#auto-play)
  - [Using a Controller](#using-a-controller)
  - [Web Support](#web-support)
- [Indicator Styles](#indicator-styles)
- [Layout Models](#layout-models)
  - [Uncontained Layout](#uncontained-layout-default)
  - [Hero Layout](#hero-layout)
  - [Multi-browse Layout](#multi-browse-layout)
  - [Full-screen Layout](#full-screen-layout)
- [Customization](#customization)
  - [Carousel Properties](#carousel-properties)
  - [Indicator Properties](#indicator-properties)
- [Contributing](#contributing)
- [License](#license)
- [Activities](#activities)

## Features

- 📱 **Multiple Layouts**: Supports uncontained, hero, multi-browse, and full-screen layout models as defined in Material Design 3
- 🎮 **Full Controller**: Navigate programmatically between slides with animations
- 🔄 **Auto Play**: Built-in autoplay with customizable intervals and pause-on-interaction
- 🔵 **Beautiful Indicators**: 5 different indicator styles with full customization options
- 📏 **Dynamic Sizing**: Weighted layouts for diverse item sizes and transitions
- ↕️ **Axis Support**: Both horizontal and vertical scrolling
- 🌐 **Web Optimized**: Enhanced mouse wheel and drag interaction for web platforms

## Supported Platforms

- Flutter Android
- Flutter iOS
- Flutter web
- Flutter desktop
- Flutter macOS
- Flutter Linux

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_custom_caraousel_v2: ^1.0.0
```

## Quick Start

```dart
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';

// Basic carousel
CarouselViewV2(
  itemExtent: 300,
  autoPlay: true,
  indicator: CarouselIndicator(
    styleIndicator: StyleIndicator.dotIndicator,
    count: 3,
    currentIndex: 0,
  ),
  children: [
    Container(color: Colors.red, child: Center(child: Text('Slide 1'))),
    Container(color: Colors.blue, child: Center(child: Text('Slide 2'))),
    Container(color: Colors.green, child: Center(child: Text('Slide 3'))),
  ],
)
```

## Usage

### Basic Carousel

Create a basic carousel with fixed-size items:

```dart
CarouselViewV2(
  itemExtent: 300,
  onTap: (index) => print('Tapped on item $index'),
  children: yourItemsList,
)
```

### Weighted Layout (Hero Style)

Create a carousel with items of varying sizes:

```dart
CarouselViewV2.weighted(
  flexWeights: [1, 3, 1], // Middle item is 3x larger
  children: yourItemsList,
)
```

### With Indicators

Add indicators to show the current position:

```dart
CarouselViewV2(
  itemExtent: 300,
  indicator: CarouselIndicator(
    styleIndicator: StyleIndicator.dotIndicator,
    count: yourItemsList.length,
    currentIndex: 0, // Initial position
    activeColor: Colors.blue,
    inactiveColor: Colors.grey.withOpacity(0.5),
  ),
  children: yourItemsList,
)
```

### Auto Play

Enable auto-sliding functionality with pause on user interaction:

```dart
CarouselViewV2(
  itemExtent: 300,
  autoPlay: true,
  autoPlayInterval: const Duration(seconds: 3),
  children: yourItemsList,
)
```

### Using a Controller

Control the carousel programmatically:

```dart
// Create a controller
final carouselController = CarouselControllerv2(initialItem: 0);

// Use it with your carousel
CarouselViewV2(
  itemExtent: 300,
  controller: carouselController,
  children: yourItemsList,
)

// Later, navigate to a specific item
carouselController.animateToItem(
  2,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);

// Or jump instantly
carouselController.jumpToItem(3);

// Get the current item
int? currentIndex = carouselController.currentItem;
```

### Web Support

Enable optimized handling for web platforms:

```dart
CarouselViewV2(
  itemExtent: 300,
  isWeb: true, // Enables enhanced mouse wheel and drag interaction
  children: yourItemsList,
)
```

## Indicator Styles

Choose from 5 beautiful indicator styles:

1. **Dot Indicator** (`StyleIndicator.dotIndicator`)
   - Standard circular dots
   - Active dot can be larger than inactive dots

2. **Bar Indicator** (`StyleIndicator.barIndicator`)
   - Horizontal bars with customizable width
   - Active bar can be wider than inactive bars

3. **Circular Indicator** (`StyleIndicator.circularIndicator`)
   - Circular indicators with border emphasis
   - Active indicator has a distinctive border

4. **Sequential Fill Indicator** (`StyleIndicator.sequentialFillIndicator`)
   - Dots that fill up sequentially to the current position
   - All dots up to and including current position are active

5. **Expanding Dot Indicator** (`StyleIndicator.expandingDotIndicator`)
   - Dots that expand horizontally for the active item
   - Active dot stretches to a pill shape

## Layout Models

This carousel supports all Material Design 3 carousel layouts:

### Uncontained Layout (Default)

Items scroll to the edge of the container, similar to a standard ListView:

```dart
CarouselViewV2(
  itemExtent: 300,
  children: yourItemsList,
)
```

### Hero Layout

Shows at least one large and one small item at a time:

```dart
CarouselViewV2.weighted(
  flexWeights: [1, 5, 1],
  children: yourItemsList,
)
```

### Multi-browse Layout

Shows items of various sizes simultaneously:

```dart
CarouselViewV2.weighted(
  flexWeights: [1, 3, 2],
  children: yourItemsList,
)
```

### Full-screen Layout

Shows one edge-to-edge large item at a time:

```dart
// Horizontal full-screen
CarouselViewV2(
  itemExtent: MediaQuery.of(context).size.width,
  children: yourItemsList,
)

// Or with weighted layout
CarouselViewV2.weighted(
  flexWeights: [1], // Only one visible item
  children: yourItemsList,
)

// Vertical full-screen
CarouselViewV2(
  scrollDirection: Axis.vertical,
  itemExtent: MediaQuery.of(context).size.height,
  children: yourItemsList,
)
```

## Customization

### Carousel Properties

| Property           | Type                    | Description                                       |
| ------------------ | ----------------------- | ------------------------------------------------- |
| `itemExtent`       | `double`                | Size of each item (for standard layout)           |
| `flexWeights`      | `List<int>`             | Weight distribution for weighted layout           |
| `padding`          | `EdgeInsets`            | Padding around each item                          |
| `backgroundColor`  | `Color`                 | Background color for each item                    |
| `elevation`        | `double`                | Z-coordinate of each item                         |
| `shape`            | `ShapeBorder`           | Shape of each item's Material                     |
| `overlayColor`     | `WidgetStateProperty<Color?>` | Color for pressed/hovered/focused states    |
| `autoPlay`         | `bool`                  | Whether to auto-advance slides                    |
| `autoPlayInterval` | `Duration`              | Time between auto-advances                        |
| `indicator`        | `CarouselIndicator`     | Custom indicator widget                           |
| `scrollDirection`  | `Axis`                  | Horizontal or vertical scrolling                  |
| `onTap`            | `ValueChanged<int>`     | Callback when an item is tapped                   |
| `enableSplash`     | `bool`                  | Whether to show ink splash effect                 |
| `shrinkExtent`     | `double`                | Minimum size during scrolling transitions         |
| `itemSnapping`     | `bool`                  | Whether items snap into position                  |
| `reverse`          | `bool`                  | Whether to scroll in the reverse direction        |
| `isWeb`            | `bool`                  | Enable web-specific mouse wheel/drag optimization |
| `consumeMaxWeight` | `bool`                  | Whether collapsed items can expand to max size    |

### Indicator Properties

| Property          | Type             | Description                      |
| ----------------- | ---------------- | -------------------------------- |
| `styleIndicator`  | `StyleIndicator` | Type of indicator to display     |
| `count`           | `int`            | Total number of items            |
| `currentIndex`    | `int`            | Current active item index        |
| `activeColor`     | `Color`          | Color for active indicator       |
| `inactiveColor`   | `Color`          | Color for inactive indicators    |
| `enableAnimation` | `bool`           | Whether to animate state changes |
| `size`            | `double`         | Base size for indicators         |
| `spacing`         | `double`         | Spacing between indicators       |
| `activeSize`      | `double`         | Size for active dot indicator    |
| `width`           | `double`         | Width for bar indicator          |
| `height`          | `double`         | Height for bar indicator         |
| `activeWidth`     | `double`         | Width of active bar indicator    |
| `borderRadius`    | `BorderRadius`   | Border radius for bar indicator  |
| `borderWidth`     | `double`         | Border width for circular indicator |
| `dotHeight`       | `double`         | Height for expanding dot indicator |
| `dotWidth`        | `double`         | Width for inactive expanding dot |
| `activeDotWidth`  | `double`         | Width for active expanding dot   |

## Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.

## License

This package is available under the MIT License. See the LICENSE file for details.

## Activities

![Alt](https://repobeats.axiom.co/api/embed/841225761cb31adc7197f30708fd62f1bc210c6c.svg "Repobeats analytics image")

[pub]: https://pub.dev/packages/flutter_custom_caraousel_v2
[github]: https://github.com/adampermana
[releases]: https://github.com/adampermana/flutter_custom_caraousel_v2/releases
[repo]: https://github.com/adampermana/flutter_custom_caraousel_v2
[issues]: https://github.com/adampermana/flutter_custom_caraousel_v2/issues
[license]: https://github.com/adampermana/flutter_custom_caraousel_v2/blob/master/LICENSE
[pulls]: https://github.com/adampermana/flutter_custom_caraousel_v2/pulls