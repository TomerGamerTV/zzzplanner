import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  // Sample resource categories
  final List<Map<String, dynamic>> _resourceCategories = [
    {
      'name': 'Combat Materials',
      'icon': Icons.security,
      'color': Colors.red,
      'resources': [
        {'name': 'Combat Module', 'count': 157, 'max': 240, 'icon': Icons.battery_full},
        {'name': 'Training Data', 'count': 89, 'max': 120, 'icon': Icons.data_usage},
        {'name': 'Weapon Parts', 'count': 45, 'max': 100, 'icon': Icons.build},
      ],
    },
    {
      'name': 'Agent Materials',
      'icon': Icons.person,
      'color': Colors.blue,
      'resources': [
        {'name': 'Experience Module', 'count': 78, 'max': 150, 'icon': Icons.star},
        {'name': 'Skill Chip', 'count': 32, 'max': 50, 'icon': Icons.memory},
        {'name': 'Enhancement Core', 'count': 12, 'max': 30, 'icon': Icons.upgrade},
      ],
    },
    {
      'name': 'Special Items',
      'icon': Icons.card_giftcard,
      'color': Colors.purple,
      'resources': [
        {'name': 'Premium Token', 'count': 5, 'max': 10, 'icon': Icons.monetization_on},
        {'name': 'Event Ticket', 'count': 3, 'max': 5, 'icon': Icons.confirmation_number},
        {'name': 'Mystery Box', 'count': 1, 'max': 3, 'icon': Icons.help},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: 4, // Storage is selected
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
              _buildStorageHeader(),
              const SizedBox(height: 24),
              ..._resourceCategories.map((category) => _buildCategorySection(category)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Storage Capacity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.storage, color: AppTheme.accentBlue),
                  const SizedBox(width: 8),
                  const Text(
                    '458/750',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Icon(category['icon'], color: category['color']),
              const SizedBox(width: 8),
              Text(
                category['name'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ...category['resources'].map<Widget>((resource) => _buildResourceItem(resource)),
        const SizedBox(height: 16),
        const Divider(color: AppTheme.primaryLight),
      ],
    );
  }

  Widget _buildResourceItem(Map<String, dynamic> resource) {
    final double percentage = resource['count'] / resource['max'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(resource['icon'], color: AppTheme.accentBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: AppTheme.primaryLight,
                          color: percentage > 0.7 ? AppTheme.success : 
                                 percentage > 0.3 ? AppTheme.warning : 
                                 AppTheme.error,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${resource['count']}/${resource['max']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.accentBlue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}