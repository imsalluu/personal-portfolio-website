import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border(top: BorderSide(color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               _SocialLink(
                 icon: FontAwesomeIcons.github, 
                 isDark: isDark,
                 onTap: () => _launchUrl("https://github.com/imsalluu"),
               ),
               _SocialLink(
                 icon: FontAwesomeIcons.linkedinIn, 
                 isDark: isDark,
                 onTap: () => _launchUrl("https://www.linkedin.com/in/im-salluu/"),
               ),
               _SocialLink(
                 icon: FontAwesomeIcons.instagram, 
                 isDark: isDark,
                 onTap: () => _launchUrl("https://www.instagram.com/im_salluuu"),
               ),
               _SocialLink(
                 icon: FontAwesomeIcons.facebookF, 
                 isDark: isDark,
                 onTap: () => _launchUrl("https://www.facebook.com/imsalluuu"),
               ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            "© 2026 Salman Hossain. All rights reserved.",
            style: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Built with ", style: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight, fontSize: 12)),
              const Icon(Icons.favorite, color: Colors.red, size: 12),
              Text(" using Flutter", style: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _SocialLink({
    required this.icon, 
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        icon: FaIcon(icon, size: 18, color: isDark ? AppColors.textMainDark : AppColors.textMainLight),
        onPressed: onTap,
        hoverColor: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.04),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
