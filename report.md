# Recipe App

## Database Selection Report

### 1. Selection Criteria

The criteria used to choose the database for this application include:

- **Scalability**: The ability to handle a growing amount of data and users.
- **Real-time capabilities**: Support for real-time data synchronization.
- **Ease of integration**: Compatibility with the Flutter framework and ease of integration.
- **Cost**: Affordability and cost-effectiveness for both development and production environments.
- **Security**: Robust security features to protect user data.
- **Community and support**: Availability of community support and documentation.

### 2. Comparison

#### Chosen Database: Firebase Firestore

**Pros:**
- **Real-time synchronization**: Firebase Firestore provides real-time data synchronization, which is essential for a responsive user experience.
- **Scalability**: Firestore is designed to scale automatically with the growth of the application.
- **Ease of integration**: Firebase offers a Flutter plugin, making it easy to integrate with the Flutter framework.
- **Security**: Firestore provides robust security rules to protect data.
- **Offline support**: Firestore supports offline data access, allowing the app to function without an internet connection.
- **Community and support**: Firebase has extensive documentation and a large community of developers.

**Cons:**
- **Cost**: While Firebase offers a free tier, costs can increase significantly with high usage.
- **Vendor lock-in**: Using Firebase ties the application to Google's ecosystem.

#### Alternative Database: MongoDB

**Pros:**
- **Scalability**: MongoDB is highly scalable and can handle large amounts of data.
- **Flexibility**: MongoDB's schema-less design allows for flexible data modeling.
- **Community and support**: MongoDB has a large community and extensive documentation.

**Cons:**
- **Real-time capabilities**: MongoDB does not natively support real-time data synchronization, requiring additional tools like Change Streams or third-party services.
- **Integration**: Integrating MongoDB with Flutter requires additional setup and configuration compared to Firebase.
- **Cost**: While MongoDB offers a free tier, costs can increase with high usage and additional services.

### 3. Implementation Plan

#### Data Structure

The data structure for the Recipe App will include the following collections:

- **Users**: Stores user information such as:
  - `userID`: Unique identifier for the user
  - `username`: User's display name
  - `email`: Email address
  - `phoneNumber`: Contact number
  - `bio`: Short biography
  - `image`: Profile picture URL
  - `recipes`: Set of recipe IDs created by the user
  - `favourites`: Set of recipe IDs marked as favorites

- **Recipes**: Stores recipe information such as:
  - `recipeID`: Unique identifier for the recipe
  - `title`: Recipe title
  - `description`: Detailed description
  - `userID`: ID of the user who created the recipe
  - `imageLink`: URL to the recipe image
  - `date`: Creation date
  - `ratings`: List of ratings (as doubles)
  - `likes`: Set of user IDs who liked the recipe
  - `comments`: List of maps containing `userID` and comment text
  - `favourites`: Set of user IDs who marked the recipe as favorite

#### Integration

1. **Setup Firebase**:
   - Initialize Firebase in the Flutter app by adding the necessary dependencies.
   - Configure Firebase in the `main.dart` file to connect with the app.

2. **Authentication**:
   - Implement Firebase Authentication to manage user sign-up, sign-in, and sign-out functionalities.

3. **Firestore Integration**:
   - Use the Firestore plugin to interact with the Firestore database.
   - Implement CRUD (Create, Read, Update, Delete) functions for managing data in the Firestore collections.

4. **Real-time Updates**:
   - Leverage Firestore's real-time capabilities to synchronize data across the app seamlessly.

5. **Security Rules**:
   - Define Firestore security rules to ensure user data is protected and only authorized access is allowed.

6. **Offline Support**:
   - Enable Firestore's offline support to ensure the app remains functional without an internet connection.

#### My Implementation Steps

1. Spent three hours brainstorming UI concepts and finalizing the primary screens. Implemented the core screens: `Home()`, `Profile()`, `PostCard()`, `PostDetails()`, and `Menu()`.
2. Dedicated two hours to designing the user model and analyzing user requirements. Finalized the UI for authentication screens (Sign In, Sign Up, Forgot Password). Added new screens such as `Search()` and selected an optimal color palette for the application.
3. Initiated the implementation of authentication, storage, and Firestore integration using Firebase. Completed email and password-based authentication, with plans to incorporate Google Authentication for future enhancements.
4. Integrated Firebase Storage and Firestore for managing profile and post images. Added a feature allowing users to update their details, including phone number, username, and bio.
5. Began developing the "My Listings" screen, enabling users to view their personal listings. Implemented pagination on the `Home()` screen to optimize performance for large datasets.
6. Focused on testing, identifying gaps in the app, and implementing a responsive UI for web support. Prioritized bypassing CORS issues while refining core functionalities and enhancing the overall user experience.

By following this implementation plan, the Recipe App will leverage Firebase Firestore to provide a scalable, real-time, and secure database solution while ensuring an optimal user experience.

### Custom Widget: Flutter Rating Bar

#### Selection Criteria

The criteria used to choose the rating widget for this application include:

- **Customizability**: The ability to customize the appearance and behavior of the rating widget.
- **Ease of integration**: Compatibility with the Flutter framework and ease of integration.
- **User experience**: Providing a smooth and intuitive user experience for rating recipes.
- **Real-time updates**: Support for real-time updates to reflect changes in ratings immediately.

#### Customization

The `flutter_rating_bar` widget was chosen for its extensive customization options and ease of integration. Here is how it was customized for the Recipe App:

1. **Initial Setup**:
   - Added the `flutter_rating_bar` dependency to the `pubspec.yaml` file.
   - Imported the `flutter_rating_bar` package in the necessary files.

2. **Customization**:
   - **Item Size**: Set the size of each rating item to 20.0.
   - **Allow Half Rating**: Enabled half rating support to allow users to rate recipes with half stars.
   - **Initial Rating**: Set the initial rating based on the average rating of the recipe.
   - **Custom Icons**: Used custom icons for full, half, and empty ratings to match the app's design.
   - **Real-time Updates**: Integrated the rating widget with the app's state management solution to handle rating updates and reflect changes in real-time.

3. **Integration**:
   - Integrated the rating widget into the `RecipeCard` and `RecipeDetails` widgets to allow users to rate recipes directly from these screens.
   - Implemented functions to update the recipe's rating in Firestore whenever a user rates a recipe.

4. **Testing and Optimization**:
   - Tested the rating widget on different devices to ensure a smooth user experience.
   - Optimized the performance of the rating widget to ensure it works seamlessly on lower-end devices.

By customizing the `flutter_rating_bar` widget, the Recipe App provides a user-friendly and visually appealing rating system that enhances the overall user experience.
