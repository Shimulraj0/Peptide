import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';
import 'providers/profile_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    nameController = TextEditingController(text: profile.fullName);
    phoneController = TextEditingController(text: profile.phoneNumber);
    heightController = TextEditingController(text: profile.height.toString());
    weightController = TextEditingController(text: profile.weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    const SizedBox(height: 48),
                    _buildFormCard(profile),
                    const SizedBox(height: 48),
                    _buildContinueButton(context),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1C1F)),
              ),
              const SizedBox(width: 8),
              Text(
                'Profile Setup',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF1A1C1F),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.50,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => _navigateToHome(context),
            child: Text(
              'Skip',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
          'Personal\nInformation',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.11,
            letterSpacing: -0.90,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Complete your clinical profile to help our personalize your restorative protocols and tracking metrics.',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.63,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(UserProfile profile) {
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
          _buildTextField('Full Name', nameController, (val) => ref.read(profileProvider.notifier).updateFullName(val)),
          const SizedBox(height: 24),
          _buildTextField('Phone Number', phoneController, (val) => ref.read(profileProvider.notifier).updatePhoneNumber(val), keyboardType: TextInputType.phone),
          const SizedBox(height: 24),
          _buildDatePickerField('Date of Birth', profile.dob),
          const SizedBox(height: 24),
          _buildGenderToggle(profile.gender),
          const SizedBox(height: 32),
          const Divider(color: Color(0xFFE2E2E7)),
          const SizedBox(height: 24),
          _buildAnthropometricData(profile),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(color: const Color(0xFF1A1C1F), fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE8E8ED),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField(String label, String? dob) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              ref.read(profileProvider.notifier).updateDOB('${date.month}/${date.day}/${date.year}');
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
                  dob ?? 'mm/dd/yyyy',
                  style: GoogleFonts.inter(
                    color: dob != null ? const Color(0xFF1A1C1F) : const Color(0xFF717786),
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

  Widget _buildGenderToggle(String selectedGender) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: GoogleFonts.inter(
            color: const Color(0xFF414755),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8ED),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              _buildGenderButton('Male', selectedGender),
              _buildGenderButton('Female', selectedGender),
              _buildGenderButton('Other', selectedGender),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderButton(String gender, String selectedGender) {
    final bool isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => ref.read(profileProvider.notifier).updateGender(gender),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x0A1A1C1F),
                      blurRadius: 40,
                      offset: Offset(0, 12),
                    )
                  ]
                : null,
          ),
          child: Text(
            gender,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: isSelected ? const Color(0xFF0058BC) : const Color(0xFF414755),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnthropometricData(UserProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anthropometric Data',
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildDataCard('HEIGHT', heightController, 'cm', Icons.height, (val) => ref.read(profileProvider.notifier).updateHeight(double.tryParse(val) ?? 0)),
            const SizedBox(width: 16),
            _buildDataCard('WEIGHT', weightController, 'kg', Icons.monitor_weight_outlined, (val) => ref.read(profileProvider.notifier).updateWeight(double.tryParse(val) ?? 0)),
          ],
        ),
      ],
    );
  }

  Widget _buildDataCard(String label, TextEditingController controller, String unit, IconData icon, Function(String) onChanged) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(width: 4),
                Icon(icon, size: 12, color: const Color(0xFF0058BC)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Text(
                  unit,
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
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Column(
      children: [
        Container(
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
            onPressed: () => _navigateToHome(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
            ),
            child: Text(
              'Continue',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text.rich(
            TextSpan(
              text: 'By clicking continue, you agree to our ',
              style: GoogleFonts.inter(
                color: const Color(0xFF414755),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.63,
              ),
              children: [
                const TextSpan(
                  text: 'Health Data Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF0058BC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' and clinical terms of service.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
