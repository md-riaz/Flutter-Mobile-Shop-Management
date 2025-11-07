# Application Architecture

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Mobile Shop Management                    │
│                      Flutter + GetX Application                  │
└─────────────────────────────────────────────────────────────────┘
                                │
                ┌───────────────┴───────────────┐
                │                               │
        ┌───────▼────────┐              ┌──────▼──────┐
        │  Presentation  │              │   Business  │
        │     Layer      │◄────────────►│    Logic    │
        │   (Views)      │              │ (Controllers)│
        └───────┬────────┘              └──────┬──────┘
                │                              │
                │                              │
        ┌───────▼────────────────────────┬─────▼──────┐
        │                                │            │
    ┌───▼───┐  ┌────────┐  ┌────────┐  │  ┌────────┐ │
    │ Theme │  │ Routes │  │Widgets │  │  │ Models │ │
    └───────┘  └────────┘  └────────┘  │  └────────┘ │
                                        │             │
                                        │ ┌──────────┐│
                                        │ │Providers ││
                                        │ │(Future)  ││
                                        │ └──────────┘│
                                        └─────────────┘
                                              │
                                    ┌─────────▼─────────┐
                                    │   Data Sources    │
                                    │  (Future: API)    │
                                    └───────────────────┘
```

## GetX Architecture Pattern

```
┌──────────────────────────────────────────────────────────────┐
│                         User Interface                        │
│  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐│
│  │Dashbrd │  │Product │  │Category│  │ Sales  │  │Inventry││
│  │ View   │  │ View   │  │ View   │  │ View   │  │ View   ││
│  └────┬───┘  └───┬────┘  └───┬────┘  └───┬────┘  └───┬────┘│
└───────┼──────────┼───────────┼───────────┼───────────┼──────┘
        │          │           │           │           │
        └──────────┴───────────┴───────────┴───────────┘
                              │
                    ┌─────────▼──────────┐
                    │   GetX Navigation  │
                    │    & Routing       │
                    └─────────┬──────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
    ┌───▼────┐         ┌──────▼────┐         ┌─────▼────┐
    │Dashboard│        │  Products │         │  Sales   │
    │Controller│        │ Controller│         │Controller│
    └───┬────┘         └──────┬────┘         └─────┬────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                    ┌─────────▼──────────┐
                    │ GetX Dependency    │
                    │    Injection       │
                    │    (Bindings)      │
                    └─────────┬──────────┘
                              │
                    ┌─────────▼──────────┐
                    │   Data Models      │
                    │  Product, Sale,    │
                    │    Category        │
                    └────────────────────┘
```

## Module Structure (GetX Pattern)

```
Module/
├── controller.dart          # Business logic & state
│   ├── Observable variables (.obs)
│   ├── Business methods
│   ├── API calls (future)
│   └── State management
│
├── binding.dart            # Dependency injection
│   └── Lazy load controller
│
└── view.dart              # UI presentation
    ├── Extends GetView<Controller>
    ├── Obx() widgets for reactivity
    ├── UI components
    └── User interactions
```

## Data Flow Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      User Interaction                        │
│                    (Tap, Type, Swipe)                       │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    View Layer (Widget)                       │
│  • Renders UI                                               │
│  • Listens to state changes                                │
│  • Captures user input                                     │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ Calls method
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               Controller (Business Logic)                    │
│  • Processes input                                          │
│  • Updates observable state                                │
│  • Makes calculations                                      │
│  • (Future) Calls API                                     │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ Updates
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              Observable State Variables                      │
│  • totalProducts.obs                                        │
│  • products.obs                                            │
│  • isLoading.obs                                           │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ Notifies
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  Obx() / GetX() Widget                      │
│  • Listens to changes                                       │
│  • Rebuilds only affected widgets                          │
│  • Efficient updates                                       │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ Renders
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                     Updated UI                               │
│                 (User sees changes)                         │
└─────────────────────────────────────────────────────────────┘
```

## Responsive Layout Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                    MediaQuery.size.width                      │
└───────────────────────┬──────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
    < 650px      650px - 1100px     > 1100px
        │               │               │
    ┌───▼───┐      ┌────▼────┐     ┌────▼─────┐
    │Mobile │      │ Tablet  │     │ Desktop  │
    │Layout │      │ Layout  │     │  Layout  │
    └───┬───┘      └────┬────┘     └────┬─────┘
        │               │               │
        │               │               │
  ┌─────▼─────┐   ┌─────▼─────┐  ┌─────▼──────┐
  │• Drawer   │   │• Drawer/  │  │• Sidebar   │
  │  Nav      │   │  Sidebar  │  │  Always    │
  │• 1 Column │   │• 2 Columns│  │• 3-4 Column│
  │• FAB      │   │• Enhanced │  │• Spacious  │
  │• Stack    │   │  Spacing  │  │  Layout    │
  └───────────┘   └───────────┘  └────────────┘
