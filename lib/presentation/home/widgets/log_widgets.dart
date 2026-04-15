import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogHeader extends StatelessWidget {
  final VoidCallback onBack;

  const LogHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.70),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          ),
          const SizedBox(width: 16),
          Text(
            'Log History',
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.40,
              letterSpacing: -0.50,
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineSection extends StatelessWidget {
  final String date;
  final List<Widget> children;
  final bool isLast;

  const TimelineSection({
    super.key,
    required this.date,
    required this.children,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date,
              style: GoogleFonts.manrope(
                color: const Color(0xFF1A1C1F),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.56,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1,
                decoration: const BoxDecoration(color: Color(0x7FE2E2E7)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (!isLast)
                Positioned(
                  left: 11,
                  top: 16,
                  bottom: -32,
                  child: Opacity(
                    opacity: 0.50,
                    child: Container(
                      width: 1.50,
                      decoration: const BoxDecoration(color: Color(0xFFE2E2E7)),
                    ),
                  ),
                ),
              Column(
                children: children,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LogTimelineCard extends StatelessWidget {
  final String peptide;
  final String location;
  final String dosage;
  final String time;
  final bool isCompleted;
  final Color dotColor;
  final Color iconBgColor;
  final IconData? icon;

  const LogTimelineCard({
    super.key,
    required this.peptide,
    required this.location,
    required this.dosage,
    required this.time,
    this.isCompleted = true,
    this.dotColor = const Color(0xFF0058BC),
    this.iconBgColor = const Color(0x190058BC),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The Card
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0x19C1C6D7)),
              borderRadius: BorderRadius.circular(32),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x051A1C1F),
                blurRadius: 20,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: iconBgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon ?? (isCompleted ? Icons.check_circle_outline : Icons.pending_outlined),
                        color: dotColor.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        peptide,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF414755)),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF414755),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dosage,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  Text(
                    time,
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
          ),
        ),
        
        // The Timeline Dot
        Positioned(
          left: -27,
          top: 24,
          child: Container(
            width: 12,
            height: 12,
            decoration: ShapeDecoration(
              color: dotColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: Container(
              width: 12,
              height: 12,
              decoration: ShapeDecoration(
                color: Colors.white.withValues(alpha: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 0,
                    offset: Offset(0, 0),
                    spreadRadius: 4,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
