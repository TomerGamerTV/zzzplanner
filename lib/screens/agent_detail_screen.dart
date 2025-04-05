import 'package:flutter/material.dart';
import '../models/agent.dart';
import '../theme/app_theme.dart';

class AgentDetailScreen extends StatefulWidget {
  final Agent agent;

  const AgentDetailScreen({Key? key, required this.agent}) : super(key: key);

  @override
  State<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['LEVEL', 'SKILLS', 'W-ENGINE', 'DRIVE DISC'];
  
  // Sample data for agent levels
  int _currentLevel = 50;
  int _goalLevel = 60;
  bool _currentLevelMaxed = false;
  bool _goalLevelMaxed = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    
    // Initialize with agent data if available
    _currentLevel = widget.agent.level;
    
    // Handle nullable goalLevel
    if (widget.agent.goalLevel != null) {
      _goalLevel = widget.agent.goalLevel!; // Use the non-null assertion operator
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: isLandscape && !isMobile ? null : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.agent.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAgentHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLevelTab(),
                _buildSkillsTab(),
                _buildWEngineTab(),
                _buildDriveDiscTab(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildAgentHeader() {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    // For landscape on tablets/desktop, create a more spacious layout
    if (isLandscape && !isMobile) {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button for landscape mode (since we hide the AppBar)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            // Agent avatar - larger in landscape
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: widget.agent.avatarUrl.isNotEmpty
                  ? AssetImage(widget.agent.avatarUrl) as ImageProvider
                  : null,
              child: widget.agent.avatarUrl.isEmpty
                  ? const Icon(Icons.person, size: 45, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 24),
            // Agent info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Agent name
                  Text(
                    widget.agent.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  // Rarity selector
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.agent.rarity ?? 'M0',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Notes field
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Notes',
                      hintStyle: TextStyle(color: AppTheme.textSecondary),
                      filled: true,
                      fillColor: AppTheme.primaryLight.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            // Action buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.blue),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      );
    }
    
    // For portrait mode or mobile devices
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: widget.agent.avatarUrl.isNotEmpty
                ? AssetImage(widget.agent.avatarUrl) as ImageProvider
                : null,
            child: widget.agent.avatarUrl.isEmpty
                ? const Icon(Icons.person, size: 30, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Notes',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
                filled: true,
                fillColor: AppTheme.primaryLight.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {},
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.agent.rarity ?? 'M0',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    return Container(
      color: AppTheme.primaryMedium,
      child: isLandscape && !isMobile
          ? TabBar(
              controller: _tabController,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppTheme.accentBlue,
              indicatorWeight: 3,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 24),
            )
          : TabBar(
              controller: _tabController,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppTheme.accentBlue,
              indicatorWeight: 3,
              labelStyle: isMobile ? const TextStyle(fontSize: 12) : null,
            ),
    );
  }

  Widget _buildLevelTab() {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    return Padding(
      padding: EdgeInsets.all(isLandscape && !isMobile ? 24.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current level section
          const Text(
            'CURRENT LEVEL',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          // Responsive layout for level controls
          isLandscape && !isMobile
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildLevelSelector(
                        _currentLevel,
                        _currentLevelMaxed,
                        (value) {
                          if (value > 1) {
                            setState(() {
                              _currentLevel = value;
                            });
                          }
                        },
                        (value) {
                          setState(() {
                            _currentLevelMaxed = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: _buildLevelResources(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildLevelSelector(
                      _currentLevel,
                      _currentLevelMaxed,
                      (value) {
                        if (value > 1) {
                          setState(() {
                            _currentLevel = value;
                          });
                        }
                      },
                      (value) {
                        setState(() {
                          _currentLevelMaxed = value;
                        });
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
  
  // Extracted level selector widget for reuse
  Widget _buildLevelSelector(int level, bool isMaxed, Function(int) onLevelChanged, Function(bool) onMaxChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                level.toString(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                onPressed: () {
                  if (level > 1) {
                    onLevelChanged(level - 1);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                onPressed: () {
                  onLevelChanged(level + 1);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('MAX', style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 8),
              Switch(
                value: isMaxed,
                onChanged: onMaxChanged,
                activeColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Widget for showing level resources (used in landscape mode)
  Widget _buildLevelResources() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RESOURCES NEEDED',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.monetization_on, color: AppTheme.accentOrange),
              const SizedBox(width: 8),
              const Text('12,500 Credits'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.science, color: AppTheme.accentPurple),
              const SizedBox(width: 8),
              const Text('8 Agent Materials'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelSelectorWithLabel(String label, int value, Function(int) onChanged, bool isMaxed) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 16),
              onPressed: () {
                if (value > 1) {
                  onChanged(value - 1);
                }
              },
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {
                if (!isMaxed) {
                  onChanged(value + 1);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  i < 5 ? Icons.star : Icons.star_border,
                  color: i < 5 ? Colors.white : Colors.grey,
                  size: 16,
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              isMaxed ? Icons.check_circle : Icons.check_circle_outline,
              color: isMaxed ? Colors.green : Colors.grey,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsTab() {
    return const Center(
      child: Text('Skills tab content'),
    );
  }

  Widget _buildWEngineTab() {
    return const Center(
      child: Text('W-Engine tab content'),
    );
  }

  Widget _buildDriveDiscTab() {
    return const Center(
      child: Text('Drive Disc tab content'),
    );
  }

  Widget _buildBottomBar() {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    return Container(
      padding: EdgeInsets.all(isLandscape && !isMobile ? 20 : 16),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        border: Border(top: BorderSide(color: AppTheme.primaryLight, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Help button
          IconButton(
            icon: const Icon(Icons.help, color: Colors.white),
            onPressed: () {},
          ),
          
          // Resource counters - adapt to screen size
          isMobile && !isLandscape
              ? _buildCompactResourceCounters()
              : _buildFullResourceCounters(),
          
          // Google account section with circular logo and profile image
          _buildGoogleAccountSection(),
        ],
      ),
    );
  }
  
  // Compact resource counters for mobile portrait mode
  Widget _buildCompactResourceCounters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.battery_full, color: AppTheme.accentBlue, size: 16),
          const SizedBox(width: 4),
          const Text(
            '420',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.diamond, color: Colors.green, size: 16),
          const SizedBox(width: 4),
          const Text(
            '7',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
  
  // Full resource counters for tablet/desktop or landscape mode
  Widget _buildFullResourceCounters() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.battery_full, color: AppTheme.accentBlue, size: 16),
              const SizedBox(width: 4),
              const Text(
                '420 · 2 days',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.diamond, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              const Text(
                '7',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade800,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.battery_full, color: AppTheme.accentBlue, size: 16),
              const SizedBox(width: 4),
              const Text(
                '20.9k · 66 days',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.diamond, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              const Text(
                '347',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Google account section with circular logo and profile image indicator
  Widget _buildGoogleAccountSection() {
    // Get screen size and orientation
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isMobile = screenSize.width < 600;
    
    // For very small screens, just show the icon
    if (isMobile && !isLandscape && screenSize.width < 360) {
      return IconButton(
        icon: const Icon(Icons.account_circle, color: Colors.white),
        onPressed: () {},
      );
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Google logo with profile image indicator
          Stack(
            children: [
              // Google logo
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'G',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Profile image indicator on bottom right
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://ui-avatars.com/api/?name=User&background=random',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Only show text on larger screens
          if (!isMobile || isLandscape) ...[  
            const SizedBox(width: 8),
            const Text(
              'User',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}