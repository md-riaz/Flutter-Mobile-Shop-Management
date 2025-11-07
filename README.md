# Flutter Mobile Shop Management 📱

A modern, responsive Flutter mobile shop management application built with **GetX** state management, following best practices for both web and mobile platforms.

## ✨ Features

- 🎨 **Modern UI/UX** - Beautiful, clean interface with Material 3 design
- 🌓 **Dark Mode Support** - Full light and dark theme implementation
- 📱 **Fully Responsive** - Optimized layouts for mobile, tablet, and desktop
- ⚡ **GetX State Management** - Efficient reactive state management
- 🏗️ **Clean Architecture** - Well-organized folder structure following GetX patterns
- 📊 **Dashboard Analytics** - Real-time statistics and insights
- 🛍️ **Product Management** - Add, edit, delete, and manage products
- 📦 **Inventory Tracking** - Monitor stock levels and low stock alerts
- 💰 **Sales Management** - Track sales and revenue
- 🏷️ **Category Management** - Organize products by categories
- 🔍 **Search & Filter** - Quick product search and category filtering

## 🏛️ Architecture

This project follows **GetX architecture pattern**:

```
lib/
├── app/
│   ├── data/
│   │   ├── models/          # Data models
│   │   └── providers/       # API providers
│   ├── modules/             # Feature modules
│   │   ├── dashboard/       # Dashboard feature
│   │   ├── products/        # Products feature
│   │   ├── categories/      # Categories feature
│   │   ├── sales/           # Sales feature
│   │   └── inventory/       # Inventory feature
│   ├── routes/              # App routing
│   ├── theme/               # App theming
│   └── utils/               # Utilities & helpers
├── widgets/                 # Reusable widgets
└── main.dart               # App entry point
```

### Module Structure (GetX Pattern)

Each module follows the GetX pattern:
- **View** - UI layer (pages/screens)
- **Controller** - Business logic & state management
- **Binding** - Dependency injection

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Chrome (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/md-riaz/Flutter-Mobile-Shop-Management.git
   cd Flutter-Mobile-Shop-Management
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For mobile:
   ```bash
   flutter run
   ```
   
   For web:
   ```bash
   flutter run -d chrome
   ```
   
   For desktop:
   ```bash
   flutter run -d windows
   # or
   flutter run -d macos
   # or
   flutter run -d linux
   ```

## 🌐 Deployment

### Deploy to GitHub Pages

This project includes a GitHub Actions workflow for deploying the Flutter web app to GitHub Pages.

**Steps to deploy:**

1. **Enable GitHub Pages**
   - Go to repository Settings → Pages
   - Under "Build and deployment", select "Source: GitHub Actions"

2. **Run the deployment workflow**
   - Go to the "Actions" tab in your GitHub repository
   - Select "Deploy Flutter Web to GitHub Pages" workflow
   - Click "Run workflow" button
   - Select the branch and click "Run workflow"

3. **Access your deployed app**
   - After successful deployment, your app will be available at:
   - `https://<your-username>.github.io/<your-repository-name>/`
   - For this repository: `https://md-riaz.github.io/Flutter-Mobile-Shop-Management/`

The workflow will:
- Build the Flutter web app in release mode
- Upload the build artifacts
- Deploy to GitHub Pages

## 📦 Dependencies

- **get** (^4.6.6) - State management, routing, and dependency injection
- **google_fonts** (^6.1.0) - Beautiful fonts
- **flutter_svg** (^2.0.9) - SVG support
- **font_awesome_flutter** (^10.6.0) - Icon library
- **intl** (^0.19.0) - Internationalization and formatting
- **shared_preferences** (^2.2.2) - Local storage
- **fl_chart** (^0.65.0) - Charts and graphs

## 🎨 Theming

The app includes a comprehensive theming system with:
- Custom color palette
- Light and dark mode support
- Consistent typography using Google Fonts (Inter)
- Material 3 design principles

## 📱 Responsive Design

The app is fully responsive and adapts to different screen sizes:
- **Mobile** (< 650px): Optimized mobile layout with drawer navigation
- **Tablet** (650px - 1100px): Enhanced layout with more columns
- **Desktop** (> 1100px): Full desktop experience with sidebar navigation

## 🔧 GetX Best Practices

This project demonstrates GetX best practices:

1. **Reactive State Management**
   - Using `.obs` for observable variables
   - `Obx()` widgets for reactive UI updates

2. **Dependency Injection**
   - Lazy loading controllers with `Get.lazyPut()`
   - Proper binding classes for each module

3. **Routing**
   - Named routes with `GetPage`
   - Route parameters and navigation

4. **Clean Code**
   - Separation of concerns
   - Single responsibility principle
   - Reusable widgets and utilities

## 🌟 Key Features Implementation

### Dashboard
- Real-time statistics cards
- Recent sales list
- Top products overview
- Responsive grid layout

### Products Management
- Product listing with grid/list view
- Search functionality
- Category filtering
- Add/Edit/Delete operations
- Stock level indicators

### Categories
- Category overview cards
- Product count per category
- Responsive grid layout

### Sales
- Sales transaction list
- Revenue tracking
- Date-based filtering
- Customer information

### Inventory
- Stock level monitoring
- Low stock alerts
- Data table view
- Restock functionality

## 🔮 Future Enhancements

- [ ] Backend integration (REST API)
- [ ] Authentication & authorization
- [ ] Real-time updates with WebSocket
- [ ] Advanced analytics & reporting
- [ ] Export data (PDF, Excel)
- [ ] Multi-language support
- [ ] Image upload for products
- [ ] Barcode scanning
- [ ] Invoice generation
- [ ] Customer management

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**MD Riaz**

- GitHub: [@md-riaz](https://github.com/md-riaz)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX community for the excellent state management solution
- Material Design team for design guidelines

---

Made with ❤️ using Flutter & GetX