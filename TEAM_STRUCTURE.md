# Train Ticket Booking App - Team Structure

## Project Overview
A Flutter-based train ticket booking application with hardcoded data (no backend). This is a small-scale app designed for DevOps demonstration on GitHub.

## Team Composition
- **4 Developers**
- **1 Tester**

---

## 👨‍💻 Developer 1: UI/UX Lead & Home Screen
**Focus:** App Foundation, Navigation, and Home Screen

### Responsibilities:
1. **Project Setup & Configuration**
   - Set up Flutter project structure
   - Configure `pubspec.yaml` with required dependencies (provider, intl, etc.)
   - Set up app theme and color scheme
   - Create app constants file

2. **Home Screen Development**
   - Design and implement home screen UI
   - Create search widget (From/To/Date selector)
   - Add popular routes section
   - Implement bottom navigation bar
   - Add app drawer/menu

3. **Navigation Structure**
   - Set up routing using Navigator 2.0 or go_router
   - Create route definitions
   - Implement navigation transitions

### Deliverables:
```
lib/
  ├── main.dart
  ├── constants/
  │   ├── colors.dart
  │   ├── strings.dart
  │   └── theme.dart
  ├── routes/
  │   └── app_routes.dart
  └── screens/
      └── home/
          ├── home_screen.dart
          ├── widgets/
          │   ├── search_widget.dart
          │   ├── popular_routes_widget.dart
          │   └── bottom_nav_bar.dart
```

---

## 👨‍💻 Developer 2: Data Models & Train Search
**Focus:** Data Layer and Train Search Functionality

### Responsibilities:
1. **Data Models**
   - Create Train model (train number, name, timings, fare, etc.)
   - Create Passenger model
   - Create Booking model
   - Create Station model

2. **Hardcoded Data Provider**
   - Create mock data file with train listings
   - Implement search logic (filter by source, destination, date)
   - Create data provider using Provider package
   - Add station list data

3. **Train Search Results Screen**
   - Display search results in list/card format
   - Implement filter options (price, time, class)
   - Add sort functionality
   - Show train details (departure, arrival, duration)

### Deliverables:
```
lib/
  ├── models/
  │   ├── train.dart
  │   ├── passenger.dart
  │   ├── booking.dart
  │   └── station.dart
  ├── data/
  │   ├── mock_trains.dart
  │   └── mock_stations.dart
  ├── providers/
  │   └── train_provider.dart
  └── screens/
      └── search/
          ├── search_results_screen.dart
          └── widgets/
              ├── train_card.dart
              └── filter_widget.dart
```

---

## 👨‍💻 Developer 3: Booking Flow & Passenger Details
**Focus:** Booking Process and User Input

### Responsibilities:
1. **Train Details Screen**
   - Show complete train information
   - Display seat availability (hardcoded)
   - Show fare breakdown for different classes
   - Add "Book Now" button

2. **Passenger Details Screen**
   - Create form for passenger information
   - Add validation for name, age, gender
   - Implement add/remove passenger functionality
   - Show fare calculation based on passengers
   - Contact details form

3. **Seat Selection (Optional/Simple)**
   - Simple seat class selection (Sleeper, AC, 3AC, 2AC)
   - Show pricing for each class

### Deliverables:
```
lib/
  └── screens/
      ├── train_details/
      │   ├── train_details_screen.dart
      │   └── widgets/
      │       ├── fare_breakdown_widget.dart
      │       └── availability_widget.dart
      ├── booking/
      │   ├── passenger_details_screen.dart
      │   └── widgets/
      │       ├── passenger_form.dart
      │       └── add_passenger_widget.dart
      └── seat_selection/
          └── seat_selection_screen.dart
```

---

## 👨‍💻 Developer 4: Payment & My Bookings
**Focus:** Payment Flow and Booking Management

### Responsibilities:
1. **Payment Screen**
   - Display booking summary
   - Show total fare
   - Mock payment options (UPI, Card, Wallet - UI only)
   - Implement payment success/failure flow

2. **Booking Confirmation Screen**
   - Show PNR number (generated)
   - Display booking details
   - Add download ticket button (mock)
   - Share ticket option

3. **My Bookings Screen**
   - List all bookings (stored locally using shared_preferences)
   - Show upcoming and past bookings
   - Implement booking details view
   - Add cancel booking functionality (mock)

4. **Local Storage**
   - Implement shared_preferences for storing bookings
   - Create booking storage service

### Deliverables:
```
lib/
  ├── services/
  │   └── storage_service.dart
  ├── providers/
  │   └── booking_provider.dart
  └── screens/
      ├── payment/
      │   ├── payment_screen.dart
      │   └── widgets/
      │       ├── payment_options_widget.dart
      │       └── booking_summary_widget.dart
      ├── confirmation/
      │   └── booking_confirmation_screen.dart
      └── my_bookings/
          ├── my_bookings_screen.dart
          └── widgets/
              ├── booking_card.dart
              └── booking_details_widget.dart
```

