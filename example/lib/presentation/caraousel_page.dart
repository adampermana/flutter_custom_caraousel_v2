part of '../main.dart';

// 1. Standard Carousel Demo
class StandardCarouselDemo extends StatefulWidget {
  const StandardCarouselDemo({super.key});

  @override
  State<StandardCarouselDemo> createState() => _StandardCarouselDemoState();
}

class _StandardCarouselDemoState extends State<StandardCarouselDemo> {
  final CarouselControllerv2 _carouselController =
      CarouselControllerv2(initialItem: 0);
  int _currentIndex = 0; // Untuk melacak indeks saat ini
  @override
  void initState() {
    super.initState();

    // Opsional: Mendengarkan perubahan posisi pada controller
    // untuk mengupdate _currentIndex
    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Carousel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: kIsWeb ? height / 1.8 : 220),
            child: CarouselViewV2(
              controller: _carouselController,
              itemExtent: kIsWeb ? width * 0.6 : width * 0.9,
              isWeb: kIsWeb,
              indicator: CarouselIndicator(
                styleIndicator: StyleIndicator.dotIndicator,
                count: DemoData.items.length,
                currentIndex:
                    _currentIndex, // kamu bisa ubah agar dinamis jika perlu
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped on ${DemoData.items[index].title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              children: buildCarouselItems(DemoData.items),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Text(
              'Standard carousel displays items of the same size.'
              'This is the most common type of carousel and is similar to a horizontal ListView.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Weighted Carousel Demo
class WeightedCarouselDemo extends StatefulWidget {
  const WeightedCarouselDemo({super.key});

  @override
  State<WeightedCarouselDemo> createState() => _WeightedCarouselDemoState();
}

class _WeightedCarouselDemoState extends State<WeightedCarouselDemo> {
  final CarouselControllerv2 _carouselController =
      CarouselControllerv2(initialItem: 0);
  int _selectedWeightIndex = 0;
  int _currentIndex = 0;

  final List<List<int>> _weightOptions = [
    [1, 3, 1],
    [1, 2, 3, 2, 1],
    [1, 2, 1],
    [2, 5, 2],
  ];

  final List<String> _weightLabels = [
    'Hero [1, 3, 1]',
    'Multi-browse [1, 2, 3, 2, 1]',
    'Simple [1, 2, 1]',
    'Emphasis [2, 5, 2]',
  ];

  @override
  void initState() {
    super.initState();
    // Dengarkan perubahan posisi carousel dari controller
    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weighted Carousel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Weight Distribution:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weightOptions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return ChoiceChip(
                        label: Text(_weightLabels[index]),
                        selected: _selectedWeightIndex == index,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedWeightIndex = index;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Carousel dengan bobot berbeda
          Expanded(
            child: CarouselViewV2.weighted(
              controller: _carouselController,
              isWeb: kIsWeb,
              flexWeights: _weightOptions[_selectedWeightIndex],
              indicator: CarouselIndicator(
                styleIndicator: StyleIndicator.dotIndicator,
                count: DemoData.items.length,
                currentIndex: _currentIndex,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
              onTap: (index) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped on ${DemoData.items[index].title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              children: buildCarouselItems(DemoData.items),
            ),
          ),

          // Deskripsi
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Text(
              'Weighted carousels display items of varying sizes according to weight.'
              'This allows for more dynamic layouts such as Hero or Multi-browse.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// 3. AutoPlay Demo
class AutoPlayDemo extends StatefulWidget {
  const AutoPlayDemo({super.key});

  @override
  State<AutoPlayDemo> createState() => _AutoPlayDemoState();
}

class _AutoPlayDemoState extends State<AutoPlayDemo> {
  bool _autoPlay = true;
  Duration _interval = const Duration(seconds: 3);
  int _currentIndex = 0;
  final CarouselControllerv2 _carouselController =
      CarouselControllerv2(initialItem: 0);

  @override
  void initState() {
    super.initState();

    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoPlay Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: kIsWeb ? height / 1 : 220),
              child: CarouselViewV2(
                itemExtent: kIsWeb ? width * 0.7 : 300,
                controller: _carouselController,
                autoPlay: _autoPlay,
                isWeb: kIsWeb,
                autoPlayInterval: _interval,
                indicator: CarouselIndicator(
                  styleIndicator: StyleIndicator.expandingDotIndicator,
                  count: DemoData.items.length,
                  currentIndex: _currentIndex,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                ),
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped on ${DemoData.items[index].title}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                children: buildCarouselItems(DemoData.items),
              ),
            ),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                // AutoPlay toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('AutoPlay:'),
                    Switch(
                      value: _autoPlay,
                      onChanged: (value) {
                        setState(() {
                          _autoPlay = value;
                        });
                      },
                    ),
                  ],
                ),

                // Interval selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Interval:'),
                    DropdownButton<Duration>(
                      value: _interval,
                      onChanged: (Duration? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _interval = newValue;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: Duration(seconds: 1),
                          child: Text('1 seconds'),
                        ),
                        DropdownMenuItem(
                          value: Duration(seconds: 2),
                          child: Text('2 seconds'),
                        ),
                        DropdownMenuItem(
                          value: Duration(seconds: 3),
                          child: Text('3 seconds'),
                        ),
                        DropdownMenuItem(
                          value: Duration(seconds: 5),
                          child: Text('5 seconds'),
                        ),
                      ],
                    ),
                  ],
                ),

                // Status message
                Text(
                  'Slide ${_currentIndex + 1} from ${DemoData.items.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _currentIndex > 0
                          ? () {
                              _carouselController.animateToItem(
                                _currentIndex - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                _currentIndex--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _currentIndex < DemoData.items.length - 1
                          ? () {
                              _carouselController.animateToItem(
                                _currentIndex + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                _currentIndex++;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Indicator Styles Demo
class IndicatorStylesDemo extends StatefulWidget {
  const IndicatorStylesDemo({super.key});

  @override
  State<IndicatorStylesDemo> createState() => _IndicatorStylesDemoState();
}

class _IndicatorStylesDemoState extends State<IndicatorStylesDemo> {
  int _currentIndex = 0;
  StyleIndicator _currentStyle = StyleIndicator.dotIndicator;
  final CarouselControllerv2 _carouselController = CarouselControllerv2();

  @override
  void initState() {
    super.initState();

    // Opsional: Mendengarkan perubahan posisi pada controller
    // untuk mengupdate _currentIndex
    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicator Styles'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Style selector
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Indicator Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStyleOption(StyleIndicator.dotIndicator, 'Dot'),
                      const SizedBox(width: 8),
                      _buildStyleOption(StyleIndicator.barIndicator, 'Bar'),
                      const SizedBox(width: 8),
                      _buildStyleOption(
                          StyleIndicator.circularIndicator, 'Circular'),
                      const SizedBox(width: 8),
                      _buildStyleOption(
                          StyleIndicator.sequentialFillIndicator, 'Sequential'),
                      const SizedBox(width: 8),
                      _buildStyleOption(
                          StyleIndicator.expandingDotIndicator, 'Expanding'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Carousel with indicator
          Expanded(
            child: CarouselViewV2(
              itemExtent: 300,
              controller: _carouselController,
              indicator: CarouselIndicator(
                styleIndicator: _currentStyle,
                count: DemoData.items.length,
                currentIndex: _currentIndex,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: buildCarouselItems(DemoData.items),
            ),
          ),

          // Preview of all indicator styles
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Preview all types of indicators:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Show all indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildIndicatorPreview(
                        StyleIndicator.dotIndicator,
                        'Dot',
                      ),
                    ),
                    Expanded(
                      child: _buildIndicatorPreview(
                        StyleIndicator.barIndicator,
                        'Bar',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildIndicatorPreview(
                        StyleIndicator.circularIndicator,
                        'Circular',
                      ),
                    ),
                    Expanded(
                      child: _buildIndicatorPreview(
                        StyleIndicator.sequentialFillIndicator,
                        'Sequential',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildIndicatorPreview(
                  StyleIndicator.expandingDotIndicator,
                  'Expanding',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleOption(StyleIndicator style, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _currentStyle == style,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _currentStyle = style;
          });
        }
      },
    );
  }

  Widget _buildIndicatorPreview(StyleIndicator style, String label) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        CarouselIndicator(
          styleIndicator: style,
          count: 5,
          currentIndex: 2,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Colors.grey.withOpacity(0.5),
          size: 6,
          spacing: 4,
        ),
      ],
    );
  }
}

// 5. Controller Demo
class ControllerDemo extends StatefulWidget {
  const ControllerDemo({super.key});

  @override
  State<ControllerDemo> createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo> {
  final CarouselControllerv2 _carouselController = CarouselControllerv2();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Listen to controller changes
    _carouselController.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _carouselController.removeListener(_onControllerChanged);
    _carouselController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (_carouselController.hasClients &&
        _carouselController.currentItem != null) {
      setState(() {
        _currentIndex = _carouselController.currentItem!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Carousel with controller
          Expanded(
            child: CarouselViewV2(
              itemExtent: kIsWeb ? width * 0.7 : 300,
              isWeb: kIsWeb,
              controller: _carouselController,
              indicator: CarouselIndicator(
                styleIndicator: StyleIndicator.dotIndicator,
                count: DemoData.items.length,
                currentIndex: _currentIndex,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: buildCarouselItems(DemoData.items),
            ),
          ),

          // Advanced controller options
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Text(
                  'Slide ${_currentIndex + 1} dari ${DemoData.items.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 16),

                // Basic navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _currentIndex > 0
                          ? () {
                              _carouselController.animateToItem(
                                _currentIndex - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _currentIndex < DemoData.items.length - 1
                          ? () {
                              _carouselController.animateToItem(
                                _currentIndex + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Jump and animate options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _carouselController.jumpToItem(0);
                      },
                      child: const Text('Jump to First'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _carouselController
                            .jumpToItem(DemoData.items.length - 1);
                      },
                      child: const Text('Jump to Last'),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _carouselController.animateToItem(
                          0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Animate to First'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _carouselController.animateToItem(
                          DemoData.items.length - 1,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Animate to Last'),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Random navigation
                ElevatedButton.icon(
                  onPressed: () {
                    final random = DateTime.now().millisecondsSinceEpoch %
                        DemoData.items.length;
                    _carouselController.animateToItem(
                      random,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.shuffle),
                  label: const Text('Random Item'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 6. Layout Variations Demo
class LayoutVariationsDemo extends StatefulWidget {
  const LayoutVariationsDemo({super.key});

  @override
  State<LayoutVariationsDemo> createState() => _LayoutVariationsDemoState();
}

enum LayoutType {
  hero,
  multiBrowse,
  fullScreen,
}

class _LayoutVariationsDemoState extends State<LayoutVariationsDemo> {
  LayoutType _currentLayout = LayoutType.hero;
  int _currentIndex = 0;
  final CarouselControllerv2 _carouselController = CarouselControllerv2();

  @override
  void initState() {
    super.initState();

    // Opsional: Mendengarkan perubahan posisi pada controller
    // untuk mengupdate _currentIndex
    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Variations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Layout selector
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Layout Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      _buildLayoutOption(LayoutType.hero, 'Hero'),
                      const SizedBox(width: 8),
                      _buildLayoutOption(
                          LayoutType.multiBrowse, 'Multi-Browse'),
                      const SizedBox(width: 8),
                      _buildLayoutOption(LayoutType.fullScreen, 'Full-Screen'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getLayoutDescription(),
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Carousel with selected layout
          Expanded(
            child: _buildCurrentLayoutCarousel(),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _currentIndex > 0
                      ? () {
                          _carouselController.animateToItem(
                            _currentIndex - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            _currentIndex--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 16),
                Text(
                  'Slide ${_currentIndex + 1} dari ${DemoData.items.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _currentIndex < DemoData.items.length - 1
                      ? () {
                          _carouselController.animateToItem(
                            _currentIndex + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            _currentIndex++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutOption(LayoutType type, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _currentLayout == type,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _currentLayout = type;
            _currentIndex = 0;
            if (_carouselController.hasClients) {
              _carouselController.jumpToItem(0);
            }
          });
        }
      },
    );
  }

  String _getLayoutDescription() {
    switch (_currentLayout) {
      case LayoutType.hero:
        return 'Hero: One large item in the middle with small items next to it [2, 3, 2]';
      case LayoutType.multiBrowse:
        return 'Multi-Browse: Multiple items with varying sizes [3, 5, 5, 3]';
      case LayoutType.fullScreen:
        return 'Full-Screen: Only one item is visible on the full screen [1]';
    }
  }

  Widget _buildCurrentLayoutCarousel() {
    switch (_currentLayout) {
      case LayoutType.hero:
        return CarouselViewV2.weighted(
          flexWeights: const [2, 3, 2],
          controller: _carouselController,
          isWeb: kIsWeb,
          indicator: CarouselIndicator(
            styleIndicator: StyleIndicator.dotIndicator,
            count: DemoData.items.length,
            currentIndex: _currentIndex,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Colors.grey.withOpacity(0.5),
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: buildCarouselItems(DemoData.items),
        );

      case LayoutType.multiBrowse:
        return CarouselViewV2.weighted(
          flexWeights: const [3, 5, 5, 3],
          controller: _carouselController,
          isWeb: kIsWeb,
          indicator: CarouselIndicator(
            styleIndicator: StyleIndicator.dotIndicator,
            count: DemoData.items.length,
            currentIndex: _currentIndex,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Colors.grey.withOpacity(0.5),
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: buildCarouselItems(DemoData.items),
        );

      case LayoutType.fullScreen:
        return CarouselViewV2.weighted(
          flexWeights: const [1],
          controller: _carouselController,
          isWeb: kIsWeb,
          indicator: CarouselIndicator(
            styleIndicator: StyleIndicator.dotIndicator,
            count: DemoData.items.length,
            currentIndex: _currentIndex,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Colors.grey.withOpacity(0.5),
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: buildCarouselItems(DemoData.items),
        );
    }
  }
}

// 7. Custom Demo (Uncontained Layout - like provided screenshots)
class CustomDemo extends StatefulWidget {
  const CustomDemo({super.key});

  @override
  State<CustomDemo> createState() => _CustomDemoState();
}

class _CustomDemoState extends State<CustomDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CarouselControllerv2 _carouselController = CarouselControllerv2();
  int _currentShowIndex = 0;

  final List<Map<String, dynamic>> _homeItems = [
    {
      'icon': Icons.camera,
      'title': 'Cameras',
      'color': Colors.blue.shade100,
    },
    {
      'icon': Icons.lightbulb,
      'title': 'Lighting',
      'color': Colors.amber.shade50,
    },
    {
      'icon': Icons.thermostat,
      'title': 'Climate',
      'color': Colors.red.shade50,
    },
    {
      'icon': Icons.wifi,
      'title': 'WiFi',
      'color': Colors.green.shade50,
    },
    {
      'icon': Icons.tv,
      'title': 'Media',
      'color': Colors.indigo.shade50,
    },
    {
      'icon': Icons.lock,
      'title': 'Security',
      'color': Colors.purple.shade50,
    },
    {
      'icon': Icons.speaker,
      'title': 'Audio',
      'color': Colors.deepOrange.shade50,
    },
    {
      'icon': Icons.kitchen,
      'title': 'Appliances',
      'color': Colors.cyan.shade50,
    },
    {
      'icon': Icons.bolt,
      'title': 'Energy',
      'color': Colors.yellow.shade50,
    },
    {
      'icon': Icons.water_damage,
      'title': 'Water Leak',
      'color': Colors.lightBlue.shade50,
    },
    {
      'icon': Icons.bed,
      'title': 'Bedroom',
      'color': Colors.pink.shade50,
    },
    {
      'icon': Icons.garage,
      'title': 'Garage',
      'color': Colors.brown.shade50,
    },
  ];

  final List<String> _shows = [
    'Show 0',
    'Show 1',
    'Show 2',
    'Show 3',
    'Show 4',
    'Show 5',
    'Show 6',
    'Show 7',
    'Show 8',
    'Show 9',
    'Show 10',
    'Show 11',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add listener to carousel controller to update indicator
    _carouselController.addListener(() {
      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentShowIndex) {
        setState(() {
          _currentShowIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up resources to prevent memory leaks
    _tabController.dispose();
    _carouselController.removeListener(() {});
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Carousel Demos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Multi-browse Layout'),
            Tab(text: 'Uncontained Layout'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMultiBrowseDemo(),
          _buildUncontainedDemo(),
        ],
      ),
    );
  }

  // Multi-browse layout similar to Image 1
  Widget _buildMultiBrowseDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Featured shows with multi-browse layout (big middle item)
        SizedBox(
          height: 180,
          child: CarouselViewV2.weighted(
            isWeb: kIsWeb,
            flexWeights: const [2, 4, 2],
            children: [
              _buildFeaturedItem('The\nGarden', Colors.green.shade100),
              _buildFeaturedItem('Through\nthe Pane', Colors.grey.shade100),
              _buildFeaturedItem('Iridescent\nLight', Colors.pink.shade100),
              _buildFeaturedItem('Whispers\nof Dawn', Colors.blue.shade100),
              _buildFeaturedItem('Echoes\nin Mist', Colors.indigo.shade100),
              _buildFeaturedItem('Refraction\nDreams', Colors.amber.shade100),
              _buildFeaturedItem('Silent\nSymphony', Colors.teal.shade100),
              _buildFeaturedItem(
                  'Twilight\nMemoirs', Colors.deepOrange.shade100),
              _buildFeaturedItem('Golden\nPathways', Colors.lime.shade100),
              _buildFeaturedItem('Frozen\nElegy', Colors.cyan.shade100),
              _buildFeaturedItem('Shattered\nReflections', Colors.red.shade100),
              _buildFeaturedItem('Serenity\nBound', Colors.purple.shade100),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Multi-browse layout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Color pills with varied weights
        SizedBox(
          height: 40,
          child: CarouselViewV2.weighted(
            flexWeights: const [3, 5, 7, 5, 3],
            isWeb: kIsWeb,
            shrinkExtent: 20,
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.pink.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Bottom grid layout (shown in screenshot 1)
        SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Uncontained layout similar to Image 2
  Widget _buildUncontainedDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Icon grid in uncontained layout
        SizedBox(
          height: 120,
          child: CarouselViewV2(
            itemExtent: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: _homeItems
                .map((item) => _buildIconItem(
                      item['icon'] as IconData,
                      item['title'] as String,
                      item['color'] as Color,
                    ))
                .toList(),
          ),
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Uncontained layout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Show cards in uncontained layout with properly connected controller and indicator
        SizedBox(
          height: 150,
          child: CarouselViewV2(
            itemExtent: 200,
            isWeb: kIsWeb,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            controller: _carouselController,
            indicator: CarouselIndicator(
              styleIndicator: StyleIndicator.dotIndicator,
              count: _shows.length,
              currentIndex: _currentShowIndex,
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: Colors.grey.withOpacity(0.5),
            ),
            onTap: (index) {
              setState(() {
                _currentShowIndex = index;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected ${_shows[index]}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            children: _shows.map((title) => _buildShowCard(title)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedItem(String title, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sponsored | Season 1 | Now Streaming',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(IconData icon, String title, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.black.withOpacity(0.6)),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowCard(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// 8. Vertical Carousel Demo
class VerticalCarouselDemo extends StatefulWidget {
  const VerticalCarouselDemo({super.key});

  @override
  State<VerticalCarouselDemo> createState() => _VerticalCarouselDemoState();
}

class _VerticalCarouselDemoState extends State<VerticalCarouselDemo> {
  int _currentIndex = 0;
  late final CarouselControllerv2 _carouselController;
  bool _isControllerReady = false;

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselControllerv2(initialItem: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isControllerReady = true;
        });

        _setupControllerListener();
      }
    });
  }

  void _setupControllerListener() {
    _carouselController.addListener(() {
      if (!mounted) return;

      if (_carouselController.hasClients &&
          _carouselController.currentItem != null &&
          _carouselController.currentItem != _currentIndex) {
        setState(() {
          _currentIndex = _carouselController.currentItem!;
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Carousel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: isSmallScreen
            ? _buildVerticalLayout(screenSize)
            : _buildHorizontalLayout(screenSize),
      ),
    );
  }

  Widget _buildVerticalLayout(Size screenSize) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: CarouselViewV2(
            itemExtent: screenSize.height * 0.6,
            isWeb: kIsWeb,
            scrollDirection: Axis.vertical,
            controller: _carouselController,
            onTap: _isControllerReady
                ? (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                : null,
            children: _buildCarouselItems(isVertical: true),
          ),
        ),

        // Panel kontrol di bagian bawah
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _isControllerReady && _currentIndex > 0
                    ? () => _navigateToItem(_currentIndex - 1)
                    : null,
                icon: const Icon(Icons.arrow_upward),
              ),
              Expanded(
                child: CarouselIndicator(
                  styleIndicator: StyleIndicator.dotIndicator,
                  count: DemoData.items.length,
                  currentIndex: _currentIndex,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                ),
              ),
              IconButton(
                onPressed: _isControllerReady &&
                        _currentIndex < DemoData.items.length - 1
                    ? () => _navigateToItem(_currentIndex + 1)
                    : null,
                icon: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout(Size screenSize) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CarouselViewV2(
            itemExtent: screenSize.height * 0.7,
            isWeb: kIsWeb,
            scrollDirection: Axis.vertical,
            controller: _carouselController,
            onTap: _isControllerReady
                ? (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                : null,
            children: _buildCarouselItems(isVertical: true),
          ),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Colors.grey.shade100,
          child: Column(
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: CarouselIndicator(
                  styleIndicator: StyleIndicator.dotIndicator,
                  count: DemoData.items.length,
                  currentIndex: _currentIndex,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                ),
              ),

              const SizedBox(height: 24),

              // Informasi item saat ini
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'Item ${_currentIndex + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              // Tombol naik
              IconButton(
                onPressed: _isControllerReady && _currentIndex > 0
                    ? () => _navigateToItem(_currentIndex - 1)
                    : null,
                icon: const Icon(Icons.arrow_upward),
              ),

              const SizedBox(height: 16),

              IconButton(
                onPressed: _isControllerReady &&
                        _currentIndex < DemoData.items.length - 1
                    ? () => _navigateToItem(_currentIndex + 1)
                    : null,
                icon: const Icon(Icons.arrow_downward),
              ),

              const SizedBox(height: 24),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                tooltip: 'Kembali ke Halaman Utama',
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToItem(int index) {
    if (!_isControllerReady || !mounted) return;

    try {
      _carouselController.animateToItem(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {
        _currentIndex = index;
      });
    } catch (e) {
      debugPrint('Error navigating to item: $e');
      if (mounted) {
        setState(() {
          _currentIndex = _carouselController.currentItem ?? 0;
        });
      }
    }
  }

  List<Widget> _buildCarouselItems({required bool isVertical}) {
    return DemoData.items.map((item) {
      return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: isVertical ? 64 : 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

// Additional Demo: Image Carousel (using NetworkImage placeholders)
class ImageCarouselDemo extends StatefulWidget {
  const ImageCarouselDemo({super.key});

  @override
  State<ImageCarouselDemo> createState() => _ImageCarouselDemoState();
}

class _ImageCarouselDemoState extends State<ImageCarouselDemo> {
  int _currentIndex = 0;
  final CarouselControllerv2 _carouselController = CarouselControllerv2();

  // Placeholder image URLs (replace with actual images in production)
  final List<String> _imageUrls = [
    'https://via.placeholder.com/600x400/6E9FED/FFFFFF?text=Mountain+View',
    'https://via.placeholder.com/600x400/F5A623/FFFFFF?text=Beach+Sunset',
    'https://via.placeholder.com/600x400/4CAF50/FFFFFF?text=Forest+Trail',
    'https://via.placeholder.com/600x400/9C27B0/FFFFFF?text=City+Skyline',
    'https://via.placeholder.com/600x400/FF5722/FFFFFF?text=Desert+View',
  ];

  // Image captions
  final List<String> _captions = [
    'Beautiful mountain ranges with snow-capped peaks',
    'Stunning sunset over the horizon at the beach',
    'Dense forest with tall trees and lush greenery',
    'Vibrant city skyline with modern architecture',
    'Vast desert landscape with golden sand dunes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Carousel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselViewV2(
              itemExtent: MediaQuery.of(context).size.width,
              controller: _carouselController,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              indicator: CarouselIndicator(
                styleIndicator: StyleIndicator.expandingDotIndicator,
                count: _imageUrls.length,
                currentIndex: _currentIndex,
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.5),
              ),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _buildImageItems(),
            ),
          ),

          // Caption area
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black87,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Image ${_currentIndex + 1}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _captions[_currentIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageItems() {
    return _imageUrls.map((url) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
