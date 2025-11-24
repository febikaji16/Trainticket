# 🚂 Train Ticket Booking App

A modern, feature-rich train ticket booking application built with Flutter. This app provides a seamless experience for searching trains, booking tickets, and managing reservations.

## ✨ Features

- 🔐 **User Authentication** - Secure login and registration system
- 🔍 **Train Search** - Search trains by stations and date
- 🎫 **Ticket Booking** - Easy booking flow with seat selection
- 👤 **Profile Management** - Update user information and preferences
- 📱 **Bottom Navigation** - Intuitive navigation between screens
- 🎨 **Modern UI** - Clean and responsive design with custom theming
- 💾 **Local Storage** - Persistent data using SharedPreferences
- 🧭 **Advanced Routing** - Smooth navigation with GoRouter

## 🏗️ Architecture

This project follows a clean, modular architecture:

```
lib/
├── constants/       # App-wide constants (colors, strings, theme)
├── data/           # Mock data for trains and stations
├── models/         # Data models (User, Train, Booking, etc.)
├── providers/      # State management with Provider
├── routes/         # Navigation configuration with GoRouter
├── screens/        # UI screens organized by feature
│   ├── auth/       # Login & Registration
│   ├── booking/    # Booking flow
│   ├── home/       # Home screen
│   ├── profile/    # User profile
│   ├── search/     # Train search & results
│   ├── seat_selection/
│   └── train_details/
├── services/       # Business logic and services
└── widgets/        # Reusable UI components
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.32.4
- **Language**: Dart 3.8.1
- **State Management**: Provider
- **Navigation**: GoRouter
- **Local Storage**: SharedPreferences
- **Date/Time**: Intl
- **ID Generation**: UUID

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2  # Local storage
  provider: ^6.1.1           # State management
  go_router: ^13.1.0         # Advanced routing
  cupertino_icons: ^1.0.8    # iOS style icons
  intl: ^0.19.0              # Date formatting
  uuid: ^4.3.3               # Generate PNR numbers
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/febikaji16/Trainticket.git
   cd Trainticket
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK**
```bash
flutter build apk --release
```

**iOS App**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 📖 Documentation

For detailed documentation, see:
- [Architecture Guide](docs/ARCHITECTURE.md)
- [Developer Guide](docs/DEVELOPER_2_GUIDE.md)
- [Test Plan](docs/TEST_PLAN.md)
- [Team Structure](TEAM_STRUCTURE.md)
- [Contributing Guidelines](CONTRIBUTING.md)

## 🤝 Contributing

Contributions are welcome! Please read the [Contributing Guidelines](CONTRIBUTING.md) before submitting PRs.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Project Status

- **Version**: 1.0.0+1
- **Status**: Active Development
- **Branch Strategy**: GitFlow (main, develop, feature branches)

## 🐛 Known Issues

- Android SDK configuration may need manual setup in `local.properties`
- Some package versions have newer releases available

## 📄 License

This project is private and not published to pub.dev.

## 👨‍💻 Author

**febikaji16**
- GitHub: [@febikaji16](https://github.com/febikaji16)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All contributors and testers

---

Built with ❤️ using Flutter
# Docker Hub Integration Complete
