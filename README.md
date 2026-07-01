# 📚 MoodStudy App

![Flutter](https://img.shields.io/badge/Flutter-3.44-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12-blue?logo=dart)
![GetX](https://img.shields.io/badge/GetX-State%20Management-purple)
![SQFLite](https://img.shields.io/badge/Database-SQFLite-green)
![FL Chart](https://img.shields.io/badge/Charts-FL%20Chart-orange)
![Architecture](https://img.shields.io/badge/Architecture-Clean-success)
![Platform](https://img.shields.io/badge/Platform-Android-brightgreen)

A Flutter-based productivity application that helps students improve their study habits by tracking their mood, recommending personalized study methods, managing focus sessions, and visualizing productivity analytics.

The application follows **Clean Architecture**, uses **GetX** for state management, **SQFLite** for local database storage, and **FL Chart** for analytics visualization.

---

## ✨ Features

- 😊 Select your current mood from six different moods
- 📖 Receive personalized study recommendations
- ⏱️ Start a mood-based focus timer
- 💾 Store mood history using SQFLite
- 📊 Visualize weekly focus time using Bar Charts
- 🥧 Analyze mood distribution using Pie Charts
- 📈 Monitor total focus time
- ✅ Track completed study sessions
- 📌 Identify the most frequently selected mood
- 🗑️ Delete mood history records

---

## 📱 App Screens

- Splash Screen
- Home Screen
- Recommendation Screen
- Focus Timer
- Mood History
- Analytics Dashboard
- Profile Screen

---

## 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | UI Development |
| Dart | Programming Language |
| GetX | State Management & Dependency Injection |
| SQFLite | Local Database |
| FL Chart | Analytics Charts |
| Clean Architecture | Project Structure |

---

## 🏗️ Project Architecture

The application follows **Clean Architecture**.

```
lib/
│
├── core/
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
│
└── main.dart
```

---

## 🗄️ Database Structure

## mood_table

| Column | Type |
|---------|------|
| id | INTEGER |
| mood | TEXT |
| recommendation | TEXT |
| focusTime | TEXT |
| date | TEXT |

---

## focus_table

| Column | Type |
|---------|------|
| id | INTEGER |
| mood | TEXT |
| allocatedSeconds | INTEGER |
| studiedSeconds | INTEGER |
| status | TEXT |
| date | TEXT |

---

## 📊 Analytics

The Analytics Dashboard provides:

- 📈 Total Focus Time
- 📚 Total Sessions
- ✅ Completed Sessions
- 📌 Most Used Mood
- 📊 Weekly Focus Bar Chart
- 🥧 Mood Distribution Pie Chart

---

# 🚀 How It Works

1. Select your current mood.
2. Save the selected mood.
3. Receive a personalized study recommendation.
4. Start the focus timer.
5. Track your study session.
6. View analytics and mood history.

---

## 📦 Dependencies

```yaml
get: ^4.7.3
sqflite: ^2.4.3
path: ^1.9.1
fl_chart: ^1.0.0
```

---

## 🚀 Getting Started

Clone the repository

```bash
git clone https://github.com/amritabharti26/MoodStudy-App.git
```

Move into the project directory

```bash
cd MoodStudy-App
```

Install dependencies

```bash
flutter pub get
```

Run the application

```bash
flutter run
```

---

## 📈 Future Improvements

- 🌙 Dark Mode
- 🔔 Push Notifications
- ☁️ Cloud Synchronization
- 🎯 Daily Study Goals
- 📅 Study Streak Tracking
- 📄 Export Reports as PDF
- 🤖 AI-Powered Study Suggestions

---

## 👩‍💻 Developed By

**Amrita Bharti**

🎓 B.Tech Computer Science Engineering

💙 Flutter Developer

🔗 GitHub: https://github.com/amritabharti26

---

## 📄 License

This project is developed for learning, academic, and portfolio purposes.

---

⭐ If you found this project useful, consider giving it a star on GitHub!
