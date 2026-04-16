import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroSection(),
                    const SizedBox(height: 48),
                    _buildMedicalDisclaimerCard(),
                    const SizedBox(height: 32),
                    _buildAccountabilityCards(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          _AnimatedPressButton(
            onPressed: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            ),
          ),
          const SizedBox(width: 80),
          Text(
            'Terms of Service',
            style: GoogleFonts.manrope(
              color: const Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: ShapeDecoration(
            color: const Color(0x190058BC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          child: Text(
            'LEGAL DOCUMENTATION',
            style: GoogleFonts.manrope(
              color: const Color(0xFF0058BC),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Clinical Use\nAgreement',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.11,
            letterSpacing: -0.90,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please review these terms carefully before utilizing the luxury peptide tracking interface. By accessing the Medical Concierge platform, you agree to these clinical parameters.',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.63,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalDisclaimerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: const Color(0x0C0058BC),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0x190058BC),
          ),
          borderRadius: BorderRadius.circular(48),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_hospital_outlined, color: Color(0xFF0058BC), size: 24),
              const SizedBox(width: 12),
              Text(
                'Medical Disclaimer',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF0058BC),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.63,
              ),
              children: const [
                TextSpan(text: 'The data provided through this peptide tracker is for '),
                TextSpan(
                  text: 'informational purposes only',
                  style: TextStyle(
                    color: Color(0xFF1A1C1F),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: '. It does not constitute medical advice, diagnosis, or treatment.\n\nAlways seek the advice of your physician or other qualified health provider with any questions regarding a medical condition or therapeutic peptide protocol. Never disregard professional medical advice because of something you have tracked in this application.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountabilityCards() {
    return Column(
      children: [
        _buildDetailCard(
          icon: Icons.security_outlined,
          title: 'Account Responsibilities',
          description: 'Users are responsible for maintaining the confidentiality of their biometric access and protocol logs. Any unauthorized use of high-tier clinical data must be reported immediately to the Concierge Support team.',
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.biotech_outlined,
          title: 'Data Accuracy',
          description: 'Precision is paramount. While we strive for absolute accuracy in kinetic calculations, user-input errors may occur. Logged titration levels should be cross-verified with physical prescriptions.',
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          icon: Icons.copyright_outlined,
          title: 'Intellectual Property',
          description: 'The Medical Concierge interface, including its proprietary peptide tracking algorithms, visual design, and clinical serenity aesthetic, are protected by international intellectual property laws. Reproduction of the tracking logic or UI layout is strictly prohibited without written luxury tier consent.',
        ),
      ],
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1A1C1F), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF1A1C1F),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedPressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _AnimatedPressButton({required this.child, required this.onPressed});

  @override
  State<_AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<_AnimatedPressButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
