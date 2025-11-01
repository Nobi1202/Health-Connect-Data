# Sleep Data Tracker - Setup Instructions

## Overview
This Flutter app reads and displays sleep data from Health Connect on Android devices. It uses the BLoC pattern for state management and provides a clean UI to view sleep sessions from the last 7 days.

## Features Implemented

### ✅ Health Connect Status Check
- Automatically checks if Health Connect is installed
- Provides clear messaging when Health Connect is not available
- Offers direct link to install Health Connect from Google Play Store

### ✅ Permission Management
- Requests necessary sleep data permissions
- Handles permission denial gracefully
- Provides "Retry Permission" button for users who initially denied

### ✅ Sleep Data Display
- Fetches sleep data for the last 7 days
- Shows loading indicator during data retrieval
- Groups sleep sessions by date
- Displays different sleep stages (Asleep, Awake, In Bed, Deep Sleep, REM, Light Sleep)
- Shows duration, time range, and source app for each session
- Pull-to-refresh functionality
- "No Data" message when no sleep sessions are found

### ✅ BLoC State Management
- Clean separation of business logic
- Reactive state updates
- Easy to test and maintain

## Prerequisites

### Required
- **Real Android device** (Android 9.0 / API 28 or higher)
  - Health Connect is NOT supported in emulators
- **Health Connect app** installed on the device
- **Sleep tracking app** (one or more):
  - Google Fit
  - Samsung Health
  - Better Sleep
  - Pokémon Sleep
  - Fitbit
  - Sleep as Android
  - Any other app that syncs with Health Connect

## Setup Instructions

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Connect Your Android Device
- Enable Developer Mode on your Android device
- Enable USB Debugging
- Connect device via USB
- Verify connection:
```bash
flutter devices
```

### 3. Install Health Connect on Your Device
If Health Connect is not installed:
1. Open Google Play Store
2. Search for "Health Connect"
3. Install the official "Health Connect" app by Google LLC
4. Open Health Connect and complete initial setup

### 4. Run the App
```bash
flutter run
```

## Testing the App

### Step 1: First Launch
When you first launch the app, it will:
1. Check if Health Connect is installed
2. If not installed, show a message with an "Install" button
3. If installed, check for permissions

### Step 2: Grant Permissions
1. When prompted, tap "Retry Permission" or the app will auto-prompt
2. The Health Connect permission dialog will appear
3. Select the sleep data types you want to allow
4. Tap "Allow" to grant permissions

### Step 3: Generate Test Sleep Data

#### Option A: Using Google Fit
1. Install Google Fit from Play Store
2. Open Google Fit
3. Connect it with Health Connect
4. Manually add sleep sessions:
   - Tap Journal (bottom navigation)
   - Tap "+" button
   - Select "Sleep"
   - Enter sleep time, wake time, and date
   - Save

#### Option B: Using Better Sleep
1. Install Better Sleep from Play Store
2. Open Better Sleep
3. Connect it with Health Connect
4. Track sleep or manually add sleep sessions

#### Option C: Using Samsung Health (Samsung devices)
1. Open Samsung Health (pre-installed on Samsung devices)
2. Connect it with Health Connect
3. Track sleep or add manual entries

### Step 4: Sync and View Data
1. Once sleep data is recorded in any connected app
2. Open Health Connect and verify data is there
3. Return to the Sleep Data Tracker app
4. Pull down to refresh
5. View your sleep sessions grouped by date

## App Structure

```
lib/
├── main.dart                      # App entry point
├── bloc/
│   ├── health_bloc.dart          # Business logic and Health Connect API calls
│   ├── health_event.dart         # Events (user actions)
│   └── health_state.dart         # App states
└── screens/
    └── sleep_data_screen.dart    # Main UI screen
```

## Key Technologies Used

- **Flutter SDK**: Cross-platform framework
- **Dart**: Programming language
- **flutter_bloc**: State management
- **health package**: Health Connect integration
- **equatable**: Value equality
- **url_launcher**: Opening Play Store
- **intl**: Date formatting

## Troubleshooting

### "Health Connect is required" message appears
- Ensure Health Connect is installed from Google Play Store
- Restart the app after installation

### "No Data" appears
- Ensure you have sleep tracking apps installed
- Make sure sleep data is synced with Health Connect
- Check Health Connect app to verify sleep data exists
- Try pulling down to refresh

### Permission denied
- Tap "Retry Permission"
- Make sure to allow all sleep-related permissions
- Check app permissions in device Settings

### App won't run on emulator
- This is expected - Health Connect only works on real devices
- Use a physical Android device with API 28+

## Features by Requirement

| Requirement | Status | Implementation |
|------------|--------|----------------|
| Check Health Connect Status | ✅ | Auto-checks on app launch |
| Install Health Connect Flow | ✅ | Button opens Play Store |
| Request Permissions | ✅ | System dialog via health package |
| Permission Retry | ✅ | "Retry Permission" button |
| Read 7 Days Sleep Data | ✅ | Fetches from Health Connect |
| Loading Indicator | ✅ | Shows during data fetch |
| Display Sleep Sessions | ✅ | Grouped by date, expandable cards |
| No Data Message | ✅ | Shown when no sleep data found |
| BLoC State Management | ✅ | Clean architecture with events/states |

## Next Steps / Potential Enhancements

- Add filters by sleep type
- Add charts/graphs for sleep trends
- Export sleep data to CSV
- Add sleep quality scoring
- Multiple language support
- Dark mode theme
- Sleep statistics summary

## Support

For issues with:
- **Health Connect**: Check official Google Health Connect documentation
- **Flutter health package**: Visit https://pub.dev/packages/health
- **App bugs**: Check the code in `/lib` directory

## License

This project is for educational/assignment purposes.
