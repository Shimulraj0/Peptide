import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPeptideScreen extends StatefulWidget {
  const AddPeptideScreen({super.key});

  @override
  State<AddPeptideScreen> createState() => _AddPeptideScreenState();
}

class _AddPeptideScreenState extends State<AddPeptideScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  String selectedUnit = 'mg';
  String? expirationDate;

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
                child: Column(
                  children: [
                    _buildTopSection(),
                    const SizedBox(height: 40),
                    _buildFormCard(context),
                    const SizedBox(height: 40),
                    _buildSaveButton(context),
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
        color: Color(0xFFF9F9FE),
        boxShadow: [
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1C1F)),
          ),
          const SizedBox(width: 8),
          Text(
            'Add Peptide',
            style: GoogleFonts.manrope(
              color: const Color(0xFF1A1C1F),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF6FF),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.science_outlined, color: Color(0xFF0058BC), size: 36),
        ),
        const SizedBox(height: 24),
        Text(
          'New Formulation',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.75,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter the precise details for your supply tracking.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(44),
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
          _buildTextField('PEPTIDE NAME', nameController, 'e.g. Tirzepatide'),
          const SizedBox(height: 32),
          _buildTextField('AMOUNT', amountController, '0.00', keyboardType: TextInputType.number),
          const SizedBox(height: 32),
          _buildUnitSelector(),
          const SizedBox(height: 32),
          _buildDatePickerField(context),
          const SizedBox(height: 32),
          _buildTextField('STORAGE NOTES', notesController, 'Add refrigeration details or manufacturer info...', maxLines: 4),
          const SizedBox(height: 40),
          _buildInfoBanner(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.20,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: const Color(0xFF1A1C1F), fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: const Color(0xFF717786), fontSize: 16),
            filled: true,
            fillColor: const Color(0xFFE8E8ED),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 24 : 30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitSelector() {
    final units = ['mg', 'Vials'];
    final selectedIndex = units.indexOf(selectedUnit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UNIT SELECTOR',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.20,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 54,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8ED),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment(selectedIndex == 0 ? -1.0 : 1.0, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A1A1C1F),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: units.map((u) => _buildUnitButton(u)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitButton(String unit) {
    final bool isSelected = selectedUnit == unit;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedUnit = unit),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: GoogleFonts.inter(
              color: isSelected ? const Color(0xFF0058BC) : const Color(0xFF414755),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            child: Text(unit),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPIRATION DATE',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.20,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
            );
            if (date != null) {
              setState(() => expirationDate = '${date.month}/${date.day}/${date.year}');
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8ED),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expirationDate ?? 'mm/dd/yyyy',
                  style: GoogleFonts.inter(
                    color: expirationDate != null ? const Color(0xFF1A1C1F) : const Color(0xFF717786),
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.calendar_today_outlined, color: Color(0xFF717786), size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFF0058BC), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tracking ensures you never run out of your critical Tracking cycle. Details are encrypted locally.',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0058BC).withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Peptide saved successfully')),
          );
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              'Save Peptide',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
