# E-Commerce App

## Description
The E-Commerce App is a simple yet powerful product listing application built with Flutter. It allows users to browse through a catalog of products, view detailed information about each product, and add items to their shopping cart. The app includes user authentication to secure user data and interactions. Cart data is saved on Firebase for persistence. The app also supports both light and dark themes, providing a flexible and user-friendly experience.

## Features
- **User Authentication**: Secure login and registration features using Firebase Authentication.
- **Product Listing**: Displays a list of products fetched from a remote API.
- **Product Search**: Search functionality to filter products based on user queries.
- **Product Details**: View detailed information about each product, including images, descriptions, and prices.
- **Shopping Cart**: Add products to the shopping cart, view cart items, and proceed to checkout.
- **Firebase Storage**: Save and retrieve cart data using Firebase.
- **Dark and Light Themes**: Toggle between dark and light themes for a personalized user experience.
- **Responsive Design**: Adjusts layout and elements based on screen size for optimal viewing on different devices.

## Requirements
- Flutter SDK
- Firebase account

## Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd e_commerce_app
   ```

2. Install the dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Follow the Firebase setup instructions to add Firebase to your Flutter app.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate directories.

4. Run the app:
   ```bash
   flutter run
   ```

## Directory Structure
```
e_commerce_app/
│
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── lib/
│   ├── models/              # Data models
│   ├── screens/             # App screens
│   ├── services/            # Business logic and Firebase interaction
│   ├── utils/               # Utility functions and constants
│   ├── widgets/             # Reusable widgets
│   ├── main.dart            # App entry point
│   └── theme_provider.dart  # Theme management
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Project dependencies
├── README.md                # Project documentation
└── firebase_options.dart    # Firebase configuration
```

## Screens and Navigation

- **LoginScreen**: Allows users to log in using their credentials.
- **RegistrationScreen**: Allows new users to create an account.
- **HomeScreen**: Displays a list of products with a search bar and cart button.
- **ProductDetailScreen**: Shows detailed information about a selected product.
- **CartScreen**: Displays items added to the cart and allows proceeding to checkout.

### HomeScreen
The `HomeScreen` serves as the main hub of the application, where users can browse and search for products. It also includes a switch to toggle between light and dark themes.

### ProductDetailScreen
The `ProductDetailScreen` provides detailed information about a product when a user selects it from the list. Users can add the product to their cart from this screen.

### CartScreen
The `CartScreen` allows users to view the items they have added to their cart. Users can proceed to checkout from here.

## Theme Management
The app includes both light and dark themes. Users can switch between these themes using a toggle switch located in the app bar on the HomeScreen. The theme preference is managed using the `ThemeProvider` class, which is a ChangeNotifier that maintains the current theme state and notifies listeners of changes.

## Services
- **CartService**: Manages the shopping cart, including adding and removing items and loading cart data from Firebase.
- **ProductService**: Handles fetching product data from the API and managing product search queries.
- **ThemeProvider**: Manages theme switching between light and dark modes.

## Firebase Integration
The app uses Firebase for user authentication and Firestore for storing cart data. The Firebase setup is handled in `firebase_options.dart` and requires proper configuration for both Android and iOS platforms.

## Conclusion
The E-Commerce App is a robust Flutter application designed to provide a seamless shopping experience. With features like user authentication, product browsing, detailed product views, a shopping cart, and theme switching, it offers a comprehensive solution for e-commerce needs. The responsive design ensures that the app works well on various device sizes, providing an optimal user experience.