import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainticket/constants/strings.dart';
import 'package:trainticket/constants/theme.dart';
import 'package:trainticket/routes/router.dart';
import 'package:trainticket/services/auth_service.dart';
import 'package:trainticket/services/storage_service.dart';
import 'package:trainticket/providers/booking_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(prefs),
        ),
        Provider(
          create: (_) => StorageService(prefs),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BookingProvider(storage: Provider.of<StorageService>(ctx, listen: false)),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// action in the IDE, or press "p" in the console), to see the
// wireframe for each widget.

