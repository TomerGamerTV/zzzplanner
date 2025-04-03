import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class InterKnotScreen extends StatefulWidget {
  const InterKnotScreen({Key? key}) : super(key: key);

  @override
  State<InterKnotScreen> createState() => _InterKnotScreenState();
}

class _InterKnotScreenState extends State<InterKnotScreen> {
  // Sample connections data
  final List<Map<String, dynamic>> _connections = [
    {
      'name': 'Zenless Zone Alpha',
      'status': 'Online',
      'players': 24,
      'ping': 45,
      'favorite': true,
    },
    {
      'name': 'New Eridu Server',
      'status': 'Online',
      'players': 18,
      'ping': 78,
      'favorite': false,
    },
    {
      'name': 'Hollow Core',
      'status': 'Maintenance',
      'players': 0,
      'ping': 0,
      'favorite': false,
    },
    {
      'name': 'Proxima Beta',
      'status': 'Online',
      'players': 32,
      'ping': 120,
      'favorite': true,
    },
  ];

  // Sample friends data
  final List<Map<String, dynamic>> _friends = [
    {
      'name': 'Agent_X',
      'status': 'Online',
      'lastSeen': 'Now',
      'avatarUrl': 'assets/images/agents/agent1.png',
    },
    {
      'name': 'ZeroDay',
      'status': 'In Mission',
      'lastSeen': 'Now',
      'avatarUrl': 'assets/images/agents/agent2.png',
    },
    {
      'name': 'Quantum_Drift',
      'status': 'Offline',
      'lastSeen': '2 hours ago',
      'avatarUrl': 'assets/images/agents/agent3.png',
    },
    {
      'name': 'NeonShadow',
      'status': 'Online',
      'lastSeen': 'Now',
      'avatarUrl': 'assets/images/agents/agent4.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inter-Knot'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: 5, // Inter-Knot is selected
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
              _buildConnectionStatus(),
              const SizedBox(height: 24),
              _buildSectionHeader('Available Servers', Icons.dns),
              const SizedBox(height: 12),
              ..._connections.map((connection) => _buildConnectionItem(connection)),
              const SizedBox(height: 24),
              _buildSectionHeader('Friends', Icons.people),
              const SizedBox(height: 12),
              ..._friends.map((friend) => _buildFriendItem(friend)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.accentBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Connected',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Zenless Zone Alpha · Ping: 45ms',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.accentBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildConnectionItem(Map<String, dynamic> connection) {
    final bool isOnline = connection['status'] == 'Online';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(8),
        border: connection['favorite'] 
            ? Border.all(color: AppTheme.accentOrange, width: 2)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isOnline ? AppTheme.success : AppTheme.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  connection['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${connection['status']} · ${connection['players']} players',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          if (isOnline)
            Text(
              '${connection['ping']}ms',
              style: TextStyle(
                color: connection['ping'] < 50 
                    ? AppTheme.success 
                    : connection['ping'] < 100 
                        ? AppTheme.warning 
                        : AppTheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              connection['favorite'] ? Icons.star : Icons.star_border,
              color: connection['favorite'] ? AppTheme.accentOrange : AppTheme.textSecondary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.login, color: AppTheme.accentBlue),
            onPressed: isOnline ? () {} : null,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(Map<String, dynamic> friend) {
    final bool isOnline = friend['status'] != 'Offline';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryLight,
                child: const Icon(Icons.person),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? AppTheme.success : AppTheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryMedium, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${friend['status']} · ${friend['lastSeen']}',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.message, color: AppTheme.accentBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videogame_asset, color: AppTheme.accentPurple),
            onPressed: isOnline ? () {} : null,
          ),
        ],
      ),
    );
  }
}