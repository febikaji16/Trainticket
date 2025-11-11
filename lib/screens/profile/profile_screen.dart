import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        if (!authService.isLoggedIn) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please login to view your profile',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        }

        final user = authService.currentUser!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.go('/profile/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authService.logout();
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              _buildInfoTile(
                context,
                title: 'Email',
                value: user.email,
                icon: Icons.email,
              ),
              if (user.phoneNumber != null)
                _buildInfoTile(
                  context,
                  title: 'Phone',
                  value: user.phoneNumber!,
                  icon: Icons.phone,
                ),
              if (user.address != null)
                _buildInfoTile(
                  context,
                  title: 'Address',
                  value: user.address!,
                  icon: Icons.location_on,
                ),
              const SizedBox(height: 24),
              if (user.bookedTickets.isNotEmpty) ...[
                Text(
                  'Booked Tickets',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                // TODO: Implement booked tickets list
                // This will be implemented when ticket booking is ready
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}