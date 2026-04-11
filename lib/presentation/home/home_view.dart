import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/custom_bottom_nav.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120), // Padding for Bottom Nav
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildScheduledProtocol(),
                  const SizedBox(height: 20),
                  _buildLogButton(),
                  const SizedBox(height: 32),
                  _buildProtocolProgress(),
                  const SizedBox(height: 32),
                  _buildExplorePeptides(),
                  const SizedBox(height: 32),
                  _buildRecentActivity(),
                ],
              ),
            ),
          ),
          
          // Fixed Bottom Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Text(
        'HOME',
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF111827),
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildScheduledProtocol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SCHEDULED PROTOCOL',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                'TODAY',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF48C6EF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEXT DOSE',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'BPC-157',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildMetric('DOSAGE', '250 mcg', const Color(0xFF008B94)),
                      const SizedBox(width: 40),
                      _buildMetric('TIME', '08:00 AM', const Color(0xFF374151)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 4),
                      Text(
                        'Site: ',
                        style: GoogleFonts.montserrat(fontSize: 13, color: const Color(0xFF9CA3AF)),
                      ),
                      Text(
                        'Left Abdomen',
                        style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.medical_services_rounded, color: Color(0xFF008B94), size: 28),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetric(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w800, color: const Color(0xFFD1D5DB)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w900, color: valueColor),
        ),
      ],
    );
  }

  Widget _buildLogButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xFF00E5FF), Color(0xFF008B94)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  '+ Log Injection',
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProtocolProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'PROTOCOL PROGRESS',
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressDay('MON', true, false),
              _buildProgressDay('TUE', true, false),
              _buildProgressDay('WED', false, true),
              _buildProgressDay('THU', false, false),
              _buildProgressDay('FRI', false, false),
              _buildProgressDay('SAT', false, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDay(String day, bool completed, bool active) {
    return Column(
      children: [
        Text(
          day,
          style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF9CA3AF)),
        ),
        const SizedBox(height: 12),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed ? const Color(0xFFE0F7FA) : Colors.transparent,
            border: Border.all(
              color: active ? const Color(0xFF00E5FF) : const Color(0xFFF3F4F6),
              width: active ? 3 : 1,
            ),
          ),
          child: Center(
            child: completed 
              ? const Icon(Icons.check, size: 16, color: Color(0xFF008B94))
              : active 
                ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle))
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildExplorePeptides() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore Peptides',
                style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF374151)),
              ),
              Text(
                'Discover All',
                style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _buildExploreCard('Tirzepatide', 'Metabolic Support', Icons.bolt_rounded),
              const SizedBox(width: 16),
              _buildExploreCard('Semaglutide', 'Glucose Balance', Icons.biotech_rounded),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExploreCard(String title, String subtitle, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFF0F4F8), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF008B94), size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.montserrat(fontSize: 11, color: const Color(0xFF6B7280))),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECENT ACTIVITY',
                style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)),
              ),
              Text(
                'SEE ALL',
                style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            _buildActivityItem('CJC-1293 Logged', 'Today, 07:15 AM', '+ 100mcg', Icons.medical_services_outlined),
            const SizedBox(height: 12),
            _buildActivityItem('Weight Update', 'Yesterday, 06:30 PM', '184.2 lbs', Icons.show_chart_rounded),
            const SizedBox(height: 12),
            _buildActivityItem('Hydration Peak', 'Yesterday, 04:00 PM', '', Icons.opacity_rounded, showTrend: true),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, String value, IconData icon, {bool showTrend = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: const Color(0xFFF9FAFB)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF94A3B8), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                const SizedBox(height: 4),
                Text(time, style: GoogleFonts.montserrat(fontSize: 12, color: const Color(0xFF94A3B8))),
              ],
            ),
          ),
          if (value.isNotEmpty)
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: value.contains('+') ? const Color(0xFF008B94) : const Color(0xFF334155),
              ),
            ),
          if (showTrend)
            const Icon(Icons.trending_up_rounded, color: Colors.orangeAccent, size: 20),
        ],
      ),
    );
  }
}
