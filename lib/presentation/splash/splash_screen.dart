import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'widgets/dna_helix_painter.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _progressController;
  late AnimationController _pulseController;
  AnimationController? _helixController;

  late Animation<double> _iconFade;
  late Animation<double> _iconSlide;
  late Animation<double> _titleFade;
  late Animation<double> _titleSlide;
  late Animation<double> _subtitleFade;
  late Animation<double> _bottomFade;
  late Animation<double> _pulseAnim;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();

    // ── Continuous DNA Twist ──
    _helixController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // ── Pulse glow on icon ──
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _pulseAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // ── Staggered fade + slide entrance ──
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _iconFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _iconSlide = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<double>(begin: 15.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.45, 0.7, curve: Curves.easeOut),
      ),
    );

    _bottomFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.6, 0.9, curve: Curves.easeOut),
      ),
    );

    // ── Progress bar ──
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _progressAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });

    // Force rebuild on every animation tick
    _fadeController.addListener(_rebuild);
    _pulseController.addListener(_rebuild);
    _progressController.addListener(_rebuild);
    _helixController?.addListener(_rebuild);

    // Start entrance
    _fadeController.forward();

    // Start progress after entrance is partly visible
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _progressController.forward();
    });
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _fadeController.removeListener(_rebuild);
    _pulseController.removeListener(_rebuild);
    _progressController.removeListener(_rebuild);
    _helixController?.removeListener(_rebuild);
    _fadeController.dispose();
    _progressController.dispose();
    _pulseController.dispose();
    _helixController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEDF1F5), Color(0xFFF7F8FA), Color(0xFFF5F7FA)],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 38),

              // DNA icon — fade + slide up
              Opacity(
                opacity: _iconFade.value,
                child: Transform.translate(
                  offset: Offset(0, _iconSlide.value),
                  child: _buildDnaIcon(),
                ),
              ),

              const SizedBox(height: 36),

              // Title — fade + slide up
              Opacity(
                opacity: _titleFade.value,
                child: Transform.translate(
                  offset: Offset(0, _titleSlide.value),
                  child: _buildTitle(),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle — fade
              Opacity(
                opacity: _subtitleFade.value,
                child: Text(
                  'PERSONAL PRECISION',
                  style: AppTextStyles.splashSubtitle,
                ),
              ),

              const Spacer(flex: 42),

              // Bottom — fade
              Opacity(opacity: _bottomFade.value, child: _buildBottomSection()),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDnaIcon() {
    final pulse = _pulseAnim.value;
    return SizedBox(
      width: 130,
      height: 130,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulsing outer glow
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A73E8).withValues(alpha: 0.15 * pulse),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            // White circle
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A73E8).withValues(alpha: 0.1),
                    blurRadius: 25,
                    spreadRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            // DNA icon
            SizedBox(
              width: 28,
              height: 38,
              child: CustomPaint(
                painter: DnaHelixPainter(
                  animationProgress: _helixController?.value ?? 0.0,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('Peptide ', style: AppTextStyles.splashTitle()),
        Text('Tracker', style: AppTextStyles.splashTitleBold()),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 110),
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: AppColors.grey200,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _progressAnim.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5),
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryLight, AppColors.primary],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.verified_rounded,
              size: 15,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              'SECURE BIOMETRIC LINK',
              style: AppTextStyles.splashBiometricLabel,
            ),
          ],
        ),
      ],
    );
  }
}