---

## 🧪 Tester: Quality Assurance Lead
**Focus:** Testing, Documentation, and Quality Control

### Responsibilities:
1. **Test Planning**
   - Create test plan document
   - Define test cases for all features
   - Set up testing environment

2. **Manual Testing**
   - Test all user flows end-to-end
   - Test UI responsiveness on different screen sizes
   - Cross-platform testing (Android/iOS if possible)
   - Test edge cases and error handling

3. **Widget Testing**
   - Write widget tests for critical components
   - Test navigation flows
   - Test form validations

4. **Integration Testing**
   - Test complete booking flow
   - Test data persistence
   - Test state management

5. **Bug Tracking & Documentation**
   - Create and maintain bug report document
   - Track issues in GitHub Issues
   - Document test results
   - Create user guide/README

6. **DevOps Support**
   - Help set up CI/CD pipeline (GitHub Actions)
   - Create build configurations
   - Assist with release documentation

### Deliverables:
```
test/
  ├── widget_tests/
  │   ├── home_screen_test.dart
  │   ├── search_results_test.dart
  │   ├── booking_flow_test.dart
  │   └── payment_test.dart
  ├── integration_tests/
  │   └── complete_booking_flow_test.dart
  └── unit_tests/
      ├── train_provider_test.dart
      └── booking_provider_test.dart

docs/
  ├── TEST_PLAN.md
  ├── BUG_REPORT.md
  ├── USER_GUIDE.md
  └── TEST_RESULTS.md

.github/
  └── workflows/
      └── flutter_ci.yml
```

---

## 📦 Required Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.1           # State management
  shared_preferences: ^2.2.2  # Local storage
  intl: ^0.19.0              # Date formatting
  uuid: ^4.3.3               # Generate PNR numbers

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  integration_test:
    sdk: flutter
```

---

## 🗓️ Timeline (2-3 Weeks)

### Week 1: Foundation
- **Day 1-2**: Developer 1 - Project setup, theme, navigation
- **Day 1-2**: Developer 2 - Data models and mock data
- **Day 3-5**: Developer 1 - Home screen implementation
- **Day 3-5**: Developer 2 - Search results screen
- **Day 1-5**: Tester - Test plan creation and setup

### Week 2: Core Features
- **Day 6-8**: Developer 3 - Train details and passenger form
- **Day 6-8**: Developer 4 - Payment and confirmation screens
- **Day 9-10**: Developer 3 - Finalize booking flow
- **Day 9-10**: Developer 4 - My bookings screen
- **Day 6-10**: Tester - Testing all completed features

### Week 3: Polish & Testing
- **Day 11-12**: All Developers - Bug fixes and UI polish
- **Day 13-14**: Developer 1 & 2 - Code review and optimization
- **Day 13-14**: Developer 3 & 4 - Documentation and cleanup
- **Day 11-15**: Tester - Final testing, test reports, CI/CD setup

---

## 🔄 Communication & Collaboration

### Daily Standups (15 min)
- What did you complete yesterday?
- What will you work on today?
- Any blockers?

### GitHub Workflow
1. **Branching Strategy:**
   - `main` - Production ready code
   - `develop` - Integration branch
   - `feature/developer-name-feature` - Feature branches

2. **Pull Request Process:**
   - Create PR when feature is complete
   - At least one peer review required
   - Tester approval needed before merge to main

3. **Issue Tracking:**
   - Use GitHub Issues for bugs and features
   - Label: `bug`, `enhancement`, `documentation`, `testing`
   - Assign issues to respective team members

---

## 📱 App Features Summary
1. ✅ Search trains by source, destination, and date
2. ✅ View train details and availability
3. ✅ Book tickets with passenger details
4. ✅ Mock payment flow
5. ✅ View booking confirmation with PNR
6. ✅ View all bookings (My Bookings)
7. ✅ Cancel bookings (mock)
8. ✅ Responsive UI design

---

## 🎯 Success Criteria
- App runs without crashes
- All booking flows work smoothly
- Clean, maintainable code
- Proper Git history with meaningful commits
- Test coverage >60%
- Documentation complete
- CI/CD pipeline operational

---

## 📞 Team Contacts
| Role | Name | GitHub | Email |
|------|------|--------|-------|
| Developer 1 (UI/UX Lead) | | | |
| Developer 1 (UI/UX Lead) | bosco (you) | | |
| Developer 2 (Data Layer) | | | |
| Developer 3 (Booking Flow) | | | |
| Developer 4 (Payment) | | | |
| Tester (QA Lead) | | | |

---

**Last Updated:** November 10, 2025
**Project Status:** Planning Phase
