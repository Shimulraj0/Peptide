import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'verification_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Peptide Tracker',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF0F172A),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Welcome Text
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.11,
                          letterSpacing: -0.90,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Start tracking your protocol with medical-\ngrade precision.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Registration Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: const Color(0x26C1C6D7)),
                    boxShadow: const [
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
                      // Full Name Field
                      Text(
                        'FULL NAME',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.60,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          hintStyle: GoogleFonts.inter(color: const Color(0xFFC1C6D7)),
                          filled: true,
                          fillColor: const Color(0xFFE8E8ED),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Email Field
                      Text(
                        'EMAIL ADDRESS',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.60,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'name@example.com',
                          hintStyle: GoogleFonts.inter(color: const Color(0xFFC1C6D7)),
                          filled: true,
                          fillColor: const Color(0xFFE8E8ED),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Password Field
                      Text(
                        'CREATE PASSWORD',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.60,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: GoogleFonts.inter(color: const Color(0xFFC1C6D7)),
                          filled: true,
                          fillColor: const Color(0xFFE8E8ED),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          suffixIcon: const Icon(Icons.visibility_outlined, color: Color(0xFF717786)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Create Account Button
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0058BC).withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VerificationScreen()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Separator
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0xFFE2E2E7))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR SIGN UP WITH',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF717786),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0xFFE2E2E7))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Social Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _SocialButton(
                              imagePath: 'assets/google.png',
                              label: 'Google',
                              onPressed: () {},
                              backgroundColor: const Color(0xFFF3F3F8),
                              textColor: const Color(0xFF1A1C1F),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _SocialButton(
                              icon: Icons.apple,
                              label: 'Apple',
                              onPressed: () {},
                              backgroundColor: const Color(0xFF1A1C1F),
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Already have an account?
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        ),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0058BC),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Legal Footer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text.rich(
                    TextSpan(
                      text: "By proceeding, you agree to PeptidePro's ",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF717786),
                        fontSize: 11,
                        height: 1.6,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF414755),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF414755),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ', including cookie use.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const _SocialButton({
    this.icon,
    this.imagePath,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x26C1C6D7)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, width: 24, height: 24)
            else if (icon != null)
              Icon(icon!, color: textColor, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
