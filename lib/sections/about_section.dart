import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/premium_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionWrapper(
      title: "About Me",
      subtitle: "WHO AM I?",
      child: isMobile 
        ? Column(children: _buildContent(context, isDark))
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildImage(isDark)),
              const SizedBox(width: AppSpacing.xxl * 2),
              Expanded(flex: 2, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(context, isDark),
              )),
            ],
          ),
    );
  }

  Widget _buildImage(bool isDark) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      child: Container(
        height: 480, // Reduced height on mobile to prevent scrolling fatigue/overflow
        constraints: const BoxConstraints(maxHeight: 500),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage("assets/images/profile.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  List<Widget> _buildContent(BuildContext context, bool isDark) {
    return [
      Text(
        "Passionate Flutter Developer based in Bangladesh",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.05, end: 0),
      const SizedBox(height: AppSpacing.lg),
      Text(
        "I am a results-oriented Mobile App Developer with a deep love for creating elegant, functional, and user-centric applications. With expertise in Flutter and Dart, I transform complex ideas into high-quality mobile experiences.",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
        ),
      ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: 0.05, end: 0),
      const SizedBox(height: AppSpacing.md),
      Text(
        "My journey started with a curiosity for how apps work, which evolved into a professional career building robust solutions for clients worldwide. I believe in clean code, scalable architecture, and constant learning.",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
        ),
      ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideX(begin: 0.05, end: 0),
      const SizedBox(height: AppSpacing.xl),
      _buildKeyStrengths(isDark).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.05, end: 0),
    ];
  }

  Widget _buildKeyStrengths(bool isDark) {
    final strengths = [
      "User-Centric Design",
      "Robust Architecture",
      "Scalable Solutions",
      "Performance Optimization"
    ];

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: strengths.map((s) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check, size: 16, color: AppColors.accent),
            const SizedBox(width: 8),
            Text(
              s, 
              style: TextStyle(
                color: isDark ? AppColors.textMainDark : AppColors.textMainLight, 
                fontWeight: FontWeight.w600,
                fontSize: 14,
              )
            ),
          ],
        ),
      )).toList(),
    );
  }
}
