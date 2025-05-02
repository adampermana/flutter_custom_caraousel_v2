import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';

part 'presentation/caraousel_page.dart';

void main() {
  runApp(const CarouselDemoApp());
}

class CarouselDemoApp extends StatelessWidget {
  const CarouselDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Carousel V2 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CarouselDemoHomePage(),
    );
  }
}

class CarouselDemoHomePage extends StatelessWidget {
  const CarouselDemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Carousel Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDemoCard(
            context,
            title: 'Weighted Carousel',
            subtitle: 'Carousel with varying item sizes',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WeightedCarouselDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'AutoPlay Demo',
            subtitle: 'Carousel with autoplay feature',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AutoPlayDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Indicator Styles',
            subtitle: 'Different types of indicators for carousel',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IndicatorStylesDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Controller Demo',
            subtitle: 'Use of controllers for programmatic control',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ControllerDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Layout Variations',
            subtitle: 'Multi-browse, Hero, and Full-screen layouts',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LayoutVariationsDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Custom Demo',
            subtitle: 'Combination of features for special purposes',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomDemo()),
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Vertical Carousel',
            subtitle: 'Carousel with vertical scrolling',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerticalCarouselDemo()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

// Data untuk semua demos
class DemoData {
  static final List<CarouselItemData> items = [
    CarouselItemData(
      title: 'Mountains',
      description: 'Pemandangan pegunungan yang indah dengan udara segar',
      color: Colors.blue.shade800,
      icon: Icons.landscape,
    ),
    CarouselItemData(
      title: 'Beach',
      description: 'Pantai dengan pasir putih dan air laut yang jernih',
      color: Colors.orange.shade800,
      icon: Icons.beach_access,
    ),
    CarouselItemData(
      title: 'Forest',
      description: 'Hutan lebat dengan berbagai jenis flora dan fauna',
      color: Colors.green.shade800,
      icon: Icons.forest,
    ),
    CarouselItemData(
      title: 'Desert',
      description: 'Padang pasir luas dengan pemandangan matahari terbenam',
      color: Colors.amber.shade800,
      icon: Icons.terrain,
    ),
    CarouselItemData(
      title: 'City',
      description:
          'Pemandangan kota metropolitan dengan gedung pencakar langit',
      color: Colors.purple.shade800,
      icon: Icons.location_city,
    ),
    CarouselItemData(
      title: 'Lake',
      description: 'Danau tenang dengan air yang jernih di pegunungan',
      color: Colors.teal.shade800,
      icon: Icons.water,
    ),
    CarouselItemData(
      title: 'Modern City',
      description: 'Kota yang modern dan penuh teknologi',
      color: Colors.brown.shade800,
      icon: Icons.location_city_rounded,
    ),
    CarouselItemData(
      title: 'Village',
      description: 'Desa yang asri dengan suasana tenang dan damai',
      color: Colors.lightGreen.shade800,
      icon: Icons.home,
    ),
    CarouselItemData(
      title: 'Cave',
      description: 'Gua tersembunyi yang eksotis dan misterius',
      color: Colors.grey.shade800,
      icon: Icons.cabin,
    ),
    CarouselItemData(
      title: 'River',
      description: 'Sungai yang mengalir jernih di antara hutan tropis',
      color: Colors.indigo.shade800,
      icon: Icons.waves,
    ),
    CarouselItemData(
      title: 'Snow',
      description: 'Wilayah bersalju dengan salju putih yang menyelimuti',
      color: Colors.lightBlue.shade800,
      icon: Icons.ac_unit,
    ),
    CarouselItemData(
      title: 'Island',
      description: 'Pulau terpencil dengan pantai alami dan hutan tropis',
      color: Colors.deepOrange.shade800,
      icon: Icons.public,
    ),
  ];
}

List<Widget> buildCarouselItems(List<CarouselItemData> items,
    {bool isVertical = false}) {
  return items.map((item) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(isVertical ? 12 : 16),
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
            size: isVertical ? 50 : 64,
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// Model data untuk item carousel
class CarouselItemData {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  CarouselItemData({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}
