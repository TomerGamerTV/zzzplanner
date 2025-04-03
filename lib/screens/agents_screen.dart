import 'package:flutter/material.dart';
import '../models/agent.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';
import 'agent_detail_screen.dart';
import 'planner_screen.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  // Sample agents data
  final List<Agent> _agents = [
    Agent(
      id: '1',
      name: 'EVELYN',
      avatarUrl: 'assets/images/agents/evelyn.png', // Placeholder
      rarity: 'M0',
      elements: ['fire'],
      level: 50,
      goalLevel: 60,
    ),
    Agent(
      id: '2',
      name: 'PULCHRA',
      avatarUrl: 'assets/images/agents/pulchra.png', // Placeholder
      rarity: 'M6',
      elements: ['electric'],
      level: 45,
    ),
    Agent(
      id: '3',
      name: 'QINGYI',
      avatarUrl: 'assets/images/agents/qingyi.png', // Placeholder
      rarity: null,
      elements: ['water'],
      level: 40,
    ),
    Agent(
      id: '4',
      name: 'MIYABI',
      avatarUrl: 'assets/images/agents/miyabi.png', // Placeholder
      rarity: 'M2',
      elements: ['ice'],
      level: 55,
    ),
    Agent(
      id: '5',
      name: 'BURNICE',
      avatarUrl: 'assets/images/agents/burnice.png', // Placeholder
      rarity: 'M2',
      elements: ['fire'],
      level: 48,
    ),
    Agent(
      id: '6',
      name: 'GRACE',
      avatarUrl: 'assets/images/agents/grace.png', // Placeholder
      rarity: 'M2',
      elements: ['electric', 'ice'],
      level: 52,
    ),
    Agent(
      id: '7',
      name: 'HARUMASA',
      avatarUrl: 'assets/images/agents/harumasa.png', // Placeholder
      rarity: null,
      elements: ['water'],
      level: 60,
    ),
    Agent(
      id: '8',
      name: 'NEKOMATA',
      avatarUrl: 'assets/images/agents/nekomata.png', // Placeholder
      rarity: 'M1',
      elements: ['fire'],
      level: 42,
    ),
    Agent(
      id: '9',
      name: 'RINA',
      avatarUrl: 'assets/images/agents/rina.png', // Placeholder
      rarity: null,
      elements: ['ice'],
      level: 38,
    ),
    Agent(
      id: '10',
      name: 'SOLDIER 11',
      avatarUrl: 'assets/images/agents/soldier11.png', // Placeholder
      rarity: null,
      elements: ['electric'],
      level: 45,
    ),
    Agent(
      id: '11',
      name: 'ZHU YUAN',
      avatarUrl: 'assets/images/agents/zhuyuan.png', // Placeholder
      rarity: 'M3',
      elements: ['fire', 'electric'],
      level: 50,
    ),
    Agent(
      id: '12',
      name: 'LYCAON',
      avatarUrl: 'assets/images/agents/lycaon.png', // Placeholder
      rarity: 'M2',
      elements: ['water', 'ice'],
      level: 47,
    ),
    Agent(
      id: '13',
      name: 'NICOLE',
      avatarUrl: 'assets/images/agents/nicole.png', // Placeholder
      rarity: 'M6',
      elements: ['fire'],
      level: 55,
    ),
    Agent(
      id: '14',
      name: 'ANBY',
      avatarUrl: 'assets/images/agents/anby.png', // Placeholder
      rarity: 'M6',
      elements: ['electric', 'ice'],
      level: 58,
    ),
  ];
  
  // Filter options
  final List<Map<String, dynamic>> _filterOptions = [
    {'icon': Icons.star, 'color': Colors.orange},
    {'icon': Icons.science, 'color': Colors.purple},
    {'icon': Icons.settings, 'color': Colors.yellow},
    {'icon': Icons.whatshot, 'color': Colors.red},
    {'icon': Icons.ac_unit, 'color': Colors.blue},
    {'icon': Icons.water_drop, 'color': Colors.lightBlue},
    {'icon': Icons.bolt, 'color': Colors.pink},
  ];
  
  // View mode (grid or list)
  bool _isGridView = true;
  
  // Selected filter index
  int? _selectedFilterIndex;
  
  // Filter states
  String _searchQuery = '';
  List<String> _selectedElements = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.grid_view : Icons.view_list),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: 0, // Agents is selected
        onItemSelected: (index) {
          // Navigation is handled in the drawer
        },
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _buildAgentGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppTheme.primaryDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FILTER',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryMedium,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                // Element filter buttons
                for (int i = 0; i < _filterOptions.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      backgroundColor: AppTheme.primaryDark,
                      selectedColor: _filterOptions[i]['color'],
                      checkmarkColor: Colors.white,
                      selected: _selectedFilterIndex == i,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterIndex = selected ? i : null;
                        });
                      },
                      avatar: Icon(
                        _filterOptions[i]['icon'],
                        color: _selectedFilterIndex == i
                            ? Colors.white
                            : _filterOptions[i]['color'],
                        size: 18,
                      ),
                      label: const SizedBox.shrink(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                
                // Divider
                const SizedBox(width: 8),
                Container(
                  height: 24,
                  width: 1,
                  color: AppTheme.primaryLight,
                ),
                const SizedBox(width: 8),
                
                // View options
                IconButton(
                  icon: const Icon(Icons.view_list, color: Colors.grey),
                  onPressed: () {},
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.grey),
                  onPressed: () {},
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.star, color: Colors.grey),
                  onPressed: () {},
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                
                // Search field
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _agents.length,
      itemBuilder: (context, index) {
        final agent = _agents[index];
        return _buildAgentCard(agent);
      },
    );
  }

  Widget _buildAgentCard(Agent agent) {
    // Determine background color based on rarity
    Color cardColor = AppTheme.primaryMedium;
    Color borderColor = Colors.transparent;
    
    if (agent.rarity != null) {
      if (agent.rarity!.contains('M6')) {
        borderColor = Colors.purple;
      } else if (agent.rarity!.contains('M2')) {
        borderColor = Colors.blue;
      } else if (agent.rarity!.contains('M1')) {
        borderColor = Colors.orange;
      } else {
        borderColor = Colors.yellow;
      }
    }
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentDetailScreen(agent: agent),
          ),
        );
      },
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Agent image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Container(
                      color: Colors.black26,
                      child: agent.avatarUrl.isNotEmpty
                          ? Image.asset(
                              agent.avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 60, color: Colors.white54);
                              },
                            )
                          : const Icon(Icons.person, size: 60, color: Colors.white54),
                    ),
                  ),
                  // Rarity indicator
                  if (agent.rarity != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          agent.rarity!,
                          style: TextStyle(
                            color: borderColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Element indicators
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: agent.elements.map((element) {
                        IconData elementIcon;
                        Color elementColor;
                        
                        switch (element.toLowerCase()) {
                          case 'fire':
                            elementIcon = Icons.whatshot;
                            elementColor = Colors.red;
                            break;
                          case 'water':
                            elementIcon = Icons.water_drop;
                            elementColor = Colors.blue;
                            break;
                          case 'ice':
                            elementIcon = Icons.ac_unit;
                            elementColor = Colors.lightBlue;
                            break;
                          case 'electric':
                            elementIcon = Icons.bolt;
                            elementColor = Colors.yellow;
                            break;
                          default:
                            elementIcon = Icons.help_outline;
                            elementColor = Colors.grey;
                        }
                        
                        return Container(
                          margin: const EdgeInsets.only(left: 4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(elementIcon, color: elementColor, size: 14),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Agent name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                agent.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            // Agent level indicator
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.grey.shade600, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Lv.${agent.level}',
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        backgroundColor: AppTheme.primaryMedium,
        selectedColor: color.withOpacity(0.3),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            if (label.isNotEmpty) ...[  
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ],
        ),
        selected: false,
        onSelected: (selected) {
          // Handle filter selection
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Second implementation of _buildAgentCard removed to fix duplicate method error
}