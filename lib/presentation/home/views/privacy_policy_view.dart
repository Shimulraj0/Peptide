import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
                    _buildIntroCard(),
                    const SizedBox(height: 48),
                    _buildNarrativeSection(),
                    const SizedBox(height: 64),
                    _buildSectionHeader('1', 'Data Collection'),
                    const SizedBox(height: 24),
                    _buildModernCard(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      description: 'When you register, we collect identifiers such as your name, email address, and date of birth to create a secure medical profile.',
                    ),
                    const SizedBox(height: 16),
                    _buildModernCard(
                      icon: Icons.monitor_heart_outlined,
                      title: 'Health Vitals',
                      description: 'With your explicit consent, we sync heart rate, sleep cycles, and metabolic data from wearable devices to populate your dashboard.',
                    ),
                    const SizedBox(height: 64),
                    _buildSectionHeader('2', 'Data Usage'),
                    const SizedBox(height: 24),
                    _buildUsageSection(),
                    const SizedBox(height: 64),
                    _buildSectionHeader('3', 'Security'),
                    const SizedBox(height: 24),
                    _buildSecurityFeaturedCard(),
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
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          ),
          const SizedBox(width: 80),
          Text(
            'Privacy Policy',
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

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F3F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: ShapeDecoration(
                    color: const Color(0x190058BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: Text(
                    'LEGAL TRANSPARENCY',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0058BC),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Your health\ndata is\n',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'encrypted',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF0058BC),
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' and\nsecure.',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'We believe privacy is a fundamental human right, especially when it comes to your medical journey.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF414755),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 240), // Space for image
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            right: -20,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x190070EB),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: Container(
              height: 200,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/security_encryption_graphic.png'),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrativeSection() {
    return Text(
      'This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make use of our Clinical Serenity platform. We follow rigorous international medical data standards to ensure your Vitals and Protocols remain confidential.',
      style: GoogleFonts.inter(
        color: const Color(0xFF414755),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
    );
  }

  Widget _buildSectionHeader(String number, String title) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: ShapeDecoration(
            color: const Color(0xFFE8E8ED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: const Color(0xFF0058BC),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.manrope(
                color: const Color(0xFF1A1C1F),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.60,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 48,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0x330070EB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModernCard({required IconData icon, required String title, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x19C1C6D7)),
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF0058BC), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF1A1C1F),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 2,
          height: 180,
          decoration: ShapeDecoration(
            color: const Color(0xFFE2E2E7),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We use the collected data strictly for clinical analysis and personalization of your health journey. This includes:',
                style: GoogleFonts.inter(
                  color: const Color(0xFF414755),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              _buildBulletItem('Generating predictive health insights and trends.'),
              const SizedBox(height: 16),
              _buildBulletItem('Customizing your medical protocols and exercise recommendations.'),
              const SizedBox(height: 16),
              _buildBulletItem('Facilitating secure communication with your healthcare providers.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline, color: Color(0xFF0058BC), size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1C1F),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityFeaturedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: const Color(0x0C0058BC),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 4, color: Color(0xFF0058BC)),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We implement industry-standard AES-256 encryption for all data at rest and TLS 1.3 for data in transit.',
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1C1F),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Access to sensitive medical data is restricted to authorized personnel only, utilizing multi-factor authentication (MFA) and continuous audit logs. We conduct quarterly security audits and penetration testing to ensure your sanctuary remains impenetrable.',
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
