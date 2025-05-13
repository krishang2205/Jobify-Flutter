# Jobify

Jobify is a Flutter-based application designed to connect job seekers with employers. It provides a platform for users to create profiles, post job opportunities, and explore potential candidates or job openings. The app supports multiple platforms, including Android, iOS, web, and desktop.

## Features

- **User Authentication**: Secure login and registration using Firebase Authentication.
- **Company Profiles**: Employers can create and manage their company bios.
- **Job Posts**: Employers can post job opportunities, and job seekers can view and apply.
- **User Profiles**: Job seekers can create detailed profiles showcasing their skills and achievements.
- **Cross-Platform Support**: Runs on Android, iOS, web, and desktop platforms.
- **Firebase Integration**: Real-time database and storage for seamless data management.

## Project Structure

```
lib/
├── controllers/         # Business logic and state management
├── Firebase/            # Firebase services and configurations
├── models/              # Data models for users, companies, and posts
├── pages/               # UI screens and pages
├── routes/              # Navigation and routing
├── utils/               # Utility functions and helpers
├── Widgets/             # Reusable UI components
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Firebase account with a configured project

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/krishang2205/jobify.git
   cd jobify
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Add your `google-services.json` file to the `android/app/` directory.
   - Add your `GoogleService-Info.plist` file to the `ios/Runner/` directory.

4. Run the app:
   ```bash
   flutter run
   ```

## Screenshots

_Add screenshots or GIFs of your app here._

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
