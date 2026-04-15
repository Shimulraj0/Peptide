import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add_peptide_screen.dart';
import '../peptide_details_screen.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalAssetsCard(),
                const SizedBox(height: 40),
                _buildLibrarySection(context),
                const SizedBox(height: 32),
                _buildAddButton(context),
                const SizedBox(height: 100), // Spacing for bottom nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FE),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          )
        ],
      ),
      child: Center(
        child: Text(
          'Inventory',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.50,
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAssetsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0x19C1C6D7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x051A1C1F),
            blurRadius: 40,
            offset: Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL ASSETS',
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.20,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '12 ',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF0058BC),
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.11,
                ),
              ),
              Text(
                'Vials',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF414755),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.56,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              SizedBox(
                width: 48,
                height: 32,
                child: Stack(
                  children: [
                    _buildMiniAvatar(const Color(0x330070EB), Icons.science_outlined),
                    Positioned(
                      left: 16,
                      child: _buildMiniAvatar(const Color(0x3360CDFF), Icons.biotech_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '3 substances expiring soon',
                style: GoogleFonts.inter(
                  color: const Color(0xFF414755),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAvatar(Color color, IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: 14, color: const Color(0xFF0058BC)),
    );
  }

  Widget _buildLibrarySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Peptide Library',
              style: GoogleFonts.manrope(
                color: const Color(0xFF1A1C1F),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Sort by: Status',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _InventoryItemCard(
          name: 'BPC-157',
          description: 'Regenerative Pentadecapeptide',
          status: 'GOOD',
          statusColor: const Color(0xFF10B981),
          statusBg: const Color(0xFFECFDF5),
          remaining: '5 vials',
          validUntil: 'Dec 2025',
        ),
        const SizedBox(height: 16),
        _InventoryItemCard(
          name: 'CJC-1295 + IPA',
          description: 'Energy support & Secretagogue',
          status: 'LOW',
          statusColor: const Color(0xFFF59E0B),
          statusBg: const Color(0xFFFFFBEB),
          remaining: '1,500 mcg',
          validUntil: 'Oct 2024',
        ),
        const SizedBox(height: 16),
        _InventoryItemCard(
          name: 'Thymosin Alpha-1',
          description: 'Immune Support Peptide',
          status: 'EXPIRING SOON',
          statusColor: const Color(0xFFF43F5E),
          statusBg: const Color(0xFFFFF1F2),
          remaining: '2 vials',
          validUntil: 'Aug 2024',
          isCritical: true,
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0058BC).withValues(alpha: 0.3),
              blurRadius: 30,
              offset: const Offset(0, 12),
            )
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPeptideScreen()),
          ),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: Text(
            'Add Peptide',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          ),
        ),
      ),
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  final String name;
  final String description;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final String remaining;
  final String validUntil;
  final bool isCritical;

  const _InventoryItemCard({
    required this.name,
    required this.description,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.remaining,
    required this.validUntil,
    this.isCritical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0x0CC1C6D7)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF1A1C1F),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF414755),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(text: status, bgColor: statusBg, textColor: statusColor),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildInfoColumn('REMAINING', remaining)),
              Expanded(child: _buildInfoColumn('VALID UNTIL', validUntil, isAlert: isCritical)),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PeptideDetailsScreen(
                    peptideName: name,
                    status: status,
                    remaining: remaining,
                    validUntil: validUntil,
                  ),
                ),
              ),
              child: Text(
                'View details',
                style: GoogleFonts.inter(
                  color: const Color(0xFF0058BC),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {bool isAlert = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: isAlert ? const Color(0xFFF43F5E) : const Color(0xFF1A1C1F),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const _StatusBadge({required this.text, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
