import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_completion_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Custom Top Bar with Back Button and Verified Icon
              _buildTopBar(context),
              const SizedBox(height: 40),
              
              // Logo Header (Microscope)
              _buildMicroscopeLogo(),
              const SizedBox(height: 32),
              
              // Title & Subtitle
              _buildTitleSection(),
              const SizedBox(height: 48),
              
              // Sign Up Form
              _buildSignUpForm(),
              const SizedBox(height: 40),
              
              // Create Account Button
              _buildCreateButton(context),
              const SizedBox(height: 32),
              
              // Footer link to Login
              _buildFooter(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
        ),
        Text(
          'Create Account',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF005D63),
          ),
        ),
        const Icon(Icons.verified_user_rounded, color: Color(0xFF005D63)),
      ],
    );
  }

  Widget _buildMicroscopeLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF48C6EF).withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.biotech_rounded,
          size: 50,
          color: Color(0xFF005D63),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF111827),
            ),
            children: [
              const TextSpan(text: 'Join '),
              TextSpan(
                text: 'Pep Tracker',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF008B94),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Begin your biological optimization\njourney',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        _buildInputField('FULL NAME', 'John Doe'),
        const SizedBox(height: 24),
        _buildInputField('EMAIL ADDRESS', 'name@aetherlabs.com'),
        const SizedBox(height: 24),
        _buildInputField('PASSWORD', '••••••••', isPassword: true),
        const SizedBox(height: 24),
        _buildInputField('CONFIRM PASSWORD', '••••••••', isPassword: true),
      ],
    );
  }

  Widget _buildInputField(String label, String placeholder, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF374151),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFF3F4F6),
              width: 1,
            ),
          ),
          child: TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: GoogleFonts.montserrat(
                color: const Color(0xFFD1D5DB),
                fontSize: 15,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF008B94),
            Color(0xFF48C6EF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF48C6EF).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfileCompletionView()),
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CREATE ACCOUNT',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF6B7280),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            'Log In',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF008B94),
            ),
          ),
        ),
      ],
    );
  }
}
