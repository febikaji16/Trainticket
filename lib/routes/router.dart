import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainticket/screens/home/home_screen.dart';
import 'package:trainticket/screens/search/search_screen.dart';
import 'package:trainticket/screens/auth/login_screen.dart';
import 'package:trainticket/screens/auth/register_screen.dart';
import 'package:trainticket/screens/profile/profile_screen.dart';
import 'package:trainticket/screens/profile/edit_profile_screen.dart';
import 'package:trainticket/widgets/scaffold_with_navbar.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigator,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        // Home Tab
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const HomeScreen(),
          ),
          routes: [
            // Nested routes under home
            GoRoute(
              path: 'search',
              name: 'search',
              parentNavigatorKey: _rootNavigator,
              pageBuilder: (context, state) {
                final Map<String, dynamic> params = state.extra as Map<String, dynamic>;
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: SearchResultsScreen(searchParams: params),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: 'train-details/:id',
              name: 'trainDetails',
              parentNavigatorKey: _rootNavigator,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const Placeholder(), // TODO: Replace with actual screen
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
              ),
            ),
            GoRoute(
              path: 'booking',
              name: 'booking',
              parentNavigatorKey: _rootNavigator,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const Placeholder(), // TODO: Replace with actual screen
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
        // My Bookings Tab
        GoRoute(
          path: '/my-bookings',
          name: 'myBookings',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const Placeholder(), // TODO: Replace with actual screen
          ),
        ),
        // Profile Tab
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const ProfileScreen(),
          ),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'editProfile',
              parentNavigatorKey: _rootNavigator,
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const EditProfileScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
    // Authentication routes
    GoRoute(
      path: '/login',
      name: 'login',
      parentNavigatorKey: _rootNavigator,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      parentNavigatorKey: _rootNavigator,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      ),
    ),
    // Full screen routes (not part of bottom navigation)
    GoRoute(
      path: '/payment',
      name: 'payment',
      parentNavigatorKey: _rootNavigator,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Placeholder(), // TODO: Replace with actual screen
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/confirmation',
      name: 'confirmation',
      parentNavigatorKey: _rootNavigator,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const Placeholder(), // TODO: Replace with actual screen
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    ),
  ],
);