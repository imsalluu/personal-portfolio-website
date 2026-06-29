import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../widgets/section_wrapper.dart';
import '../core/navigation.dart';
import '../core/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nav = ref.read(navigationProvider);

    return SectionWrapper(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                            .scale(duration: 1.seconds, begin: const Offset(1, 1), end: const Offset(1.5, 1.5))
                            .fadeOut(),
                          const SizedBox(width: 8),
                          const Text(
                            "Available for Hire",
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600, 
                              fontSize: 12
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      "Hi, I'm Salman Hossain",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 40 : 72, 
                        color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      "Flutter Developer & Mobile Architect",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: isMobile ? 20 : 28,
                        color: AppColors.accent,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      "I craft high-performance, beautiful mobile applications that provide seamless user experiences across iOS and Android. Specialized in building scalable, real-world solutions.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: AppSpacing.xxl),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _CTAButton(
                          text: "Hire Me",
                          isPrimary: true,
                          onPressed: () => nav.scrollToSection('Contact'),
                        ),
                        _CTAButton(
                          text: "Download CV",
                          isPrimary: false,
                          icon: FontAwesomeIcons.download,
                          onPressed: () => _launchUrl("https://example.com/cv.pdf"), // Placeholder for now
                        ),
                      ],
                    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: AppSpacing.xl),
                    _HeroSocialLinks(isDark: isDark).animate().fadeIn(duration: 800.ms, delay: 1000.ms),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: AppSpacing.xxl),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      width: 360,
                      height: 440,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.1, end: 0),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _HeroSocialLinks extends StatelessWidget {
  final bool isDark;
  const _HeroSocialLinks({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github, 
          isDark: isDark,
          onTap: () => _launchUrl("https://github.com/imsalluu"),
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedinIn, 
          isDark: isDark,
          onTap: () => _launchUrl("https://www.linkedin.com/in/im-salluu/"),
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.instagram, 
          isDark: isDark,
          onTap: () => _launchUrl("https://www.instagram.com/im_salluuu"),
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.facebookF, 
          isDark: isDark,
          onTap: () => _launchUrl("https://www.facebook.com/imsalluuu"),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon, 
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isHovered 
                ? (widget.isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05))
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.isDark ? AppColors.borderDark : Colors.black.withOpacity(0.05),
              ),
            ),
            child: FaIcon(
              widget.icon, 
              size: 20, 
              color: isHovered ? AppColors.accent : (widget.isDark ? AppColors.textDimDark : AppColors.textDimLight),
            ),
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;
  final IconData? icon;

  const _CTAButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
    this.icon,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: widget.isPrimary 
              ? AppColors.textMainDark 
              : (isHovered ? (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)) : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isPrimary 
                ? AppColors.textMainDark 
                : (isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1)),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                FaIcon(
                  widget.icon,
                  size: 16,
                  color: widget.isPrimary 
                    ? AppColors.darkBgStart 
                    : (isDark ? AppColors.textMainDark : AppColors.textMainLight),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text, 
                style: TextStyle(
                  fontWeight: FontWeight.w600, 
                  fontSize: 16,
                  color: widget.isPrimary 
                    ? AppColors.darkBgStart 
                    : (isDark ? AppColors.textMainDark : AppColors.textMainLight),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
