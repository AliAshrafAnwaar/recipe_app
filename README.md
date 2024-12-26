# Recipe App

## Features

- **User Authentication**: Sign up, sign in, and sign out functionalities using Firebase Authentication.
- **User Profiles**: Users can create and update their profiles, including profile pictures and bio.
- **Recipe Management**: Users can create, update, and delete recipes.
- **Real-time Updates**: Real-time data synchronization using Firebase Firestore.
- **Recipe Ratings**: Users can rate recipes.
- **Recipe Likes**: Users can like and unlike recipes.
- **Favorites**: Users can add and remove recipes from their favorites.
- **Comments**: Users can comment on recipes.
- **Search**: Search for recipes by title.

## How to Run the Application

### Prerequisites

- **Flutter**: Ensure you have Flutter installed on your machine. You can download it from [flutter.dev](https://flutter.dev/docs/get-started/install).
- **Firebase Account**: Create a Firebase project and configure it for your application. Follow the instructions on [Firebase](https://firebase.google.com/).

### Steps

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/your-username/recipe_app.git
   cd recipe_app
   ```

2. **Install Dependencies**:
   ```sh
   flutter pub get
   ```

3. **Configure Firebase**:
   - Add your `google-services.json` file to the `android/app` directory.
   - Add your `GoogleService-Info.plist` file to the `ios/Runner` directory.
   - Ensure your `firebase_options.dart` file is correctly configured.

4. **Run the Application**:
   - For Android:
     ```sh
     flutter run
     ```
   - For iOS:
     ```sh
     flutter run
     ```

5. **Build the Application** (Optional):
   - For Android:
     ```sh
     flutter build apk
     ```
   - For iOS:
     ```sh
     flutter build ios
     ```

### Additional Notes

- Ensure your Firebase project is correctly set up with Firestore and Authentication enabled.
- Update the `pubspec.yaml` file if you add any new dependencies.
- Follow the Flutter and Firebase documentation for any additional setup or troubleshooting.

By following these steps, you should be able to run the Recipe App on your local machine.