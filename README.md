<div align="center">

# Chargerrr

**A Modern EV Charging Station Finder App**

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Supabase](https://img.shields.io/badge/Supabase-Database-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.io/)
[![GetX](https://img.shields.io/badge/GetX-State_Management-8A2BE2?style=for-the-badge&logo=flutter&logoColor=white)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

<img src="assets/icons/app-logo.png" alt="Chargerrr Logo" width="120"/>

</div>

## 📋 Overview

Chargerrr is a modern Flutter application designed to help electric vehicle owners find, explore, and contribute to a community-driven database of charging stations. With an intuitive interface and powerful features, Chargerrr makes it easy to locate available charging points when you need them most.

## ✨ Key Features

- **🔍 Discover Stations**: Browse and search for nearby charging stations
- **🔐 User Authentication**: Secure sign-up, login, and profile management
- **📍 Interactive Maps**: View stations on an interactive map interface
- **⚡ Real-time Availability**: Check charging point availability before you arrive
- **🏪 Amenities Information**: See what facilities are available at each location
- **➕ Contribute**: Add new charging stations to help the community
- **🔎 Advanced Filtering**: Filter stations by availability, amenities, and more
- **🧭 Navigation**: Get directions to your selected charging station

## 🏗️ Architecture

Chargerrr follows Clean Architecture principles, ensuring separation of concerns and testability:

```
lib/
├── core/            # Core utilities, constants, themes, and routes
├── data/            # Data layer (repositories implementation, data sources, models)
├── domain/          # Domain layer (entities, repository interfaces, use cases)
└── presentation/    # Presentation layer (screens, widgets, controllers)
```

## 🛠️ Tech Stack

- **Frontend**: Flutter & Dart
- **State Management**: GetX for reactive state management
- **Backend**: Supabase for authentication and database
- **Maps**: Google Maps integration
- **Architecture**: Clean Architecture with SOLID principles
- **Testing**: Unit and widget tests with Mockito

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter plugins
- Supabase account
- Google Maps API key

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/chargerrr.git
   cd chargerrr
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Create app_credentials.dart file**

   Create a file at `lib/app_credentials.dart` with your API keys:

   ```dart
   class AppCredentials {
     static const String supabaseURL = 'YOUR_SUPABASE_URL';
     static const String supabaseAnon = 'YOUR_SUPABASE_ANON_KEY';
     static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
   }
   ```

4. **Configure Google Maps**

   - For Android: Add your API key to `android/app/src/main/AndroidManifest.xml`
   - For iOS: Add your API key to `ios/Runner/AppDelegate.swift`

### Supabase Setup

1. Create a new Supabase project
2. Set up the following tables:

   **profiles**
   ```sql
   create table profiles (
     id uuid references auth.users on delete cascade not null primary key,
     name text,
     avatar_url text,
     created_at timestamp with time zone default now() not null
   );
   ```

   **charging_stations**
   ```sql
   create table charging_stations (
     id uuid default uuid_generate_v4() primary key,
     name text not null,
     address text not null,
     latitude double precision not null,
     longitude double precision not null,
     available_points integer not null,
     total_points integer not null,
     amenities text[] default '{}',
     created_at timestamp with time zone default now() not null,
     created_by uuid references auth.users not null
   );
   ```

3. Set up Row Level Security (RLS) policies for your tables

## 🧪 Testing

The project includes comprehensive tests for all layers of the application:

```bash
# Run all tests
flutter test

# Run specific tests
flutter test test/domain/usecases/auth/login_usecase_test.dart
```

## 📱 Screenshots

*Coming soon*

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

<div align="center">

Made with ❤️ by Siddhes

</div>
