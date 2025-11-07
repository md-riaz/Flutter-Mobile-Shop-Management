# Quick Start Guide

Get up and running with the Mobile Shop Management app in minutes!

## 📋 Prerequisites

Before you begin, ensure you have:

- ✅ Flutter SDK 3.0+ installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- ✅ Dart SDK 3.0+ (comes with Flutter)
- ✅ An IDE: Android Studio, VS Code, or IntelliJ IDEA
- ✅ A device/emulator for testing:
  - Android device or Android emulator
  - iOS device or iOS simulator (macOS only)
  - Chrome browser (for web)

## 🚀 Installation Steps

### 1. Verify Flutter Installation

```bash
flutter doctor
```

Make sure all checks pass. If not, follow the instructions provided by Flutter doctor.

### 2. Clone the Repository

```bash
git clone https://github.com/md-riaz/Flutter-Mobile-Shop-Management.git
cd Flutter-Mobile-Shop-Management
```

### 3. Install Dependencies

```bash
flutter pub get
```

This will download all the required packages including GetX, Google Fonts, etc.

### 4. Run the App

#### For Android/iOS:
```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>
```

#### For Web:
```bash
flutter run -d chrome
```

#### For Desktop:
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 🎯 What You'll See

### On First Launch:

1. **Dashboard Screen**: 
   - Statistics cards showing product counts, sales, low stock, and categories
   - Recent sales list
   - Top products showcase

2. **Navigation**:
   - Mobile: Hamburger menu (top-left) to access drawer
   - Desktop/Tablet: Persistent sidebar with navigation items

### Try These Features:

#### 1. Browse Products
- Tap "Products" from navigation
- See product grid (desktop) or list (mobile)
- Try the search bar at the top
- Filter by category using the chips

#### 2. Add a Product
- Click the "+" button (floating or in AppBar)
- Fill in the form:
  - Name: e.g., "iPhone 14 Pro"
  - Description: e.g., "Latest Apple smartphone"
  - Price: e.g., "999.99"
  - Stock: e.g., "50"
  - Category: Select from dropdown
- Click "Add Product"
- See your product appear in the list

#### 3. View Categories
- Navigate to "Categories"
- See all product categories
- Notice the product count for each

#### 4. Check Sales
- Go to "Sales"
- View the total revenue card
- Browse through sales transactions
- See customer names, dates, and amounts

#### 5. Monitor Inventory
- Navigate to "Inventory"
- Check the low stock alert (if any)
- View the complete inventory table
- See color-coded stock status

#### 6. Toggle Theme
- Click the sun/moon icon in the AppBar
- Watch the app switch between light and dark mode
- Notice how all colors adapt automatically

## 📱 Testing Responsive Design

### Desktop View (> 1100px)
- Open in Chrome: `flutter run -d chrome`
- Resize browser to full width
- See persistent sidebar
- Notice 4-column product grid
- Observe spacious layouts

### Tablet View (650px - 1100px)
- Resize browser to ~900px width
- See 2-column grid
- Navigation adjusts

### Mobile View (< 650px)
- Resize browser to ~400px width
- Or run on mobile device/emulator
- See drawer navigation
- Single column layout
- Floating action button appears

## 🎨 Exploring the Code

### Key Files to Check:

#### 1. Main Entry Point
```
lib/main.dart
```
- App configuration
- GetX setup
- Theme initialization

#### 2. Dashboard Module
```
lib/app/modules/dashboard/
  ├── dashboard_controller.dart   # Business logic
  ├── dashboard_binding.dart      # Dependency injection
  └── dashboard_view.dart         # UI
```

#### 3. Responsive Utilities
```
lib/app/utils/responsive.dart
```
- Learn how responsive breakpoints work
- See helper methods for screen sizes

#### 4. Theme Configuration
```
lib/app/theme/app_theme.dart
```
- Light and dark theme definitions
- Color palette
- Typography system

#### 5. Navigation Setup
```
lib/app/routes/
  ├── app_routes.dart    # Route constants
  └── app_pages.dart     # Route configuration
```

## 🛠️ Development Tips

### Hot Reload
While the app is running:
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

### VS Code
- Use the Flutter extension
- F5 to start debugging
- Hot reload on save (enable in settings)

### Android Studio
- Use Flutter plugin
- Green play button to run
- Hot reload button in toolbar

## 🔍 Troubleshooting

### Issue: Dependencies not downloading
```bash
flutter clean
flutter pub get
```

### Issue: Build errors
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Web not working
Enable web support:
```bash
flutter config --enable-web
flutter create .
flutter run -d chrome
```

### Issue: Can't see devices
```bash
flutter devices

# For Android
flutter emulators
flutter emulators --launch <emulator_id>

# For iOS (macOS)
open -a Simulator
```

## 📚 Next Steps

1. **Customize the App**:
   - Change colors in `app_theme.dart`
   - Modify product categories
   - Add your own data

2. **Add Backend**:
   - Set up REST API
   - Integrate with providers
   - Add authentication

3. **Enhance Features**:
   - Add image uploads
   - Implement real analytics
   - Create reports

4. **Deploy**:
   - Build for production
   - Publish to stores
   - Deploy web version

## 💡 Learning Resources

- **GetX Documentation**: https://pub.dev/packages/get
- **Flutter Documentation**: https://flutter.dev/docs
- **Material Design**: https://m3.material.io

## 🤝 Need Help?

- Check the [README.md](README.md) for detailed information
- Review [DOCUMENTATION.md](DOCUMENTATION.md) for technical details
- See [FEATURES.md](FEATURES.md) for feature explanations
- Study [ARCHITECTURE.md](ARCHITECTURE.md) for system design

## ✨ Have Fun!

You're now ready to explore and customize the Mobile Shop Management app. Happy coding! 🚀

---

**Pro Tip**: Start by making small changes to the theme or adding a new product, then gradually explore more complex features like creating new modules or modifying controllers.
