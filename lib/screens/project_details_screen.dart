import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';
import '../widgets/premium_card.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Map<String, String> project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgStart : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkBgStart : Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    project['img']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          isDark ? AppColors.darkBgStart : Colors.white,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Tags
                  Text(
                    project['title']!,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['tech']!).split(', ').map((t) => 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.borderDark : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t, 
                          style: TextStyle(
                            color: isDark ? AppColors.textMainDark : AppColors.textMainLight, 
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ).toList(),
                  ).animate().fadeIn(delay: 100.ms),
                  
                  const SizedBox(height: 40),

                  // Main Content Layout
                  if (isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDescription(isDark),
                        const SizedBox(height: 32),
                        _buildFeatures(isDark),
                        const SizedBox(height: 32),
                        _buildSidebar(isDark),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDescription(isDark),
                              const SizedBox(height: 40),
                              _buildFeatures(isDark),
                            ],
                          ),
                        ),
                        const SizedBox(width: 60),
                        Expanded(
                          flex: 1,
                          child: _buildSidebar(isDark),
                        ),
                      ],
                    ),
                    
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Project Overview",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project['desc']!,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Features",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          ),
        ),
        const SizedBox(height: 20),
        _FeatureList(isDark: isDark),
      ],
    );
  }

  Widget _buildSidebar(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project Status", 
                style: TextStyle(
                  color: isDark ? AppColors.textDimDark : AppColors.textDimLight, 
                  fontSize: 13,
                  fontWeight: FontWeight.w600
                )
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 20),
                  const SizedBox(width: 8),
                  Text("Completed", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: isDark ? AppColors.textMainDark : AppColors.textMainLight)),
                ],
              ),
              const SizedBox(height: 24),
              _LinkButton(
                label: "View Live Demo",
                icon: FontAwesomeIcons.globe,
                color: AppColors.accent,
                isDark: isDark,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _LinkButton(
                label: "Source Code",
                icon: FontAwesomeIcons.github,
                color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                isDark: isDark,
                outline: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  final bool isDark;
  const _FeatureList({required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Mock features for now, ideally passed from data
    final features = [
      "Responsive UI Design",
      "Real-time Data Sync",
      "Secure Authentication",
      "Cloud Integration",
    ];

    return Column(
      children: features.map((f) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            const Icon(Icons.check, color: AppColors.accent, size: 18),
            const SizedBox(width: 12),
            Text(
              f,
              style: TextStyle(
                color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool outline;
  final bool isDark;
  final VoidCallback onTap;

  const _LinkButton({
    required this.label, 
    required this.icon, 
    required this.color, 
    this.outline = false,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: outline ? Colors.transparent : color,
          border: outline ? Border.all(color: isDark ? AppColors.borderDark : Colors.black.withValues(alpha: 0.1), width: 1) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: outline ? color : Colors.white, size: 16),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: outline ? color : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
