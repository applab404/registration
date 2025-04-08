import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool success = true,
    Duration duration = const Duration(seconds: 2),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    double elevation = 1,
    double borderRadius = 12.0,
    Color? backgroundColor,
    Color? foregroundColor,
    IconData? icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bgColor =
        backgroundColor ?? (success ? colorScheme.primary : colorScheme.error);
    final fgColor = foregroundColor ?? colorScheme.onPrimary;
    final iconData = icon ?? (success ? Icons.check_circle : Icons.error);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: _buildContent(message, iconData, fgColor, textTheme),
      backgroundColor: bgColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: margin,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _buildContent(
    String message,
    IconData icon,
    Color iconColor,
    TextTheme textTheme,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: iconColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
