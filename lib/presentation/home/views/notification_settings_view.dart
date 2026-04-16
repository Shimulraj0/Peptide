import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool pushEnabled = true;
  bool emailEnabled = false;
  bool injectionRemindersEnabled = true;
  bool inventoryAlertsEnabled = true;

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    const SizedBox(height: 32),
                    _buildSectionHeader('CHANNELS'),
                    const SizedBox(height: 16),
                    _NotificationToggle(
                      icon: Icons.notifications_active_outlined,
                      iconColor: const Color(0xFF0058BC),
                      iconBgColor: const Color(0x0C0058BC),
                      title: 'Push Notifications',
                      subtitle: 'Real-time alerts on your device',
                      value: pushEnabled,
                      onChanged: (val) => setState(() => pushEnabled = val),
                    ),
                    const SizedBox(height: 16),
                    _NotificationToggle(
                      icon: Icons.mail_outline_rounded,
                      iconColor: const Color(0xFF0058BC),
                      iconBgColor: const Color(0x0C0058BC),
                      title: 'Email Notifications',
                      subtitle: 'Daily summaries and reports',
                      value: emailEnabled,
                      onChanged: (val) => setState(() => emailEnabled = val),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionHeader('CLINICAL ALERTS'),
                    const SizedBox(height: 16),
                    _NotificationToggle(
                      icon: Icons.medical_services_outlined,
                      iconColor: const Color(0xFFBA1A1A),
                      iconBgColor: const Color(0xFFFFDBCC),
                      title: 'Injection Reminders',
                      subtitle: 'Schedule-based protocol alerts',
                      value: injectionRemindersEnabled,
                      onChanged: (val) => setState(() => injectionRemindersEnabled = val),
                    ),
                    const SizedBox(height: 16),
                    _NotificationToggle(
                      icon: Icons.inventory_2_outlined,
                      iconColor: const Color(0xFF0058BC),
                      iconBgColor: const Color(0xFFC1E8FF),
                      title: 'Inventory Alerts',
                      subtitle: 'Low supply and refill warnings',
                      value: inventoryAlertsEnabled,
                      onChanged: (val) => setState(() => inventoryAlertsEnabled = val),
                    ),
                    const SizedBox(height: 40),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          Text(
            'Notification',
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

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.20,
            letterSpacing: -0.75,
          ),
        ),
        const SizedBox(height: 8),
        Opacity(
          opacity: 0.7,
          child: Text(
            'Tailor your clinical alerts and reminders for optimal\ncare management.',
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.43,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          color: const Color(0xFF414755),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.20,
        ),
      ),
    );
  }
}

class _NotificationToggle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationToggle({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x190058BC),
            blurRadius: 20,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              color: iconBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1A1C1F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF414755),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
          _CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: ShapeDecoration(
          color: value ? const Color(0xFF0058BC) : const Color(0xFFE2E2E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: const CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
