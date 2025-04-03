import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/agents_screen.dart';
import '../screens/w_engine_screen.dart';
import '../screens/bangboo_screen.dart';
import '../screens/planner_screen.dart';
import '../screens/storage_screen.dart';
import '../screens/inter_knot_screen.dart';
import '../screens/options_screen.dart';

class AppNavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppNavigationDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryDark,
      child: Column(
        children: [
          // Close button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          
          // Current zone
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryMedium,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.tv, color: Colors.white),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Zenless Zone',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Zero',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SEELIE',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '.me',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation items
          _buildNavItem(context, 0, 'Agents', Icons.people_alt),
          _buildNavItem(context, 1, 'W-Engine', Icons.settings),
          _buildNavItem(context, 2, 'Bangboo', Icons.pets),
          _buildNavItem(context, 3, 'Planner', Icons.calendar_today, badge: '157'),
          _buildNavItem(context, 4, 'Storage', Icons.storage),
          _buildNavItem(context, 5, 'Inter-Knot', Icons.public),
          _buildNavItem(context, 6, 'Options', Icons.settings_applications),
          
          const Spacer(),
          
          // Language selector
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryMedium,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('🇺🇸', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 8),
                const Text(
                  'English',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Donate button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryMedium,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 16, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Donate',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryMedium,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.discord, color: Colors.indigo),
                ),
              ],
            ),
          ),
          
          // Privacy policy
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Privacy Policy'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String title, IconData icon, {String? badge}) {
    final bool isSelected = index == selectedIndex;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            : null,
        onTap: () {
          onItemSelected(index);
          _navigateToScreen(context, index);
        },
      ),
    );
  }
  
  void _navigateToScreen(BuildContext context, int index) {
    Navigator.pop(context); // Close the drawer first
    
    Widget? destinationScreen;
    
    switch (index) {
      case 0:
        destinationScreen = const AgentsScreen();
        break;
      case 1:
        destinationScreen = const WEngineScreen();
        break;
      case 2:
        destinationScreen = const BangbooScreen();
        break;
      case 3:
        destinationScreen = const PlannerScreen();
        break;
      case 4:
        destinationScreen = const StorageScreen();
        break;
      case 5:
        destinationScreen = const InterKnotScreen();
        break;
      case 6:
        destinationScreen = const OptionsScreen();
        break;
    }
    
    if (destinationScreen != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => destinationScreen!),
      );
    }
  }
}