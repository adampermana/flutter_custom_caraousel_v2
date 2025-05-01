import 'package:flutter/material.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CarouselDemo(),
    );
  }
}

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({super.key});

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  // Buat controller untuk carousel
  final CarouselController _carouselController =
      CarouselController(initialItem: 1);
  int _currentIndex = 0; // Untuk melacak indeks saat ini

  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'Mountain Landscape',
      'color': Colors.blue,
      'icon': Icons.landscape,
    },
    {
      'title': 'Urban Cityscape',
      'color': Colors.orange,
      'icon': Icons.location_city,
    },
    {
      'title': 'Beach Sunset',
      'color': Colors.pink,
      'icon': Icons.beach_access,
    },
    {
      'title': 'Forest Adventure',
      'color': Colors.green,
      'icon': Icons.forest,
    },
    {
      'title': 'Desert Journey',
      'color': Colors.amber,
      'icon': Icons.terrain,
    },
  ];

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
        title: const Text('Carousel dengan Controller'),
      ),
      body: Column(
        children: [
          // Carousel dengan controller
          Expanded(
            flex: 3,
            child: CarouselView(
              itemExtent: 300, // Lebar item
              controller: _carouselController, // Gunakan controller
              autoPlay: true, // Aktifkan autoplay
              autoPlayInterval: const Duration(seconds: 3),
              indicator: CarouselIndicator(
                count: _carouselItems.length,
                style: StyleIndicator.dotIndicator,
                currentIndex: _currentIndex, // Gunakan _currentIndex
                activeColor: Colors.blue,
                inactiveColor: Colors.grey.withOpacity(0.5),
                size: 10.0,
                activeSize: 14.0,
                spacing: 8.0,
                enableAnimation: true,
              ),
              onTap: (index) {
                // Update state dan tampilkan pesan
                setState(() {
                  _currentIndex = index;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Anda mengklik slide ${index + 1}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              children: _buildCarouselItems(),
            ),
          ),

          // Kontrol untuk carousel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol previous
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex > 0) {
                      _carouselController.animateToItem(
                        _currentIndex - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_back),
                ),

                const SizedBox(width: 20),

                // Indikator posisi saat ini
                Text(
                  'Slide ${_currentIndex + 1} dari ${_carouselItems.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 20),

                // Tombol next
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex < _carouselItems.length - 1) {
                      _carouselController.animateToItem(
                        _currentIndex + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),

          // Tombol kontrol tambahan
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Pergi ke slide pertama
                    _carouselController.animateToItem(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Awal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Pergi ke slide tengah
                    _carouselController.animateToItem(
                      _carouselItems.length ~/ 2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Tengah'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Pergi ke slide terakhir
                    _carouselController.animateToItem(
                      _carouselItems.length - 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Akhir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCarouselItems() {
    return _carouselItems.map((item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: item['color'] as Color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                item['title'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
