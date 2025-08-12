# Chargerrr - EV Charging Station Aggregator

## Overview

Chargerrr is a Flutter application that helps users discover, view details, and add EV charging stations. The app provides a clean and intuitive interface for finding available charging stations, viewing their amenities, and navigating to them.

## Features

- **User Authentication**: Sign up, login, and logout functionality using Supabase
- **Station Discovery**: Browse and search for charging stations
- **Detailed Station View**: View station details, availability, amenities, and location on a map
- **Station Creation**: Add new charging stations with details and location
- **Map Integration**: Interactive maps for viewing and selecting locations
- **Filtering**: Filter stations by availability and search by name or address

## Technical Stack

- **Frontend**: Flutter
- **State Management**: GetX
- **Backend**: Supabase (Authentication, Database)
- **Maps**: Google Maps Flutter
- **Architecture**: Clean Architecture

## Project Structure

The project follows Clean Architecture principles with the following layers:

- **Domain**: Contains business logic, entities, repositories interfaces, and use cases
- **Data**: Implements repositories and data sources
- **Presentation**: Contains UI components, screens, and controllers
- **Core**: Contains shared utilities, constants, routes, and themes

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Supabase account
- Google Maps API key

### Environment Setup

1. Clone the repository
2. Create a `.env` file in the project root with the following variables:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   GOOGLE_MAPS_API_KEY=your_google_maps_api_key
   ```

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

### Google Maps Setup

1. Create a Google Cloud project
2. Enable the Maps SDK for Android and iOS
3. Create API keys for both platforms
4. Add the API keys to your project:
   - For Android: Add to `android/app/src/main/AndroidManifest.xml`
   - For iOS: Add to `ios/Runner/AppDelegate.swift`

### Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Testing

The project includes unit tests for the domain and data layers. To run the tests:

```bash
flutter test
```
