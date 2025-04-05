import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/navigation_drawer.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  // App settings
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Dark'; // Default theme
  
  // Available languages and themes
  final List<String> _languages = ['English', 'Japanese', 'Chinese', 'Korean', 'French', 'German'];
  final List<String> _themes = ['Dark', 'Light', 'OLED'];
  
  // Mock Google account info
  final String _userEmail = 'user@gmail.com';
  final String _userProfileImage = 'https://ui-avatars.com/api/?name=User&background=random';
  bool _isGoogleConnected = true; // Changed from final to allow modification

  Widget _buildThemeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.color_lens, color: AppTheme.accentBlue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Theme',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Choose your preferred app theme',
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildThemeOption(
                'Dark',
                Icons.dark_mode,
                AppTheme.primaryMedium,
                _selectedTheme == 'Dark',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThemeOption(
                'Light',
                Icons.light_mode,
                AppTheme.primaryLightMedium,
                _selectedTheme == 'Light',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildThemeOption(
                'OLED',
                Icons.nights_stay,
                AppTheme.primaryOledMedium,
                _selectedTheme == 'OLED',
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildThemeOption(String themeName, IconData icon, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = themeName;
          // Update app theme
          switch (themeName) {
            case 'Light':
              AppTheme.currentTheme = AppThemeMode.light;
              break;
            case 'OLED':
              AppTheme.currentTheme = AppThemeMode.oled;
              break;
            case 'Dark':
            default:
              AppTheme.currentTheme = AppThemeMode.dark;
              break;
          }
          
          // Notify listeners to rebuild the app with the new theme
          AppTheme.notifyThemeChangeListeners();
        });
        
        // Rebuild the entire app to apply theme changes
        Navigator.of(context).pushNamedAndRemoveUntil('/options', (route) => false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppTheme.accentBlue, width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.accentBlue : AppTheme.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              themeName,
              style: TextStyle(
                color: isSelected ? AppTheme.accentBlue : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
        ],
      ),
      drawer: AppNavigationDrawer(
        selectedIndex: 6, // Options is selected
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
              _buildSectionHeader('General Settings', Icons.settings),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildLanguageSetting(),
              ]),
              
              const SizedBox(height: 24),
              _buildSectionHeader('Notifications', Icons.notifications),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildSwitchSetting(
                  'Enable Notifications',
                  'Receive alerts for events and updates',
                  Icons.notifications_active,
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ]),
              
              // Theme settings
              
              const SizedBox(height: 24),
              _buildSectionHeader('Theme', Icons.color_lens),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildThemeSelector(),
              ]),
              
              const SizedBox(height: 24),
              _buildSectionHeader('Account', Icons.person),
              const SizedBox(height: 12),
              _buildSettingsCard([
                _buildGoogleAccountSection(),
                const Divider(color: AppTheme.primaryLight),
                _buildAccountInfo(),
                const Divider(color: AppTheme.primaryLight),
                _buildActionButton(
                  'Privacy Policy',
                  'View our privacy policy',
                  Icons.privacy_tip,
                  () {},
                ),
                const Divider(color: AppTheme.primaryLight),
                _buildActionButton(
                  'Donate',
                  'Support the development of ZZZ Planner',
                  Icons.favorite,
                  () {},
                  color: AppTheme.accentPink,
                ),
              ]),
              
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'ZZZ Planner v1.0.0',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
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

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      color: AppTheme.primaryMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.accentBlue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.accentBlue,
        ),
      ],
    );
  }

  Widget _buildLanguageSetting() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.language, color: AppTheme.accentBlue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.primaryDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                dropdownColor: AppTheme.primaryDark,
                items: _languages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderSetting(
    String title,
    String subtitle,
    IconData icon,
    double value,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppTheme.accentBlue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            Text('${(value * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
            activeTrackColor: AppTheme.accentBlue,
            inactiveTrackColor: AppTheme.primaryLight,
            thumbColor: AppTheme.accentBlue,
            overlayColor: AppTheme.accentBlue.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleAccountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          // Google logo with profile image indicator
          Stack(
            children: [
              // Google logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'G',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'o',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'o',
                        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'g',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'l',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'e',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // Profile image indicator on bottom right
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _userProfileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Account info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Google Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _userEmail,
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          // Status indicator and connect button
          _isGoogleConnected
              ? Icon(
                  Icons.check_circle,
                  color: AppTheme.success,
                )
              : ElevatedButton(
                  onPressed: () {
                    // Implement Google account connection
                    setState(() {
                      _isGoogleConnected = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(80, 36),
                  ),
                  child: const Text('Connect'),
                ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.account_circle, color: AppTheme.accentBlue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ZZZ Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Connected Account',
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Manage'),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onPressed,
    {Color color = AppTheme.accentBlue}
  ) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}