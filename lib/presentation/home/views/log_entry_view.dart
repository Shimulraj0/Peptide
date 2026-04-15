import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'log_confirmation_view.dart';

class LogEntryView extends StatefulWidget {
  const LogEntryView({super.key});

  @override
  State<LogEntryView> createState() => _LogEntryViewState();
}

class _LogEntryViewState extends State<LogEntryView> {
  String selectedArea = 'Abdomen';
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _amountController = TextEditingController(text: '250');
  final TextEditingController _notesController = TextEditingController();

  final List<String> injectionAreas = ['Abdomen', 'Thigh', 'Arm', 'Shoulder'];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

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
                _buildFormSection(),
                const SizedBox(height: 40),
                _buildRecentLogsSection(),
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
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FE),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Center(
        child: Text(
          'Log Entry',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.45,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('PEPTIDE NAME'),
        const SizedBox(height: 8),
        _buildReadOnlyField('BPC-157'),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('AMOUNT'),
                  const SizedBox(height: 8),
                  _buildAmountField(),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('TIME'),
                  const SizedBox(height: 8),
                  _buildTimeField(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildLabel('AREA'),
        const SizedBox(height: 12),
        _buildAreaSelector(),
        const SizedBox(height: 24),
        _buildLabel('NOTES (OPTIONAL)'),
        const SizedBox(height: 8),
        _buildNotesField(),
        const SizedBox(height: 32),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF414755),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.20,
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String text) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8ED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8ED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: const Color(0xFF1A1C1F),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Text(
            'mcg',
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8ED),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime.format(context),
              style: GoogleFonts.inter(
                color: const Color(0xFF1A1C1F),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.access_time, color: Color(0xFF414755), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaSelector() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: injectionAreas.map((area) {
        final bool isSelected = selectedArea == area;
        return GestureDetector(
          onTap: () => setState(() => selectedArea = area),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0x190058BC) : const Color(0xFFE8E8ED),
              borderRadius: BorderRadius.circular(9999),
              border: isSelected ? Border.all(color: const Color(0x330058BC)) : null,
            ),
            child: Text(
              area,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF0058BC) : const Color(0xFF414755),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotesField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8ED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _notesController,
        maxLines: 4,
        style: GoogleFonts.inter(
          color: const Color(0xFF1A1C1F),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'How are you feeling?',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BC).withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(9999),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LogConfirmationView(
                  peptide: 'BPC-157',
                  amount: '${_amountController.text} mcg',
                  time: selectedTime.format(context),
                  area: selectedArea,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Save Entry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentLogsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Logs',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.50,
          ),
        ),
        const SizedBox(height: 24),
        _buildLogCard('BPC-157', 'Today • 08:00 AM • Abdomen', '250 mcg'),
        const SizedBox(height: 16),
        _buildLogCard('CJC-1295', 'Yesterday • 09:15 PM • Thigh', '100 mcg'),
        const SizedBox(height: 16),
        _buildLogCard('BPC-157', 'Oct 24 • 08:00 AM • Abdomen', '250 mcg'),
      ],
    );
  }

  Widget _buildLogCard(String title, String subtitle, String amount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F8),
        borderRadius: BorderRadius.circular(32),
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
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.colorize_outlined, color: Color(0xFF0058BC), size: 20),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
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
          Text(
            amount,
            style: GoogleFonts.inter(
              color: const Color(0xFF0058BC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
