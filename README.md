# 📚 MoodStudy App

![Flutter](https://img.shields.io/badge/Flutter-3.44-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12-blue?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Authentication-orange?logo=firebase)
![GetX](https://img.shields.io/badge/GetX-State%20Management-purple)
![SQFLite](https://img.shields.io/badge/Database-SQFLite-green)
![FL Chart](https://img.shields.io/badge/Charts-FL%20Chart-orange)
![Architecture](https://img.shields.io/badge/Architecture-Clean-success)
![Platform](https://img.shields.io/badge/Platform-Android-brightgreen)

A Flutter-based productivity application designed to help students improve their study habits based on their current mood.

MoodStudy provides personalized study recommendations, mood-based focus sessions, productivity tracking, analytics, and secure user authentication.

The application uses **Firebase Authentication** for user login and account management, **GetX** for state management, **SQFLite** for local data storage, and **FL Chart** for productivity analytics.

---


## ✨ Features

### 🔐 Authentication

- 📝 Create a new account using Email & Password
- 🔑 Secure user login using Firebase Authentication
- 🚪 Logout functionality
- 💾 Persistent login session using Firebase Auth
- ⚠️ Authentication error handling
- 🔄 Automatic user session detection

### 😊 Mood-Based Study

- Select your current mood from six different moods
- Receive personalized study recommendations
- Save mood selections locally
- View mood history
- Delete mood history records
- Identify the most frequently selected mood

### ⏱️ Focus & Productivity

- Start mood-based focus sessions
- Track allocated and actual study time
- Track completed focus sessions
- Store focus session history locally
- Monitor total focus time

### 📊 Analytics

- Weekly Focus Time Bar Chart
- Mood Distribution Pie Chart
- Total Focus Time
- Total Focus Sessions
- Completed Sessions
- Most Used Mood

---

## 📱 App Screens

- Splash / Welcome Screen
- Login Screen
- Sign Up Screen
- Home Screen
- Study Recommendation Screen
- Focus Timer Screen
- Mood History Screen
- Focus Session History Screen
- Analytics Dashboard
- Profile Screen

---

## 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | Cross-platform UI development |
| Dart | Programming language |
| Firebase Authentication | User Signup, Login & Logout |
| GetX | State management & dependency injection |
| SQFLite | Local database storage |
| FL Chart | Analytics visualization |
| Clean Architecture | Project organization |
| Material Design | Application UI |

---

## 🔐 Firebase Authentication

MoodStudy uses **Firebase Authentication** with the Email/Password provider.

The authentication flow includes:

```text
New User
   ↓
Sign Up
   ↓
Firebase Authentication
   ↓
Account Created
   ↓
Home Screen
```

For existing users:

```text
Existing User
   ↓
Login
   ↓
Firebase verifies credentials
   ↓
Home Screen
```

Logout flow:

```text
Profile
   ↓
Logout
   ↓
Firebase Sign Out
   ↓
Login Screen
```

Firebase also maintains the authentication session so users do not need to log in again every time they reopen the application.

---

## 🏗️ Project Architecture

The main application logic follows a layered Clean Architecture approach.

```text
lib/
│
├── core/
│   └── auth_service.dart
│
├── data/
│   ├── database/
│   ├── datasource/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── bindings/
│   ├── controllers/
│   └── pages/
│       ├── login_screen.dart
│       ├── signup_screen.dart
│       ├── home_screen.dart
│       ├── focus_screen.dart
│       ├── analytics_screen.dart
│       └── profile_screen.dart
│
├── firebase_options.dart
└── main.dart
```

Firebase Authentication is currently integrated through a simple authentication service, while GetX and the layered architecture are used for the application's mood, focus, and productivity features.

---

## 🗄️ Local Database Structure

MoodStudy uses **SQFLite** to store mood and focus-session data locally.

### `mood_table`

| Column | Type |
|--------|------|
| id | INTEGER |
| mood | TEXT |
| recommendation | TEXT |
| focusTime | TEXT |
| date | TEXT |

### `focus_table`

| Column | Type |
|--------|------|
| id | INTEGER |
| mood | TEXT |
| allocatedSeconds | INTEGER |
| studiedSeconds | INTEGER |
| status | TEXT |
| date | TEXT |

---

## 📊 Analytics Dashboard

The Analytics Dashboard provides:

- 📈 Total Focus Time
- 📚 Total Focus Sessions
- ✅ Completed Sessions
- 📌 Most Used Mood
- 📊 Weekly Focus Bar Chart
- 🥧 Mood Distribution Pie Chart

---

## 🚀 How It Works

1. Create an account or log in using Firebase Authentication.
2. Select your current mood.
3. Receive a study recommendation based on the selected mood.
4. Start a mood-based focus timer.
5. Complete and track your study session.
6. Store mood and focus-session data locally using SQFLite.
7. View productivity statistics through the Analytics Dashboard.
8. Review previous mood and focus-session history.
9. Logout securely from the Profile screen.

---

## 📦 Main Dependencies

```yaml
dependencies:
  firebase_core:
  firebase_auth:
  get: ^4.7.3
  sqflite: ^2.4.3
  path: ^1.9.1
  fl_chart: ^1.0.0
```

> Check `pubspec.yaml` for the exact Firebase package versions used in the current project.

---

## ⚙️ Firebase Setup

This project uses Firebase Authentication.

After cloning the repository, configure Firebase for your own Firebase project using FlutterFire:

```bash
firebase login
flutterfire configure
```

Enable:

```text
Firebase Console
→ Authentication
→ Sign-in method
→ Email/Password
→ Enable
```

The generated Firebase configuration is initialized in `main.dart`.

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/amritabharti26/MoodStudy-App.git
```

### 2. Move into the project directory

```bash
cd MoodStudy-App
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

```bash
flutterfire configure
```

### 5. Run the application

```bash
flutter run
```

---

## 📈 Future Improvements

- 🤖 AI-powered personalized study suggestions
- ☁️ Cloud synchronization using Cloud Firestore
- 🔐 Google Sign-In
- ✉️ Email verification
- 🔑 Forgot Password / Password Reset
- 🌙 Dark Mode
- 🔔 Push Notifications
- 🎯 Daily Study Goals
- 📅 Study Streak Tracking
- 📄 Export productivity reports as PDF
- 📊 Weekly and monthly productivity reports

---

## 👩‍💻 Developed By

**Amrita Bharti**

🎓 B.Tech Computer Science Engineering  
💙 Flutter Developer  

GitHub: `amritabharti26`

---

## 📄 License

This project is developed for learning, academic, and portfolio purposes.

---

⭐ If you found this project useful, consider giving it a star!
