import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'core/providers.dart';
import 'core/navigation.dart';
import 'widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/services_section.dart';
import 'sections/reviews_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';
import 'screens/project_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: PortfolioApp()));
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Salman Hossain | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const MainLayout(key: ValueKey('main')),
    );
  }
}

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.read(navigationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgStart : AppColors.lightBgStart,
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               const Navbar(),
               HeroSection(key: nav.sectionKeys['Home']),
               AboutSection(key: nav.sectionKeys['About']),
               ExperienceSection(key: nav.sectionKeys['Experience']),
               EducationSection(key: nav.sectionKeys['Education']),
               SkillsSection(key: nav.sectionKeys['Skills']),
               ServicesSection(key: nav.sectionKeys['Services']),
               ProjectsSection(key: nav.sectionKeys['Projects']),
               ReviewsSection(key: nav.sectionKeys['Reviews']),
               ContactSection(key: nav.sectionKeys['Contact']),
               const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
