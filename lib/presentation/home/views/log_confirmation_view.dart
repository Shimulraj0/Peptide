import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

class LogConfirmationView extends ConsumerStatefulWidget {
  final String peptide;
  final String amount;
  final String time;
  final String area;

  const LogConfirmationView({
    super.key,
    required this.peptide,
    required this.amount,
    required this.time,
    required this.area,
  });

  @override
  ConsumerState<LogConfirmationView> createState() => _LogConfirmationViewState();
}

class _LogConfirmationViewState extends ConsumerState<LogConfirmationView> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _breathController;

  late Animation<double> _checkmarkScale;
  late Animation<double> _checkmarkFade;
  late Animation<double> _headerSlide;
  late Animation<double> _headerFade;
  late Animation<double> _cardSlide;
  late Animation<double> _cardFade;
  late Animation<double> _buttonSlide;
  late Animation<double> _buttonFade;
  late Animation<double> _breathPulse;

  @override
  void initState() {
    super.initState();
    
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Bouncy Checkmark entry
    _checkmarkScale = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );
    _checkmarkFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    // Staggered Title & Subtitle
    _headerSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _headerFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
    );

    // Staggered Summary Card
    _cardSlide = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _cardFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
    );

    // Action Buttons
    _buttonSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _buttonFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
    );

    // "Breathing" Background Pulse
    _breathPulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _breathController,
        curve: Curves.easeInOutSine,
      ),
    );

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: Stack(
        children: [
          // Background "Breathing" Glow
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: ScaleTransition(
              scale: _breathPulse,
              child: FadeTransition(
                opacity: _breathPulse,
                child: Container(
                  width: 390,
                  height: 390,
                  decoration: const ShapeDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0.5, 0.5),
                      radius: 0.5,
                      colors: [Color(0x1E0070EB), Color(0x000070EB)],
                    ),
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                
                // 1. Success Icon Entry
                ScaleTransition(
                  scale: _checkmarkScale,
                  child: FadeTransition(
                    opacity: _checkmarkFade,
                    child: _buildSuccessIcon(),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 2. Title & Subtitle Staggered
                AnimatedBuilder(
                  animation: _headerSlide,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _headerSlide.value),
                    child: FadeTransition(
                      opacity: _headerFade,
                      child: _buildHeaderText(),
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),

                // 3. Summary Card Staggered
                AnimatedBuilder(
                  animation: _cardSlide,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _cardSlide.value),
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: _buildSummaryCard(),
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // 4. Action Buttons Staggered
                AnimatedBuilder(
                  animation: _buttonSlide,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _buttonSlide.value),
                    child: FadeTransition(
                      opacity: _buttonFade,
                      child: _buildActionButtons(context, ref),
                    ),
                  ),
                ),
                
                const SizedBox(height: 64),
              ],
            ),
          ),
          
          // Header Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 104,
      height: 104,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, -12),
          )
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.check_circle,
          color: Color(0xFF0058BC),
          size: 56,
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      children: [
        Text(
          'Entry Logged Successfully',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.33,
            letterSpacing: -0.60,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your daily health record has been updated.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(navigationProvider.notifier).state = 0;
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.close, color: Color(0xFF1A1C1F), size: 24),
            ),
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 48), // Balance the icon space
                  child: Text(
                    'Confirmation',
                    style: TextStyle(
                      color: Color(0xFF1A1C1F),
                      fontSize: 20,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0x26C1C6D7),
          ),
          borderRadius: BorderRadius.circular(48),
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
        children: [
          _buildSummaryGrid(),
          const SizedBox(height: 32),
          _buildSecurityNotice(),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSummaryItem('PEPTIDE', widget.peptide)),
            Expanded(child: _buildSummaryItem('AMOUNT', widget.amount)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildSummaryItem('TIME', widget.time)),
            Expanded(child: _buildSummaryItem('AREA', widget.area)),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.50,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.56,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F3F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Row(
        spacing: 12,
        children: [
          const Icon(Icons.verified_user_outlined, color: Color(0xFF0058BC), size: 20),
          Expanded(
            child: Text(
              'Logged securely to your personal history and synchronized with personal log.',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.63,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildPrimaryButton(
            'Back to Dashboard',
            () {
              ref.read(navigationProvider.notifier).state = 0;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          const SizedBox(height: 16),
          _buildSecondaryButton(
            'Log Another Entry',
            () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.20, -0.95),
          end: Alignment(0.80, 1.95),
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x330058BC),
            blurRadius: 15,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9999),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.50,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9999),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: const Color(0xFF0058BC),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
