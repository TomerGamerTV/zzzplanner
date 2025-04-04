import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/event.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Events', 'Custom'];
  
  // Sample events data
  final List<Event> _events = [
    Event(
      id: '1',
      name: 'Deadly Assault',
      iconUrl: 'assets/images/events/deadly_assault.svg',
      deadline: DateTime.now().add(const Duration(hours: 17)),
      isCompleted: false,
      category: 'Combat Simulation',
    ),
    Event(
      id: '2',
      name: 'Investigation',
      iconUrl: 'assets/images/events/investigation.svg',
      deadline: DateTime.now().add(const Duration(days: 19, hours: 4)),
      agentIds: ['agent1', 'agent2', 'agent3'],
      isCompleted: false,
      category: 'Specialization',
      daysRemaining: 19,
      hoursRemaining: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      drawer: AppNavigationDrawer(
        selectedIndex: 3, // Planner is selected
        onItemSelected: (index) {
          // Handle navigation
        },
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        title: const Text('Planner', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Add new event
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Open settings
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          indicatorColor: AppTheme.accentPurple,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All tab
          _buildEventsTab(),
          // Events tab
          _buildEventsTab(),
          // Custom tab
          const Center(child: Text('Custom Events', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              return _buildEventCard(event);
            },
          ),
        ),
        _buildResourceTracker(),
      ],
    );
  }

  Widget _buildEventCard(Event event) {
    // Calculate time remaining
    String timeRemaining = '';
    if (event.deadline != null) {
      if (event.daysRemaining != null && event.daysRemaining! > 0) {
        timeRemaining = '${event.daysRemaining}d ${event.hoursRemaining}h';
      } else if (event.hoursRemaining != null) {
        timeRemaining = '${event.hoursRemaining}h';
      }
    }

    // Determine if this is a special event (like Deadly Assault)
    final bool isSpecialEvent = event.name == 'Deadly Assault';
    final Color cardColor = isSpecialEvent ? AppTheme.accentPurple.withOpacity(0.3) : AppTheme.primaryMedium;

    // Build agent avatars if there are any
    List<Widget> agentAvatars = [];
    if (event.agentIds.isNotEmpty) {
      for (var i = 0; i < event.agentIds.length; i++) {
        // For now, we'll use placeholder images
        agentAvatars.add(
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Using SVG images requires special handling
              // We'll use a placeholder color instead of the SVG for the avatar circles
              color: i == 0 ? Colors.purple.withOpacity(0.7) : 
                     i == 1 ? Colors.blue.withOpacity(0.7) : AppTheme.primaryLight,
            ),
            child: i >= 2 ? Center(
              child: Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ) : null,
          ),
        );
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                // Completion status
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    event.isCompleted ? Icons.check : Icons.access_time,
                    color: event.isCompleted ? AppTheme.success : Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Event icon (if available)
                if (event.iconUrl != null) ...[  
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          event.iconUrl!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          event.iconUrl!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                
                // Event name
                Expanded(
                  child: Text(
                    event.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Time remaining
                if (timeRemaining.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          timeRemaining,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            
            // Show agent avatars if there are any
            if (agentAvatars.isNotEmpty) ...[  
              const SizedBox(height: 12),
              Row(
                children: agentAvatars,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResourceTracker() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.primaryDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today header with bottom border
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.accentPurple, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.storage, color: Colors.white, size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white, size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Energy tracker - simplified to match the design in the images
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5276), // Dark blue
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Energy counter row
                Row(
                  children: [
                    // Energy icon
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.bolt, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 12),
                    
                    // Current/max energy
                    const Text(
                      '157 / 240',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Action buttons
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryMedium,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white, size: 16),
                        onPressed: () {},
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryMedium,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white, size: 16),
                        onPressed: () {},
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Energy adjustment buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildEnergyButton(-100, const Color(0xFFD32F2F)),
                    _buildEnergyButton(-80, const Color(0xFFE53935)),
                    _buildEnergyButton(-60, const Color(0xFFEF5350)),
                    _buildEnergyButton(-40, const Color(0xFFE57373)),
                    _buildEnergyButton(-20, const Color(0xFFEF9A9A)),
                    _buildEnergyButton(60, const Color(0xFF66BB6A)),
                    _buildEnergyButton(80, const Color(0xFF4CAF50)),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Time until full
                const Text(
                  '240 in 8h12 (20:56)',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                
                const SizedBox(height: 12),
                
                // Resource info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.flag, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      const Text(
                        '20020 • 63 days',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.info_outline, color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyButton(int value, Color color) {
    final String text = value > 0 ? '+$value' : '$value';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}