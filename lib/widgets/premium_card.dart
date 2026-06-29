import 'package:flutter/material.dart';
import '../core/constants.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  final double? width;
  final double? height;
  final Color? color;
  final bool isHovered;

  const PremiumCard({
    super.key,
    required this.child,
    this.borderRadius = 12.0, // Sharper corners for a premium feel
    this.padding,
    this.border,
    this.width,
    this.height,
    this.color,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color ?? (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ?? Border.all(
          color: isHovered 
            ? (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2))
            : (isDark ? AppColors.borderDark : Colors.black.withOpacity(0.05)),
          width: 1.0,
        ),
        boxShadow: isHovered ? [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.black).withOpacity(isDark ? 0.4 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ] : [],
      ),
      child: child,
    );
  }
}
