import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/peptide_model.dart';

class PeptideLibraryHeader extends StatelessWidget {
  final VoidCallback onBack;

  const PeptideLibraryHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xB2F9F9FE),
        border: Border(
          bottom: BorderSide(color: Color(0x7FE8E8ED), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onBack,
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF0F172A),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Browse Peptides',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchFormulationBar extends StatelessWidget {
  const SearchFormulationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 30,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: GoogleFonts.inter(
                color: const Color(0xFF1A1C1F),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Search Formulation Library...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryPill({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: ShapeDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment(0.23, -0.23),
                  end: Alignment(0.77, 1.23),
                  colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
                )
              : null,
          shape: RoundedRectangleBorder(
            side: isSelected
                ? BorderSide.none
                : const BorderSide(width: 1, color: Color(0x19C1C6D7)),
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF414755),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PeptideDetailCard extends StatelessWidget {
  final Peptide peptide;

  const PeptideDetailCard({super.key, required this.peptide});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x7FE8E8ED)),
          borderRadius: BorderRadius.circular(48),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A1A1C1F),
            blurRadius: 30,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: ShapeDecoration(
                  color: peptide.tagBgColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: peptide.tagColor.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  peptide.categoryTag,
                  style: GoogleFonts.inter(
                    color: peptide.tagColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                peptide.casNumber,
                style: const TextStyle(
                  color: Color(0xFF717786),
                  fontSize: 12,
                  fontFamily: 'Liberation Mono',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            peptide.name,
            style: GoogleFonts.manrope(
              color: const Color(0xFF1A1C1F),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.60,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            peptide.description,
            style: GoogleFonts.manrope(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
          const SizedBox(height: 32),
          Column(
            children: peptide.attributes.map((attr) => _AttributeRow(attr: attr)).toList(),
          ),
        ],
      ),
    );
  }
}

class _AttributeRow extends StatelessWidget {
  final PeptideAttribute attr;

  const _AttributeRow({required this.attr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F3F8))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            attr.label,
            style: GoogleFonts.inter(
              color: const Color(0xFF717786),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            attr.value,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1C1F),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
