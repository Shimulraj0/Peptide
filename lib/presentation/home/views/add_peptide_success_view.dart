import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

class AddPeptideSuccessView extends ConsumerStatefulWidget {
  final String peptideName;
  final String amount;
  final String amountUnit;
  final String unitType;
  final String expirationDate;

  const AddPeptideSuccessView({
    super.key,
    required this.peptideName,
    required this.amount,
    required this.amountUnit,
    required this.unitType,
    required this.expirationDate,
  });

  @override
  ConsumerState<AddPeptideSuccessView> createState() => _AddPeptideSuccessViewState();
}

class _AddPeptideSuccessViewState extends ConsumerState<AddPeptideSuccessView> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _breathController;

  late Animation<double> _iconScale;
  late Animation<double> _iconFade;
  late Animation<double> _titleSlide;
  late Animation<double> _titleFade;
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

    // Elastic Icon entry
    _iconScale = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );
    _iconFade = CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    // Staggered Title
    _titleSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _titleFade = CurvedAnimation(
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

    // Staggered Action Buttons
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

    // "Breathing" Glow Pulse
    _breathPulse = Tween<double>(begin: 0.7, end: 1.0).animate(
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

          // Side decorative circle
          Positioned(
            right: -100,
            top: -50,
            child: Container(
              width: 384,
              height: 384,
              decoration: const ShapeDecoration(
                color: Color(0x0C0058BC),
                shape: CircleBorder(),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  
                  // 1. Success Icon
                  ScaleTransition(
                    scale: _iconScale,
                    child: FadeTransition(
                      opacity: _iconFade,
                      child: _buildSuccessIcon(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 2. Headings
                  AnimatedBuilder(
                    animation: _titleSlide,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: FadeTransition(
                        opacity: _titleFade,
                        child: _buildHeadings(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // 3. Summary Card
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

                  // 4. Action Buttons
                  AnimatedBuilder(
                    animation: _buttonSlide,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, _buttonSlide.value),
                      child: FadeTransition(
                        opacity: _buttonFade,
                        child: _buildActionButtons(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),

          // Header (Close button)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              ref.read(navigationProvider.notifier).state = 2; // Inventory
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.close, color: Color(0xFF1A1C1F)),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 144,
          height: 144,
          decoration: const ShapeDecoration(
            color: Color(0x190058BC),
            shape: CircleBorder(),
          ),
        ),
        Container(
          width: 96,
          height: 96,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
            ),
            shape: const CircleBorder(),
            shadows: const [
              BoxShadow(
                color: Color(0x3F0058BC),
                blurRadius: 40,
                offset: Offset(0, 12),
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white, size: 48),
          ),
        ),
      ],
    );
  }

  Widget _buildHeadings() {
    return Column(
      children: [
        Text(
          'Peptide Added\nSuccessfully',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.75,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your inventory records have been\nupdated.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.63,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, -12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryItem('PEPTIDE NAME', widget.peptideName, isLarge: true),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAmountItem('INITIAL AMOUNT', widget.amount, widget.amountUnit)),
              Expanded(child: _buildSummaryItem('UNIT TYPE', widget.unitType)),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(height: 1, color: Color(0x4CE2E2E7)),
          const SizedBox(height: 16),
          _buildExpirationItem(),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, {bool isLarge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.5,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: isLarge ? 20 : 18,
            fontWeight: isLarge ? FontWeight.w700 : FontWeight.w600,
            height: 1.4,
            letterSpacing: isLarge ? -0.5 : 0,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountItem(String label, String amount, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1.5,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              amount,
              style: GoogleFonts.manrope(
                color: const Color(0xFF1A1C1F),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.33,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpirationItem() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const ShapeDecoration(
            color: Color(0xFFE8E8ED),
            shape: CircleBorder(),
          ),
          child: const Icon(Icons.calendar_today_outlined, color: Color(0xFF414755), size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EXPIRATION DATE',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                height: 1.5,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              widget.expirationDate,
              style: GoogleFonts.inter(
                color: const Color(0xFF1A1C1F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildPrimaryButton(
          'View Inventory',
          () {
            ref.read(navigationProvider.notifier).state = 2; // Inventory tab
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        const SizedBox(height: 16),
        _buildSecondaryButton(
          'Add Another',
          () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 60,
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
            color: Color(0x260058BC),
            blurRadius: 24,
            offset: Offset(0, 8),
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
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.43,
                letterSpacing: 0.35,
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
      height: 52,
      decoration: ShapeDecoration(
        color: const Color(0xFFE8E8ED),
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
                color: const Color(0xFF414755),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.43,
                letterSpacing: 0.35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
