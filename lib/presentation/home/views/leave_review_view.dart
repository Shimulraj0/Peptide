import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveReviewView extends StatefulWidget {
  const LeaveReviewView({super.key});

  @override
  State<LeaveReviewView> createState() => _LeaveReviewViewState();
}

class _LeaveReviewViewState extends State<LeaveReviewView> {
  int _rating = 4;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildBannerCard(),
                    const SizedBox(height: 32),
                    _buildIntroText(),
                    const SizedBox(height: 32),
                    _buildRatingCard(),
                    const SizedBox(height: 32),
                    _buildFeedbackSection(),
                    const SizedBox(height: 48),
                    _buildActionButtons(),
                    const SizedBox(height: 80),
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
            'Leave a Review',
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

  Widget _buildBannerCard() {
    return Container(
      width: double.infinity,
      height: 192,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.asset(
            'assets/Clean clinical environment.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0058BC).withValues(alpha: 0.1),
                  const Color(0xFF0070EB).withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      children: [
        Text(
          'Your Experience Matters',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.20,
            letterSpacing: -0.75,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Help us refine your personalized peptide\njourney.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'OVERALL SATISFACTION',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.20,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isSelected = index < _rating;
              return _AnimatedPressButton(
                onPressed: () => setState(() => _rating = index + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0x330058BC),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isSelected
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: const Color(0xFF0058BC),
                      size: 40,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            '${_rating.toDouble()} / 5.0',
            style: GoogleFonts.inter(
              color: const Color(0xFF0058BC),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Feedback',
            style: GoogleFonts.manrope(
              color: const Color(0xFF1A1C1F),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: ShapeDecoration(
            color: const Color(0xFFE8E8ED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: TextField(
            controller: _feedbackController,
            maxLines: 4,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1C1F),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText:
                  'Share your thoughts on tracker accuracy, clinical insights, or delivery...',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF717786),
                fontSize: 14,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildSubmitButton(),
        const SizedBox(height: 24),
        _AnimatedPressButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Not Now',
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return _AnimatedPressButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you for your review!',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: const Color(0xFF0058BC),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x330058BC),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Submit Review',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
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

class _AnimatedPressButtonState extends State<_AnimatedPressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
