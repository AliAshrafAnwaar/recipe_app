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

- **Users**: Stores user information such as userID, username, email, phoneNumber, bio, image, recipes (Set of recipe IDs), and favourites (Set of recipe IDs).
- **Recipes**: Stores recipe information such as recipeID, title, description, userID, imageLink, date, ratings (List of doubles), likes (Set of user IDs), comments (List of maps with userID and comment text), and favourites (Set of user IDs).

#### Integration

1. **Setup Firebase**: Initialize Firebase in the Flutter app by adding the necessary dependencies and configuring Firebase in the `main.dart` file.
2. **Authentication**: Implement Firebase Authentication to manage user sign-up, sign-in, and sign-out functionalities.
3. **Firestore Integration**: Use the Firestore plugin to interact with the Firestore database. Implement functions to add, update, retrieve, and delete data from the Firestore collections.
4. **Real-time Updates**: Leverage Firestore's real-time capabilities to synchronize data across the app in real-time.
5. **Security Rules**: Define Firestore security rules to protect user data and ensure only authorized access.
6. **Offline Support**: Enable Firestore's offline support to allow the app to function without an internet connection.

By following this implementation plan, the Recipe App will effectively utilize Firebase Firestore to provide a scalable, real-time, and secure database solution.