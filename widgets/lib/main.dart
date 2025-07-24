import 'package:flutter/material.dart';

void main() {
  runApp(const GenZFeedApp());
}

class GenZFeedApp extends StatelessWidget {
  const GenZFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenZ Feed App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // Use a modern, slightly playful font if available (e.g., 'Inter' or 'Montserrat')
        fontFamily: 'Inter', // Assuming 'Inter' is available or system default
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD)),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD)),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD)),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF4A00B0)),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4A00B0)),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4A00B0)),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E0080)),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2E0080)),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF2E0080)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF333333)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF555555)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF777777)),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
          labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          secondary: const Color(0xFF8A2BE2), // Violet
          surface: Colors.white,
          onSurface: const Color(0xFF333333),
          background: const Color(0xFFF0F2F5), // Light grey background
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          shadowColor: Colors.deepPurple.withAlpha((0.2 * 255).toInt()),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF4A00B0),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A00B0),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF8A2BE2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          buttonColor: const Color(0xFF8A2BE2),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡ GenZ Vibes ⚡'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Handle search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Section 1: ListView.builder for 'Daily Stories'
            _buildSectionHeader(context, '🔥 Trending Stories'),
            _buildListViewBuilder(),
            const SizedBox(height: 30),

            // Section 2: GridView for 'Your Squad'
            _buildSectionHeader(context, '😎 Your Squad'),
            _buildGridView(context),
            const SizedBox(height: 30),

            // Section 3: GridView.builder for 'Explore Content'
            _buildSectionHeader(context, '✨ Explore More'),
            _buildGridViewBuilder(),
            const SizedBox(height: 30),

            // Section 4: Wrap for 'Popular Tags'
            _buildSectionHeader(context, '🏷️ Popular Tags'),
            _buildWrap(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for creating a new post/story
        },
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }

  // --- ListView.builder Demonstration ---
  Widget _buildListViewBuilder() {
    final List<Map<String, String>> stories = [
      {'user': 'GenZ_Vibes', 'content': 'Just dropped my new track! 🎶 Check it out!', 'avatar': 'https://placehold.co/60x60/8A2BE2/FFFFFF?text=GV'},
      {'user': 'TrendyTechie', 'content': 'New unboxing video live! 📦 #tech #gadgets', 'avatar': 'https://placehold.co/60x60/FFD700/000000?text=TT'},
      {'user': 'ArtisticSoul', 'content': 'Sketching new ideas for my next masterpiece 🎨', 'avatar': 'https://placehold.co/60x60/FF6347/FFFFFF?text=AS'},
      {'user': 'FoodieFaves', 'content': 'Tried the viral ramen today! 🍜 So good!', 'avatar': 'https://placehold.co/60x60/32CD32/FFFFFF?text=FF'},
      {'user': 'WanderlustKid', 'content': 'Mountain views got me feeling alive! ⛰️ #travel', 'avatar': 'https://placehold.co/60x60/1E90FF/FFFFFF?text=WK'},
    ];

    return SizedBox(
      height: 180, // Fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 15),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // Handle story tap
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      backgroundImage: NetworkImage(story['avatar']!),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      story['user']!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        story['content']!,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- GridView Demonstration ---
  Widget _buildGridView(BuildContext context) {
    final List<Map<String, String>> squadMembers = [
      {'name': 'Leo', 'avatar': 'https://placehold.co/80x80/FF69B4/FFFFFF?text=L'},
      {'name': 'Mia', 'avatar': 'https://placehold.co/80x80/00CED1/FFFFFF?text=M'},
      {'name': 'Zoe', 'avatar': 'https://placehold.co/80x80/FF4500/FFFFFF?text=Z'},
      {'name': 'Kai', 'avatar': 'https://placehold.co/80x80/ADFF2F/000000?text=K'},
      {'name': 'Ava', 'avatar': 'https://placehold.co/80x80/9370DB/FFFFFF?text=A'},
      {'name': 'Jax', 'avatar': 'https://placehold.co/80x80/8B0000/FFFFFF?text=J'},
    ];

    return GridView.count(
      shrinkWrap: true, // Important for nested scrollables
      physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
      crossAxisCount: 3,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      children: squadMembers.map((member) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // Handle squad member tap
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  backgroundImage: NetworkImage(member['avatar']!),
                ),
                const SizedBox(height: 8),
                Text(
                  member['name']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- GridView.builder Demonstration ---
  Widget _buildGridViewBuilder() {
    final List<String> exploreImages = [
      'https://placehold.co/150x150/FFC0CB/000000?text=Vibes', // Pink
      'https://placehold.co/150x150/ADD8E6/000000?text=Chill', // Light Blue
      'https://placehold.co/150x150/90EE90/000000?text=Green', // Light Green
      'https://placehold.co/150x150/FFDAB9/000000?text=Aesthetic', // Peach
      'https://placehold.co/150x150/DDA0DD/000000?text=Purple', // Plum
      'https://placehold.co/150x150/FFA07A/000000?text=Orange', // Light Salmon
      'https://placehold.co/150x150/B0E0E6/000000?text=Sky', // Powder Blue
      'https://placehold.co/150x150/F08080/000000?text=Reddish', // Light Coral
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 1.0, // Make items square
      ),
      itemCount: exploreImages.length,
      itemBuilder: (context, index) {
        final imageUrl = exploreImages[index];
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // Handle image tap
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(Icons.broken_image_rounded, color: Colors.grey[400]),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Wrap Demonstration ---
  Widget _buildWrap(BuildContext context) {
    final List<String> popularTags = [
      '#VibeCheck', '#AestheticGoals', '#ChillVibes', '#SquadGoals', '#TechTalk',
      '#FoodieAdventures', '#TravelDiaries', '#ArtDaily', '#GamingLife', '#FitnessJourney',
      '#OOTD', '#StudyHacks', '#LifeTips', '#DIYProjects', '#Bookworm'
    ];

    return Wrap(
      spacing: 10.0, // Horizontal space between chips
      runSpacing: 10.0, // Vertical space between lines of chips
      children: popularTags.map((tag) {
        return Chip(
          label: Text(
            tag,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 3,
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        );
      }).toList(),
    );
  }
}
