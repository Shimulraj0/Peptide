import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/providers/profile_provider.dart';

class PersonalDetailsView extends ConsumerStatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  ConsumerState<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends ConsumerState<PersonalDetailsView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController = TextEditingController(text: profile.fullName);
    _emailController = TextEditingController(text: 'julian.sterling@peptide-lab.com'); // Placeholder or from profile if added
    _phoneController = TextEditingController(text: profile.phoneNumber);
    _dobController = TextEditingController(text: profile.dob ?? '06/15/1988');
    _heightController = TextEditingController(text: profile.height.toString());
    _weightController = TextEditingController(text: profile.weight.toString());
    _selectedGender = profile.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final notifier = ref.read(profileProvider.notifier);
    notifier.updateFullName(_nameController.text);
    notifier.updatePhoneNumber(_phoneController.text);
    notifier.updateDOB(_dobController.text);
    notifier.updateGender(_selectedGender);
    
    final height = double.tryParse(_heightController.text) ?? 0.0;
    final weight = double.tryParse(_weightController.text) ?? 0.0;
    notifier.updateHeight(height);
    notifier.updateWeight(weight);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully', style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFF0058BC),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildIdentificationSection(),
                    const SizedBox(height: 24),
                    _buildBiometricsSection(),
                    const SizedBox(height: 24),
                    _buildPhysicalMetricsSection(),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAnimatedIconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icons.arrow_back,
          ),
          Text(
            'Personal Details',
            style: GoogleFonts.manrope(
              color: const Color(0xFF1A1C1F),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.45,
            ),
          ),
          _buildAnimatedTextButton(
            onPressed: _saveChanges,
            text: 'Save',
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedIconButton({required VoidCallback onPressed, required IconData icon}) {
    return _AnimatedPressButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: const Color(0xFF1A1C1F)),
      ),
    );
  }

  Widget _buildAnimatedTextButton({required VoidCallback onPressed, required String text}) {
    return _AnimatedPressButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: const Color(0xFF0058BC),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildIdentificationSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        children: [
          _buildInputField('FULL NAME', _nameController),
          const SizedBox(height: 20),
          _buildInputField('EMAIL ADDRESS', _emailController, enabled: false),
          const SizedBox(height: 20),
          _buildInputField('PHONE NUMBER', _phoneController),
        ],
      ),
    );
  }

  Widget _buildBiometricsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        children: [
          _buildInputField('DATE OF BIRTH', _dobController, isDate: true),
          const SizedBox(height: 24),
          _buildGenderSelector(),
        ],
      ),
    );
  }

  Widget _buildPhysicalMetricsSection() {
    return Column(
      children: [
        _buildMetricCard(
          label: 'HEIGHT',
          controller: _heightController,
          unit: 'cm',
          icon: Icons.straighten,
          iconBgColor: const Color(0x3360CDFF),
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          label: 'WEIGHT',
          controller: _weightController,
          unit: 'kg',
          icon: Icons.monitor_weight_outlined,
          iconBgColor: const Color(0x190058BC),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool enabled = true, bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF414755),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.60,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
            color: const Color(0xFFE8E8ED),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  style: GoogleFonts.inter(
                    color: enabled ? const Color(0xFF1A1C1F) : const Color(0xFF717786),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (isDate)
                const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF414755)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    final List<String> options = ['Male', 'Female', 'Other'];
    final int selectedIndex = options.indexOf(_selectedGender);

    return Column(
      children: [
        Text(
          'GENDER',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.60,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 48,
          width: double.infinity,
          decoration: ShapeDecoration(
            color: const Color(0xFFE8E8ED),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / 3;
              return Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutQuart,
                    alignment: Alignment(
                      -1 + (selectedIndex * 1.0),
                      0,
                    ),
                    child: Container(
                      width: itemWidth - 8,
                      height: 40,
                      margin: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0058BC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x330058BC),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: options.map((gender) => Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedGender = gender),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutQuart,
                            style: GoogleFonts.inter(
                              color: _selectedGender == gender ? Colors.white : const Color(0xFF414755),
                              fontSize: 14,
                              fontWeight: _selectedGender == gender ? FontWeight.w700 : FontWeight.w600,
                            ),
                            child: Text(gender),
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String label,
    required TextEditingController controller,
    required String unit,
    required IconData icon,
    required Color iconBgColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: iconBgColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
            ),
            child: Icon(icon, color: const Color(0xFF0058BC), size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF414755),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.60,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1A1C1F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        unit,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF414755),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedPressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _AnimatedPressButton({required this.child, required this.onPressed});

  @override
  State<_AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<_AnimatedPressButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
