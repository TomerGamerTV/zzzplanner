import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class BangbooScreen extends StatefulWidget {
  const BangbooScreen({Key? key}) : super(key: key);

  @override
  State<BangbooScreen> createState() => _BangbooScreenState();
}

class _BangbooScreenState extends State<BangbooScreen> {
  // Sample bangboo data
  final List<Map<String, dynamic>> _bangboos = [
    {
      'name': 'Bangboo Alpha',
      'level': 5,
      'type': 'Support',
      'avatarUrl': 'assets/images/bangboos/alpha.png',
      'skills': ['Healing', 'Buff'],
    },
    {
      'name': 'Bangboo Beta',
      'level': 8,
      'type': 'Attack',
      'avatarUrl': 'assets/images/bangboos/beta.png',
      'skills': ['Fire Damage', 'AoE Attack'],
    },
    {
      'name': 'Bangboo Gamma',
      'level': 3,
      'type': 'Defense',
      'avatarUrl': 'assets/images/bangboos/gamma.png',
      'skills': ['Shield', 'Taunt'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bangboo'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: 2, // Bangboo is selected
        onItemSelected: (index) {
          Navigator.pop(context);
          // Handle navigation based on index
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBangbooHeader(),
              const SizedBox(height: 16),
              _buildBangbooGrid(),
              const SizedBox(height: 24),
              _buildBangbooStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBangbooHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Your Bangboos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentPurple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '3/10',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBangbooGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _bangboos.length,
      itemBuilder: (context, index) {
        final bangboo = _bangboos[index];
        return _buildBangbooCard(bangboo);
      },
    );
  }

  Widget _buildBangbooCard(Map<String, dynamic> bangboo) {
    return Card(
      color: AppTheme.primaryMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.pets,
                  size: 60,
                  color: bangboo['type'] == 'Support'
                      ? AppTheme.accentGreen
                      : bangboo['type'] == 'Attack'
                          ? AppTheme.accentOrange
                          : AppTheme.accentBlue,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  bangboo['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Level ${bangboo['level']} · ${bangboo['type']}',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var skill in bangboo['skills'])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(
                          label: Text(
                            skill,
                            style: const TextStyle(fontSize: 10),
                          ),
                          backgroundColor: AppTheme.primaryLight,
                          padding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          visualDensity: VisualDensity.compact,
                        ),
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

  Widget _buildBangbooStats() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bangboo Stats',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Support', 1, AppTheme.accentGreen),
              _buildStatItem('Attack', 1, AppTheme.accentOrange),
              _buildStatItem('Defense', 1, AppTheme.accentBlue),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            value: 0.3,
            backgroundColor: AppTheme.primaryLight,
            color: AppTheme.accentPurple,
          ),
          const SizedBox(height: 8),
          const Text(
            'Bangboo Collection: 3/10',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.pets, color: color),
        ),
        const SizedBox(height: 8),
        Text(label),
        Text(
          count.toString(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}