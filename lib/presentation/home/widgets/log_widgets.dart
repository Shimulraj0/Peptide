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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          ),
          const SizedBox(width: 8),
          Text(
            'Log History',
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.w600,
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
          children: [
            Text(
              date,
              style: GoogleFonts.manrope(
                color: const Color(0xFF1A1C1F),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0x7FE2E2E7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Stack(
            children: [
              if (!isLast)
                Positioned(
                  left: 11,
                  top: 16,
                  bottom: -24,
                  child: Opacity(
                    opacity: 0.50,
                    child: Container(
                      width: 1.5,
                      color: const Color(0xFFE2E2E7),
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
  final bool hasLineBelow;

  const LogTimelineCard({
    super.key,
    required this.peptide,
    required this.location,
    required this.dosage,
    required this.time,
    this.isCompleted = true,
    this.dotColor = const Color(0xFF0058BC),
    this.iconBgColor = const Color(0x190058BC),
    this.hasLineBelow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The vertical line for this item
        if (hasLineBelow)
          Positioned(
            left: -21,
            top: 36,
            bottom: -12,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 1.5,
                color: const Color(0xFFE2E2E7),
              ),
            ),
          ),
        
        // The Dot
        Positioned(
          left: -26.5,
          top: 24,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 4,
                )
              ],
            ),
          ),
        ),
        
        // The Card
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0x19C1C6D7)),
            boxShadow: const [
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
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isCompleted ? Icons.check_circle_outline : Icons.pending_outlined,
                        color: dotColor.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peptide,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                children: [
                  Text(
                    dosage,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF414755),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
