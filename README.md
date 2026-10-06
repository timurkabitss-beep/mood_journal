# Moodora🌿

A personal mood journal built with Flutter that helps users track their daily mood, activities, and feelings in a simple and visually engaging way.

The project is focused on building a real-world mobile application with local data persistence, authentication, analytics, and a personalized user experience.

## ✨ Features

* 📝 **Daily mood check-in**

    * Select your current mood
    * Track daily activities
    * Record feelings
    * Add a title and personal notes

* 📖 **Mood Journal**

    * Save and manage mood entries
    * View recent journal entries
    * Open individual entries and review their details
    * Delete entries when needed

* 📊 **Mood Analytics**

    * Visualize mood history
    * Analyze activities and feelings
    * Track patterns in your daily emotional state
    * Generate personalized insights

* 🤖 **AI Mood Insights**

    * Analyze mood patterns over a period of time
    * Generate personalized summaries and recommendations
    * Store previous AI-generated insights

* 👤 **User Profile**

    * Manage personal information
    * Change display name and email
    * Customize the application theme
    * Log out of the account
    * Delete the account

* 🎨 **Personalized UI**

    * Custom theme colors
    * Smooth animations and transitions
    * Responsive layouts
    * Custom mood and activity illustrations

## 🛠️ Tech Stack

### Core

* **Flutter**
* **Dart**
* Material 3

### State Management

* **Provider**
* ChangeNotifier

### Backend & Authentication

* **Firebase Authentication**
* **Cloud Firestore**
* **Firebase AI Logic**

### Local Storage

* **Hive**

### UI & Navigation

* Custom widgets
* Custom animations
* SVG assets
* Flutter navigation

## 🏗️ Project Structure

The project is organized around features and shared application components:

```text
lib/
├── core/
│   ├── data/
│   ├── database/
│   ├── repositories/
│   ├── state/
│   └── widgets/
│
├── features/
│   ├── dashboard/
│   ├── entrance/
│   ├── mood/
│   └── welcome/
│
├── routes/
└── ui/
```

The application separates UI, state management, data access, and reusable components to keep the codebase maintainable as new features are added.

## 🔐 Data & Authentication

User authentication is handled through Firebase Authentication.

Mood entries are stored locally using Hive, allowing the journal to remain fast and accessible without requiring a network connection for basic journal operations.

User-specific data and cloud functionality are handled through Firebase services.

## 🤖 AI Mood Analysis

Mood Journal uses Firebase AI Logic to provide periodic AI-generated insights based on the user's mood history.

The application prepares aggregated mood data and sends it for analysis rather than relying on a single journal entry.

The AI can identify patterns such as:

* frequently occurring moods;
* activities associated with positive or negative mood changes;
* recurring feelings;
* changes in mood over time;
* personalized suggestions for maintaining a healthier routine.

AI-generated information is presented as personal insights and should not be considered medical or psychological advice.

## 📱 Application Flow

```text
Welcome
   │
   ▼
Authentication
   │
   ▼
Dashboard
   │
   ├── Daily Check-in
   │      ├── Mood
   │      ├── Activities
   │      ├── Feelings
   │      └── Summary
   │
   ├── Journal
   │      └── Recent Entries
   │
   ├── Analytics
   │      ├── Mood Statistics
   │      └── AI Insights
   │
   └── Profile
          ├── Personal Information
          ├── Theme
          ├── Settings
          ├── Log Out
          └── Delete Account
```

## 🎯 Project Goals

The main goal of the project is to build a complete Flutter mobile application while practicing real-world development patterns:

* application architecture;
* state management;
* local persistence;
* authentication;
* cloud services;
* asynchronous programming;
* analytics;
* AI integration;
* reusable UI components;
* error handling;
* testing and maintainable code.

## 🚀 Getting Started

### Requirements

* Flutter SDK
* Dart SDK
* Android Studio or Xcode
* Firebase project

### Installation

Clone the repository:

```bash
git clone https://github.com/timurkabitss-beep/mood_journal.git
```

Navigate to the project:

```bash
cd mood_journal
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

### Firebase Configuration

The application requires a Firebase project configured for the required Firebase services.

Create your own Firebase project and configure the Flutter application using the official FlutterFire setup process.

## 📌 Project Status

🚧 **Active development**

The application is continuously being improved with new features, architecture refinements, testing, and performance improvements.

## 👨‍💻 Author

**Timur**

GitHub: [@timurkabitss-beep](https://github.com/timurkabitss-beep)

---

Built with Flutter 💙
