import 'package:intl/intl.dart';

class AppConstants {
  // App Info
  static const String appName = 'Mobile Shop Management';
  static const String appVersion = '1.0.0';

  // API Configuration (for future use)
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Pagination
  static const int itemsPerPage = 20;
  static const int gridCrossAxisCount = 4;

  // Stock Levels
  static const int lowStockThreshold = 20;
  static const int criticalStockThreshold = 5;

  // Date Formats
  static final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final DateFormat timeFormat = DateFormat('HH:mm');

  // Number Formats
  static final NumberFormat currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );
  static final NumberFormat numberFormat = NumberFormat('#,##0');

  // Validation
  static const int minProductNameLength = 3;
  static const int maxProductNameLength = 100;
  static const double minPrice = 0.01;
  static const double maxPrice = 999999.99;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}
