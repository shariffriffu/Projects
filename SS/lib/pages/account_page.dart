import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _user = UserProfile(
    name: 'John Doe',
    email: 'john.doe@email.com',
    phone: '+1 (555) 123-4567',
    joinDate: DateTime(2023, 6, 15),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      _user.name.split(' ').map((n) => n[0]).join().toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _user.email,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Member since ${_user.joinDate.year}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Account Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.person,
                  title: 'Personal Information',
                  subtitle: 'Update your profile details',
                  onTap: () => _showPersonalInfo(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.security,
                  title: 'Security & Privacy',
                  subtitle: 'Password, two-factor authentication',
                  onTap: () => _showSecurity(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage your notification preferences',
                  onTap: () => _showNotifications(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.sync,
                  title: 'Data & Sync',
                  subtitle: 'Backup and synchronization settings',
                  onTap: () => _showDataSync(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Preferences',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.palette,
                  title: 'Theme',
                  subtitle: 'Light, dark, or system default',
                  onTap: () => _showThemeOptions(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English (US)',
                  onTap: () => _showLanguageOptions(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.storage,
                  title: 'Storage',
                  subtitle: 'Manage local data and cache',
                  onTap: () => _showStorage(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Support',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.help,
                  title: 'Help & Support',
                  subtitle: 'FAQs, contact us, tutorials',
                  onTap: () => _showHelp(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.info,
                  title: 'About PortalPass',
                  subtitle: 'Version 1.0.0',
                  onTap: () => _showAbout(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  subtitle: 'How we protect your data',
                  onTap: () => _showPrivacyPolicy(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showPersonalInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Personal Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow('Name', _user.name),
            _InfoRow('Email', _user.email),
            _InfoRow('Phone', _user.phone),
            _InfoRow('Member Since', '${_user.joinDate.month}/${_user.joinDate.year}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showComingSoon(context);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showSecurity(BuildContext context) => _showComingSoon(context);
  void _showNotifications(BuildContext context) => _showComingSoon(context);
  void _showDataSync(BuildContext context) => _showComingSoon(context);
  void _showThemeOptions(BuildContext context) => _showComingSoon(context);
  void _showLanguageOptions(BuildContext context) => _showComingSoon(context);
  void _showStorage(BuildContext context) => _showComingSoon(context);
  void _showHelp(BuildContext context) => _showComingSoon(context);
  void _showPrivacyPolicy(BuildContext context) => _showComingSoon(context);

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About PortalPass'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PortalPass v1.0.0'),
            const SizedBox(height: 8),
            const Text('Your secure gateway to digital experiences.'),
            const SizedBox(height: 16),
            Text(
              '© 2024 PortalPass. All rights reserved.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String phone;
  final DateTime joinDate;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
  });
}