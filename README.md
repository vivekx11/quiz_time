# Quiz App - Production Ready

A beautiful, feature-rich quiz application built with Flutter that uses the Open Trivia Database API.

## 📱 Features

### ✅ Complete Authentication System
- **First-time users**: Create account screen on first launch
- **Secure login**: Email and password authentication
- **Persistent sessions**: Auto-login for returning users
- **Logout functionality**: Secure logout with session clearing

### ✅ Quiz Categories
- 9 carefully selected categories:
  - General Knowledge
  - Books
  - Film
  - Science & Nature
  - Computers
  - Mathematics
  - Sports
  - Geography
  - History

### ✅ Quiz Features
- Multiple difficulty levels (Easy, Medium, Hard)
- 10 questions per quiz
- Real-time score tracking
- Beautiful animations and transitions
- Progress indicators
- Instant feedback on answers

### ✅ History Management
- View all completed quiz results
- **Swipe to delete** - Swipe left on any history item to delete
- Confirmation dialog before deletion
- Score percentage with color coding
- Date tracking for each quiz

### ✅ Modern UI/UX
- Dark theme with gradient backgrounds
- Glass morphism design
- Smooth animations
- Material Design 3
- Responsive layout

## 📂 Project Structure

```
quiz_app/
├── lib/
│   ├── main.dart           # App entry point, splash screen, authentication check
│   ├── home.dart           # Login and signup screens
│   ├── page.dart           # Categories, difficulty selection, quiz, and score pages
│   └── setting.dart        # Settings page with history and logout
├── assets/
│   └── icon/
│       └── app_icon.png    # App icon
├── android/                # Android specific files
├── ios/                    # iOS specific files
├── web/                    # Web specific files
├── windows/                # Windows specific files
├── pubspec.yaml            # Dependencies and assets
├── README.md               # This file
└── CHANGELOG.md            # Detailed changes documentation
```

## 🔧 File Details

### 1. `lib/main.dart`
**Path**: `C:\Users\Vivek\quiz_app\lib\main.dart`

**Purpose**: 
- App initialization
- Theme configuration
- Splash screen with auto-navigation
- Checks if user is logged in and navigates accordingly

**Key Features**:
- Design tokens (colors)
- Animated splash screen with glowing logo
- Auto-redirect based on authentication status

### 2. `lib/home.dart`
**Path**: `C:\Users\Vivek\quiz_app\lib\home.dart`

**Purpose**: 
- User authentication (Login/Signup)
- Account creation for new users
- Session management with SharedPreferences

**Key Features**:
- Toggle between login and signup
- Form validation
- Persistent authentication state
- Beautiful glass morphism design

### 3. `lib/page.dart`
**Path**: `C:\Users\Vivek\quiz_app\lib\page.dart`

**Purpose**: 
- Quiz categories display (9 categories)
- Difficulty selection
- Quiz gameplay
- Score display

**Key Features**:
- 3x3 grid layout for categories
- Color-coded difficulty levels
- Real-time quiz with animations
- Score calculation and display

### 4. `lib/setting.dart`
**Path**: `C:\Users\Vivek\quiz_app\lib\setting.dart`

**Purpose**: 
- Quiz history management
- Swipe-to-delete functionality
- Logout feature

**Key Features**:
- Dismissible widget for swipe-to-delete
- Confirmation dialog before deletion
- Color-coded score display
- Logout redirects to login page

### 5. `pubspec.yaml`
**Path**: `C:\Users\Vivek\quiz_app\pubspec.yaml`

**Purpose**: 
- Project configuration
- Dependencies management
- Assets declaration

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0                    # API calls to Open Trivia DB
  html_unescape: ^2.0.0           # Decode HTML entities in questions
  hive: ^2.2.3                    # Local database for quiz history
  hive_flutter: ^1.1.0            # Hive Flutter integration
  google_fonts: ^6.1.0            # Beautiful Poppins font
  shared_preferences: ^2.2.2      # Store authentication state
```

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile)

### Step 1: Clone or Download
```bash
cd C:\Users\Vivek\quiz_app
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Run the App
```bash
# For development
flutter run

# For specific device
flutter run -d chrome        # Web
flutter run -d windows       # Windows
flutter run -d <device-id>   # Mobile device
```

