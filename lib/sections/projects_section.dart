import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers.dart';
import '../core/constants.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/premium_card.dart';
import '../screens/project_details_screen.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        "title": "Social Media App",
        "desc": "Feature-rich social networking platform with real-time feed, stories, and chat functionality.",
        "tech": "Flutter, Firebase, Cloud Functions",
        "img": "https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=400&auto=format&fit=crop",
      },
      {
        "title": "Loyalty App",
        "desc": "Customer retention platform with point tracking, rewards redemption, and QR code scanning.",
        "tech": "Flutter, Node.js, GraphQL",
        "img": "https://images.unsplash.com/photo-1628102491629-778571d893a3?q=80&w=400&auto=format&fit=crop",
      },
      {
        "title": "Dream Interpretation",
        "desc": "AI-powered journal that analyzes dreams and provides psychological insights using NLP.",
        "tech": "Flutter, OpenAI API, SQLite",
        "img": "https://images.unsplash.com/photo-1517960413843-0aee8e2b3285?q=80&w=400&auto=format&fit=crop",
      },
      {
        "title": "Meeting Scheduler",
        "desc": "Productivity tool for optimizing team schedules with calendar sync and automated reminders.",
        "tech": "Flutter, Google Calendar API, Provider",
        "img": "https://images.unsplash.com/photo-1506784983877-45594efa4cbe?q=80&w=400&auto=format&fit=crop",
      },
      {
        "title": "Farm Management",
        "desc": "Complete IoT solution for monitoring and managing farm livestock and crops.",
        "tech": "Flutter, Firebase, IoT",
        "img": "https://images.unsplash.com/photo-1595113316349-9fa4ee24f884?q=80&w=400&auto=format&fit=crop",
      },
      {
        "title": "POS System",
        "desc": "Multi-platform retail management system with real-time inventory and sales tracking.",
        "tech": "Flutter, Node.js, MongoDB",
        "img": "https://images.unsplash.com/photo-1556742044-3c52d6e88c62?q=80&w=400&auto=format&fit=crop",
      },
    ];

    return SectionWrapper(
      title: "My Projects",
      subtitle: "SELECTED WORK",
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 380,
          mainAxisSpacing: AppSpacing.xl,
          crossAxisSpacing: AppSpacing.xl,
          childAspectRatio: 0.8,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final p = projects[index];
          return _ProjectCard(
            title: p["title"]!,
            description: p["desc"]!,
            techStack: p["tech"]!,
            imageUrl: p["img"]!,
          ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1, end: 0);
        },
      ),
    );
  }
}

class _ProjectCard extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final String techStack;
  final String imageUrl;

  const _ProjectCard({
    required this.title, 
    required this.description, 
    required this.techStack,
    required this.imageUrl,
  });

  @override
  ConsumerState<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsScreen(
                project: {
                  'title': widget.title,
                  'desc': widget.description,
                  'tech': widget.techStack,
                  'img': widget.imageUrl,
                },
              ),
            ),
          );
        },
        child: AnimatedScale(
        scale: isHovered ? 1.02 : 1.0,
        duration: 250.ms,
        curve: Curves.easeOut,
        child: PremiumCard(
          padding: EdgeInsets.zero,
          isHovered: isHovered,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: AnimatedContainer(
                    duration: 250.ms,
                    color: isHovered ? Colors.black.withOpacity(0.1) : Colors.black.withOpacity(0.4),
                    child: Center(
                      child: AnimatedOpacity(
                        duration: 250.ms,
                        opacity: isHovered ? 1.0 : 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
                            ],
                          ),
                          child: const Icon(FontAwesomeIcons.arrowUpRightFromSquare, color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: isDark ? AppColors.textMainDark : AppColors.textMainLight),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      widget.description,
                      style: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight, fontSize: 13, height: 1.5),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.techStack.split(', ').map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(t, style: TextStyle(color: isDark ? AppColors.textMainDark : AppColors.textMainLight, fontSize: 11, fontWeight: FontWeight.w600)),
                      )).toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        _SmallButton(icon: FontAwesomeIcons.globe, label: "Live", isDark: isDark, onTap: () {}),
                        const SizedBox(width: AppSpacing.md),
                        _SmallButton(icon: FontAwesomeIcons.github, label: "Repo", isDark: isDark, onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _SmallButton({required this.icon, required this.label, required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            FaIcon(icon, size: 12, color: isDark ? AppColors.textMainDark : AppColors.textMainLight),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? AppColors.textMainDark : AppColors.textMainLight)),
          ],
        ),
      ),
    );
  }
}