```

## Navigation Architecture

```
                    ┌──────────────┐
                    │  main.dart   │
                    │ GetMaterialApp│
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │  AppRoutes   │
                    │  Constants   │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │  AppPages    │
                    │  GetPage[]   │
                    └──────┬───────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
    ┌───▼────┐      ┌──────▼────┐      ┌─────▼────┐
    │ Route  │      │  Binding  │      │   View   │
    │  Path  │─────►│ Injection │─────►│  Widget  │
    └────────┘      └───────────┘      └──────────┘
```

## State Management Flow (GetX)

```
Controller Creation & Binding:
──────────────────────────────
  Route Navigation
        │
        ▼
  Binding.dependencies()
        │
        ▼
  Get.lazyPut<Controller>(() => Controller())
        │
        ▼
  Controller Instance Created (when needed)
        │
        ▼
  Controller.onInit() called
        │
        ▼
  Data Loading / Initialization


Reactive State Updates:
───────────────────────
  User Action / Data Change
        │
        ▼
  controller.someVariable.value = newValue
        │
        ▼
  GetX Stream Notifies Listeners
        │
        ▼
  Obx(() => ...) Widgets Rebuild
        │
        ▼
  UI Updates Automatically


Controller Disposal:
────────────────────
  Navigate Away / Route Change
        │
        ▼
  Controller.onClose() called
        │
        ▼
  Resources Cleaned Up
        │
        ▼
  Controller Disposed (if not permanent)
```

## Theme Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        AppTheme                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
   ┌────▼─────┐                 ┌─────▼────┐
   │  Light   │                 │   Dark   │
   │  Theme   │                 │  Theme   │
   └────┬─────┘                 └─────┬────┘
        │                             │
        └──────────────┬──────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
   ┌────▼─────┐                 ┌─────▼────┐
   │ Colors   │                 │Typography│
   │ Palette  │                 │  System  │
   └──────────┘                 └──────────┘
```

## Project Folder Structure

```
lib/
├── main.dart                          # Entry point
│
├── app/
│   ├── data/
│   │   ├── models/
│   │   │   ├── product.dart          # Product model
│   │   │   ├── category.dart         # Category model
│   │   │   └── sale.dart             # Sale model
│   │   └── providers/                # Future: API providers
│   │
│   ├── modules/                      # Feature modules
│   │   ├── dashboard/
│   │   │   ├── dashboard_controller.dart
│   │   │   ├── dashboard_binding.dart
│   │   │   └── dashboard_view.dart
│   │   ├── products/
│   │   │   ├── products_controller.dart
│   │   │   ├── products_binding.dart
│   │   │   ├── products_view.dart
│   │   │   ├── add_product_view.dart
│   │   │   └── product_detail_view.dart
│   │   ├── categories/
│   │   ├── sales/
│   │   └── inventory/
│   │
│   ├── routes/
│   │   ├── app_routes.dart           # Route constants
│   │   └── app_pages.dart            # GetPages config
│   │
│   ├── theme/
│   │   └── app_theme.dart            # Theme configuration
│   │
│   └── utils/
│       ├── responsive.dart           # Responsive utilities
│       ├── constants.dart            # App constants
│       └── validators.dart           # Form validators
│
└── widgets/
    └── app_drawer.dart               # Navigation drawer
```

## Component Hierarchy

```
MaterialApp (GetMaterialApp)
    │
    └── Scaffold
        ├── AppBar
        │   ├── Title
        │   ├── Actions (Theme toggle, etc.)
        │   └── Leading (Menu button on mobile)
        │
        ├── Drawer (Mobile) / Sidebar (Desktop)
        │   ├── DrawerHeader
        │   └── Navigation Items
        │       ├── Dashboard
        │       ├── Products
        │       ├── Categories
        │       ├── Sales
        │       └── Inventory
        │
        └── Body
            └── Row (Desktop) / Column (Mobile)
                ├── Sidebar (Desktop only)
                └── Content Area
                    └── Module View
                        ├── Controller (GetX)
                        ├── State (Observable)
                        └── UI Widgets
```

## Technology Stack

```
┌─────────────────────────────────────────────────────────────┐
│                      Technology Stack                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Framework:              Flutter 3.x                        │
│  Language:               Dart 3.x                           │
│  State Management:       GetX 4.6.6                         │
│  Routing:                GetX Navigation                     │
│  Dependency Injection:   GetX Bindings                      │
│  Typography:             Google Fonts (Inter)               │
│  Icons:                  Font Awesome Flutter               │
│  Charts:                 FL Chart                           │
│  Formatting:             Intl                               │
│  Storage (Future):       Shared Preferences                 │
│  Design:                 Material 3                         │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Summary

This architecture provides:
- ✅ **Separation of Concerns**: Views, Controllers, Models clearly separated
- ✅ **Scalability**: Easy to add new modules following the pattern
- ✅ **Maintainability**: Clean, organized code structure
- ✅ **Testability**: Controllers can be tested independently
- ✅ **Performance**: Efficient reactive updates with GetX
- ✅ **Responsive**: Adapts to any screen size
- ✅ **Modern**: Follows Flutter and GetX best practices
