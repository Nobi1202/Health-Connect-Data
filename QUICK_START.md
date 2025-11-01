# Sleep Data Tracker - Quick Start Guide

## 🎯 What This App Does

This app reads your sleep data from Health Connect and displays it in an easy-to-read format, showing your sleep patterns from the last 7 days.

## 📱 How to Use

### Step 1: Initial Setup
1. **Connect your Android device** to your computer
2. **Run the app**: `flutter run`
3. The app will automatically check for Health Connect

### Step 2: Install Health Connect (if needed)
If you see "Health Connect Required" screen:
- Tap **"Install Health Connect"** button
- This opens Google Play Store
- Install the app
- Return to Sleep Data Tracker
- Tap **"I have installed it, check again"**

### Step 3: Grant Permissions
When the permission screen appears:
- Tap **"Retry Permission"** (or it may auto-prompt)
- In the Health Connect dialog:
  - ✅ Check all sleep-related permissions
  - Tap **"Allow"**

### Step 4: Add Sleep Data
The app needs sleep data to display. Use any of these apps:

#### Option 1: Google Fit (Recommended for Testing)
1. Install Google Fit
2. Open Google Fit → Settings → Connect with Health Connect
3. Go to Journal tab → Tap "+" → Select "Sleep"
4. Add manual sleep entries:
   - **Yesterday**: 11:00 PM - 7:00 AM
   - **2 days ago**: 10:30 PM - 6:30 AM
   - **3 days ago**: 11:30 PM - 7:30 AM

#### Option 2: Samsung Health (Samsung Devices)
1. Open Samsung Health
2. Connect with Health Connect
3. Track or manually add sleep

#### Option 3: Better Sleep
1. Install from Play Store
2. Complete setup and connect to Health Connect
3. Use the app to track sleep

### Step 5: View Your Data
- Open the Sleep Data Tracker app
- **Pull down** to refresh
- See your sleep sessions grouped by date
- **Tap on a date** to expand and see details

## 📊 What You'll See

### Sleep Session Details
Each sleep session shows:
- 🌙 **Sleep Type**: Asleep, Deep Sleep, REM, Light Sleep, Awake, In Bed
- ⏰ **Time**: Start and end times
- ⏱️ **Duration**: Hours and minutes
- 📱 **Source**: Which app recorded this data

### Example Display
```
📅 Friday, Oct 31, 2025
    🌙 Asleep
    From: 23:00 - To: 07:00
    Duration: 8h 0m
    Source: Google Fit
    
    🌜 Deep Sleep
    From: 01:30 - To: 03:45
    Duration: 2h 15m
    Source: Google Fit
```

## 🔄 App States You May See

| Screen | What It Means | What To Do |
|--------|---------------|------------|
| Loading spinner | App is checking status | Wait a moment |
| "Health Connect Required" | Health Connect not installed | Tap "Install" button |
| "Permission Required" | Need to grant access | Tap "Retry Permission" |
| Loading with "Loading sleep data..." | Fetching your data | Wait a moment |
| List of sleep sessions | Success! Data loaded | Browse your sleep data |
| "No Data" | No sleep recorded yet | Add sleep data in connected apps |

## ⚡ Quick Testing Checklist

- [ ] Health Connect installed
- [ ] Permissions granted
- [ ] At least one sleep tracking app installed
- [ ] Sleep data synced to Health Connect
- [ ] App shows sleep sessions

## 🐛 Troubleshooting

### "No Data" appears even though I have sleep data
1. Open Health Connect app directly
2. Check if sleep data appears there
3. If yes → Pull down to refresh in Sleep Data Tracker
4. If no → Make sure your sleep app is connected to Health Connect

### Permission dialog doesn't appear
1. Go to device Settings
2. Apps → Sleep Data Tracker → Permissions
3. Manually grant Health Connect permissions
4. Reopen the app

### App crashes or shows errors
1. Make sure you're using a real device (not emulator)
2. Android version should be 9.0 or higher
3. Restart the app
4. Tap "Retry" if error screen appears

## 🎨 UI Features

- **Pull to Refresh**: Drag down on the sleep list to reload data
- **Expandable Cards**: Tap a date to expand/collapse sessions
- **Color-Coded Icons**: Different icons for different sleep stages
- **Material Design 3**: Modern, clean interface

## 📝 Important Notes

✅ **Real Device Required**: Health Connect doesn't work on emulators  
✅ **Android 9.0+**: Minimum SDK 28 required  
✅ **Last 7 Days**: App shows sleep data from the past week  
✅ **Privacy**: Data stays on your device, read from Health Connect only

## 🎓 Assignment Requirements Met

| Requirement | ✅ Status |
|-------------|---------|
| Check Health Connect Status | ✅ Implemented |
| Install Health Connect Flow | ✅ Implemented |
| Request Permissions | ✅ Implemented |
| Permission Retry | ✅ Implemented |
| Read 7 Days Sleep Data | ✅ Implemented |
| Display Sleep Sessions | ✅ Implemented |
| Loading Indicator | ✅ Implemented |
| No Data Message | ✅ Implemented |
| BLoC State Management | ✅ Implemented |
| Health Package | ✅ Implemented |

## 🚀 Next Steps After Setup

1. Use the app daily to track your sleep patterns
2. Compare data from different sleep tracking apps
3. Notice how different apps categorize sleep stages
4. Pull to refresh to see latest data
5. Explore expandable cards for detailed information

---

**Ready to test?** Connect your Android device and run: `flutter run`
