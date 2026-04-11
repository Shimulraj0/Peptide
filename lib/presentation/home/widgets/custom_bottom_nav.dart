import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // HOME - The large circular button
          _buildHomeItem(),
          
          // Other navigation items
          _buildNavItem(1, Icons.description_rounded, 'LOGS'),
          _buildNavItem(2, Icons.inventory_2_rounded, 'INVENTORY'),
          _buildNavItem(3, Icons.person_rounded, 'PROFILE'),
          const SizedBox(width: 8), // Small end padding
        ],
      ),
    );
  }

  Widget _buildHomeItem() {
    bool isSelected = currentIndex == 0;
    return GestureDetector(
      onTap: () => onTap(0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isSelected ? const LinearGradient(
            colors: [Color(0xFF48C6EF), Color(0xFF008B94)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ) : null,
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF48C6EF).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              color: isSelected ? Colors.white : const Color(0xFF94A3B8),
              size: 28,
            ),
            const SizedBox(height: 2),
            Text(
              'HOME',
              style: GoogleFonts.montserrat(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFE0F7FA) : Colors.transparent,
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF008B94).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF008B94) : const Color(0xFF94A3B8),
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 8,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? const Color(0xFF008B94) : const Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