### Step 4: Build for Production

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle:**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**iOS:**
```bash
flutter build ios --release
```

**Windows:**
```bash
flutter build windows --release
# Output: build/windows/x64/runner/Release/
```

**Web:**
```bash
flutter build web --release
# Output: build/web/
```

## 📱 User Flow

### First Time User Journey
1. **Launch App** → Splash screen (2 seconds)
2. **Create Account** → Enter email and password
3. **Redirected to Login** → Login with credentials
4. **Quiz Categories** → Select a category
5. **Select Difficulty** → Choose Easy/Medium/Hard
6. **Play Quiz** → Answer 10 questions
7. **View Score** → See results and accuracy
8. **Check History** → View in Settings

### Returning User Journey
1. **Launch App** → Splash screen (2 seconds)
2. **Auto Login** → Direct to categories
3. **Play Quiz** → Start immediately
4. **Logout** → Returns to login screen

### Delete Quiz History
1. Go to **Settings** (gear icon on categories page)
2. Find the quiz result you want to delete
3. **Swipe left** on the item
4. Red delete background appears
5. **Confirm deletion** in dialog
6. Item is permanently removed

## 🎨 Design System

### Colors
- **Background**: `#0F172A` (Dark blue)
- **Surface**: `#1E293B` (Slate)
- **Primary**: `#14B8A6` (Teal)
- **Accent**: `#F59E0B` (Amber)
- **Success**: `#22C55E` (Green)
- **Error**: `#EF4444` (Red)

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Weights**: 400, 500, 600, 700, 800

## 🔐 Data Storage

### SharedPreferences (Authentication)
- `isLoggedIn`: Boolean - User login status
- `hasAccount`: Boolean - Account creation status
- `userEmail`: String - User's email

### Hive (Quiz History)
- **Box Name**: `quiz_scores`
- **Key**: `scores`
- **Data Structure**:
```dart
{
  'category': String,
  'score': int,
  'total': int,
  'date': String (ISO 8601)
}
```

## 🌐 API

**Open Trivia Database**
- Base URL: `https://opentdb.com/api.php`
- Parameters:
  - `amount`: 10 (questions per quiz)
  - `category`: Category ID
  - `difficulty`: easy/medium/hard
  - `type`: multiple (multiple choice)

## 🐛 Troubleshooting

### Issue: Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Issue: Build errors
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Issue: App not running
```bash
flutter doctor
# Fix any issues shown
```

### Issue: Hive errors
```bash
# Delete app data and reinstall
flutter clean
flutter run
```

## 📝 Testing Checklist

- [x] First launch shows create account
- [x] Account creation works
- [x] Login saves session
- [x] Only 9 categories displayed
- [x] All difficulty levels work
- [x] Quiz questions load correctly
- [x] Answers are validated
- [x] Score is calculated correctly
- [x] History saves quiz results
- [x] Swipe-to-delete works
- [x] Confirmation dialog appears
- [x] Logout clears session
- [x] Returning users auto-login

## 🔄 Recent Updates

### Version 2.0 (Latest)
- ✅ Added complete authentication system
- ✅ Removed "Art" category (9 categories total)
- ✅ Added swipe-to-delete for quiz history
- ✅ Fixed logout to redirect to login page
- ✅ Added persistent user sessions
- ✅ Improved UI/UX with animations
- ✅ Added confirmation dialogs

See [CHANGELOG.md](CHANGELOG.md) for detailed changes.

## 📄 License

This project is open source and available for educational purposes.

## 👨‍💻 Developer

**Project Path**: `C:\Users\Vivek\quiz_app`

## 🆘 Support

For issues or questions:
1. Check the troubleshooting section
2. Review CHANGELOG.md for recent changes
3. Run `flutter doctor` to check your setup

## 🎯 Future Enhancements

- [ ] Add user profiles
- [ ] Leaderboard system
- [ ] More quiz categories
- [ ] Timed quizzes
- [ ] Multiplayer mode
- [ ] Social sharing
- [ ] Dark/Light theme toggle
- [ ] Sound effects
- [ ] Achievements system

---

**Made with ❤️ using Flutter**
