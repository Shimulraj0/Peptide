import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../auth/profile_setup_screen.dart';
import 'providers/auth_provider.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Start the resend timer using Riverpod
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(verificationProvider.notifier).startResendTimer();
    });
  }

  Future<void> _resendCode() async {
    final timer = ref.read(verificationProvider).resendTimer;
    if (timer > 0) return;
    
    // Simulate resend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code resent!', style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFF0058BC),
        behavior: SnackBarBehavior.floating,
      ),
    );
    ref.read(verificationProvider.notifier).startResendTimer();
  }

  Future<void> _verifyOtp() async {
    if (pinController.text.length < 6) return;

    final success = await ref.read(verificationProvider.notifier).verifyOtp(pinController.text);

    if (success && mounted) {
      // Navigate to Profile Setup with a smooth transition
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ProfileSetupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.05, 0.0); // Subtle slide from right
            const end = Offset.zero;
            const curve = Curves.easeOutQuart;

            final offsetAnimation = animation.drive(
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve)),
            );
            
            final fadeAnimation = animation.drive(
              CurveTween(curve: Curves.easeIn),
            );

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verState = ref.watch(verificationProvider);
    const focusedBorderColor = Color(0xFF0058BC);
    const fillColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: GoogleFonts.manrope(
        fontSize: 24,
        color: const Color(0xFF1A1C1F),
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 20,
            offset: Offset(0, 8),
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Header
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    // Title
                    Text(
                      'Verification',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF1A1C1F),
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.90,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Subtitle
                    Text(
                      'Enter the 6-digit code sent to your\nemail.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF414755),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.63,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Pinput Row
                    Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) => _verifyOtp(),
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: focusedBorderColor, width: 2),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: const Color(0xFFF3F3F8),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Protection Card
                    _buildProtectionCard(),
                    const SizedBox(height: 48),
                    // Verify Button
                    _buildVerifyButton(verState),
                    const SizedBox(height: 32),
                    // Footer Links
                    _buildFooter(verState),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            // Secure Session Badge
            _buildSecureBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildProtectionCard() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(44),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140058BC),
            blurRadius: 50,
            offset: Offset(0, 20),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/clinical_protection_illustration.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF1A1C1F).withValues(alpha: 0.8),
                      const Color(0xFF1A1C1F).withValues(alpha: 0.2),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_outlined, color: Colors.white70, size: 32),
                    const SizedBox(height: 12),
                    Text(
                      'Your data is protected by clinical-grade encryption.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyButton(VerificationState verState) {
    return Container(
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BC).withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: verState.isLoading ? null : _verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        ),
        child: verState.isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Verify',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildFooter(VerificationState verState) {
    return Column(
      children: [
        Text(
          "Didn't receive a code?",
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: verState.resendTimer == 0 ? _resendCode : null,
          child: Text(
            verState.resendTimer > 0 ? 'Resend in ${verState.resendTimer}s' : 'Resend',
            style: GoogleFonts.manrope(
              color: verState.resendTimer > 0 ? const Color(0xFFC1C6D7) : const Color(0xFF0058BC),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecureBadge() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0x19C1C6D7)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A1A1C1F),
                blurRadius: 40,
                offset: Offset(0, 12),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF0058BC)),
              const SizedBox(width: 8),
              Text(
                'SECURE SESSION',
                style: GoogleFonts.inter(
                  color: const Color(0xFF414755),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
