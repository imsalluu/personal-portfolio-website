import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';
import '../widgets/section_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/premium_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch \$url');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      try {
        await FirebaseFirestore.instance.collection('contacts').add({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'message': _messageController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          setState(() => _isSubmitting = false);
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          
          // Show success dialog
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => _SuccessDialog(),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isSubmitting = false);
          
          // Show error dialog
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => _ErrorDialog(error: e.toString()),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SectionWrapper(
      title: "Contact Me",
      subtitle: "GET IN TOUCH",
      child: isMobile 
        ? Column(children: _buildContent(context, isDark))
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildInfo(context, isDark)),
              const SizedBox(width: AppSpacing.xxl),
              Expanded(flex: 2, child: _buildForm(context, isDark)),
            ],
          ),
    );
  }

  List<Widget> _buildContent(BuildContext context, bool isDark) {
    return [
      _buildInfo(context, isDark),
      const SizedBox(height: AppSpacing.xxl),
      _buildForm(context, isDark),
    ];
  }

  Widget _buildInfo(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's talk about your project", 
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            fontWeight: FontWeight.w700,
          )
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _ContactInfoItem(icon: Icons.email_outlined, label: "Email", value: "flutterdev.salman@gmail.com", isDark: isDark),
        _ContactInfoItem(icon: Icons.phone_outlined, label: "Phone", value: "01703362601", isDark: isDark),
        _ContactInfoItem(icon: Icons.location_on_outlined, label: "Location", value: "Bangladesh", isDark: isDark),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.linkedinIn, 
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              onTap: () => _launchUrl("https://www.linkedin.com/in/im-salluu/"),
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.github, 
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              onTap: () => _launchUrl("https://github.com/imsalluu"),
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.facebookF, 
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              onTap: () => _launchUrl("https://www.facebook.com/imsalluuu"),
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.instagram, 
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              onTap: () => _launchUrl("https://www.instagram.com/im_salluuu"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, bool isDark) {
    return PremiumCard(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField("Name", Icons.person_outline, isDark, controller: _nameController),
            const SizedBox(height: AppSpacing.md),
            _buildTextField("Email", Icons.email_outlined, isDark, controller: _emailController),
            const SizedBox(height: AppSpacing.md),
            _buildTextField("Message", Icons.message_outlined, isDark, maxLines: 5, controller: _messageController),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Send Message", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.send, size: 16),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isDark, {int maxLines = 1, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? AppColors.textMainDark : AppColors.textMainLight),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your \$label';
        }
        if (label == "Email" && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.accent, size: 20),
        labelStyle: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight),
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _ContactInfoItem({required this.icon, required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.accent, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: isDark ? AppColors.textDimDark : AppColors.textDimLight, fontSize: 12, fontWeight: FontWeight.w500)),
              Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: isDark ? AppColors.textMainDark : AppColors.textMainLight)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon, 
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: IconButton(
        icon: FaIcon(icon, color: color, size: 18),
        onPressed: onTap,
        style: IconButton.styleFrom(
          backgroundColor: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.04),
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// Success Dialog
class _SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.accent,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Message Sent!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Thank you for reaching out! I\'ll get back to you soon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Error Dialog
class _ErrorDialog extends StatelessWidget {
  final String error;
  
  const _ErrorDialog({required this.error});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Something went wrong. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppColors.textDimDark : AppColors.textDimLight,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
