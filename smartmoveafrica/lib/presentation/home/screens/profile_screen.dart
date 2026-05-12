import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_routes.dart';
import '../../../state/auth_session_provider.dart';
import '../../../state/notification_provider.dart';
import '../../../state/theme_mode_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authSessionProvider);
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Profile failed to load: $error')),
        data: (user) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user?.name ?? 'Guest'),
                  subtitle: Text(user?.email ?? 'Not signed in'),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: notificationsAsync.when(
                  loading: () => const ListTile(title: Text('Loading notifications...')),
                  error: (error, _) => ListTile(title: Text('Notification error: $error')),
                  data: (items) => ListTile(
                    leading: const Icon(Icons.notifications_active_rounded),
                    title: const Text('Alert Center'),
                    subtitle: Text('${items.length} active alerts'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: const Text('Appearance'),
                  subtitle: Text(ref.watch(themeModeProvider).label),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showThemePicker(context, ref),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(authSessionProvider.notifier).logout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sign Out'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showThemePicker(BuildContext context, WidgetRef ref) async {
    final selected = ref.read(themeModeProvider);
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Choose Theme', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (final mode in AppThemeMode.values)
              ListTile(
                leading: Icon(
                  selected == mode
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                ),
                title: Text(mode.label),
                onTap: () {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
