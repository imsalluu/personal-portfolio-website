import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/premium_card.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final education = [
      {
        "degree": "Diploma in Computer Science & Engineering",
        "institution": "Feni Polytechnic Institute",
        "period": "2022 - 2025",
        "desc": "Focused on software engineering, data structures, algorithms, and mobile application development.",
        "icon": Icons.school_rounded,
      },
      {
        "degree": "Higher Secondary Certificate",
        "institution": "Chhagalnaiya Government Pilot High School",
        "period": "2016 - 2021",
        "desc": "Achieved primary excellence in mathematics and physics.",
        "icon": Icons.history_edu_rounded,
      },
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionWrapper(
      title: "Academic Path",
      subtitle: "EDUCATION",
      child: Column(
        children: List.generate(education.length, (index) {
          final edu = education[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: PremiumCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(edu["icon"] as IconData, color: AppColors.accent, size: 28),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                edu["degree"] as String,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                edu["period"] as String,
                                style: const TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          edu["institution"] as String,
                          style: TextStyle(
                            color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          edu["desc"] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.05, end: 0),
          );
        }),
      ),
    );
  }
}
