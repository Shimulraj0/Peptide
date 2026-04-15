import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PeptideDetailsScreen extends StatelessWidget {
  final String peptideName;
  final String status;
  final String remaining;
  final String validUntil;

  const PeptideDetailsScreen({
    super.key,
    required this.peptideName,
    required this.status,
    required this.remaining,
    required this.validUntil,
  });

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
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroCard(),
                    const SizedBox(height: 24),
                    _buildStatusCard(),
                    const SizedBox(height: 40),
                    _buildUsageHistorySection(),
                    const SizedBox(height: 48),
                    _buildDeleteButton(context),
                    const SizedBox(height: 24),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x33E2E8F0),
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1C1F)),
          ),
          const SizedBox(width: 8),
          Text(
            '$peptideName Detail',
            style: GoogleFonts.manrope(
              color: const Color(0xFF1A1C1F),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        borderRadius: BorderRadius.circular(48),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BC).withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 192,
                height: 192,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AMOUNT REMAINING',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.80),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    remaining.split(' ')[0],
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2.40,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    remaining.split(' ')[1],
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.90),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.science_outlined, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '1,250 mcg total',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: const Icon(Icons.inventory_2_rounded, size: 80, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
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
                decoration: const BoxDecoration(
                  color: Color(0xFFE8E8ED),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_month_outlined, color: Color(0xFF414755), size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valid Until',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF414755),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    validUntil,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              status.toUpperCase(),
              style: GoogleFonts.inter(
                color: const Color(0xFF16A34A),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usage History',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.50,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A1A1C1F),
                blurRadius: 40,
                offset: Offset(0, 12),
              )
            ],
          ),
          child: Column(
            children: [
              _buildHistoryTile('Today • 08:30 AM', '250 mcg', isFirst: true),
              _buildHistoryTile('Yesterday • 08:45 AM', '250 mcg'),
              _buildHistoryTile('Oct 24 • 09:00 AM', '250 mcg', isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTile(String dateTime, String dosage, {bool isFirst = false, bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFE8E8ED))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.medical_services_outlined, color: Color(0xFF0058BC), size: 18),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log administered',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    dateTime,
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
          Text(
            dosage,
            style: GoogleFonts.manrope(
              color: const Color(0xFF0058BC),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showDeleteConfirmation(context);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0x0CBA1A1A),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0x19BA1A1A)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.delete_outline_rounded, color: Color(0xFFBA1A1A), size: 18),
              const SizedBox(width: 8),
              Text(
                'Delete Peptide',
                style: GoogleFonts.manrope(
                  color: const Color(0xFFBA1A1A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete $peptideName?', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        content: Text('This action cannot be undone. All clinical tracking and history will be lost.', style: GoogleFonts.inter()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter(color: const Color(0xFF414755))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close details screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$peptideName deleted')),
              );
            },
            child: Text('Delete', style: GoogleFonts.inter(color: const Color(0xFFBA1A1A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
