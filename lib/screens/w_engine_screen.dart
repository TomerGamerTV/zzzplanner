import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class WEngineScreen extends StatefulWidget {
  const WEngineScreen({Key? key}) : super(key: key);

  @override
  State<WEngineScreen> createState() => _WEngineScreenState();
}

class _WEngineScreenState extends State<WEngineScreen> {
  // Sample specialization data
  final List<Map<String, dynamic>> _specializations = [
    {
      'name': 'Bounty Specialization',
      'multiplier': 'x370',
      'resources': 7400,
      'days': 24,
      'resourceIcon': 'assets/images/icons/bounty_resource.png',
      'agents': ['agent1', 'agent2', 'agent3', 'agent4', 'agent5', 'agent6', 'agent7', 'agent8'],
    },
    {
      'name': 'Investigation Specialization',
      'multiplier': 'x88',
      'resources': 1760,
      'days': 6,
      'resourceIcon': 'assets/images/icons/investigation_resource.png',
      'agents': ['agent1', 'agent2', 'agent3'],
    },
    {
      'name': 'W-Engine Specialization',
      'multiplier': 'x31',
      'resources': 620,
      'days': 2,
      'resourceIcon': 'assets/images/icons/w_engine_resource.png',
      'agents': ['agent1', 'agent2', 'agent3', 'agent4', 'agent5'],
    },
  ];

  // Sample test data
  final List<Map<String, dynamic>> _tests = [
    {
      'name': 'Icing Test',
      'multiplier': 'x70',
      'resources': 1400,
      'days': 5,
      'resourceIcon': 'assets/images/icons/ice_resource.png',
      'agents': ['agent1', 'agent2'],
    },
    {
      'name': 'Heating Test',
      'multiplier': 'x156',
      'resources': 3120,
      'days': 10,
      'resourceIcon': 'assets/images/icons/fire_resource.png',
      'agents': ['agent1', 'agent2', 'agent3', 'agent4', 'agent5'],
    },
    {
      'name': 'Rigidity Test',
      'multiplier': 'x99',
      'resources': 1980,
      'days': 7,
      'resourceIcon': 'assets/images/icons/rigidity_resource.png',
      'agents': ['agent1', 'agent2', 'agent3', 'agent4'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W-Engine'),
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
        selectedIndex: 1, // W-Engine is selected
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
              _buildResourceCounter(),
              const SizedBox(height: 16),
              _buildCategoryHeader('Combat Simulation (Basic Material)'),
              const SizedBox(height: 8),
              _buildSpecializationGrid(),
              const SizedBox(height: 24),
              _buildCategoryHeader('Combat Simulation (Agent Skill)'),
              const SizedBox(height: 8),
              _buildTestGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceCounter() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryMedium,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.battery_full, color: AppTheme.accentBlue),
                const SizedBox(width: 4),
                const Text(
                  '20',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSpecializationGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        mainAxisSpacing: 16,
      ),
      itemCount: _specializations.length,
      itemBuilder: (context, index) {
        final specialization = _specializations[index];
        return _buildSpecializationCard(specialization);
      },
    );
  }

  Widget _buildTestGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        mainAxisSpacing: 16,
      ),
      itemCount: _tests.length,
      itemBuilder: (context, index) {
        final test = _tests[index];
        return _buildSpecializationCard(test);
      },
    );
  }

  Widget _buildSpecializationCard(Map<String, dynamic> data) {
    return Card(
      color: AppTheme.primaryMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              data['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue.shade800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data['multiplier']),
                Row(
                  children: [
                    Text('${data['resources']} '),
                    const Icon(Icons.monetization_on, size: 16),
                  ],
                ),
                Text('${data['days']} days'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.book, color: Colors.pink),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: data['agents'].length,
                      itemBuilder: (context, index) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          radius: 16,
                          child: const Icon(Icons.person, size: 16),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}