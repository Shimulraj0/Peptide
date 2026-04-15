import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/providers/profile_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(profile),
                const SizedBox(height: 32),
                
                _buildSectionHeader('ACCOUNT'),
                const SizedBox(height: 16),
                _buildSettingItem(
                  icon: Icons.person_outline,
                  title: 'Personal Details',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.lock_outline,
                  title: 'Security and Password',
                  onTap: () {},
                ),
                
                const SizedBox(height: 32),
                _buildSectionHeader('NOTIFICATIONS'),
                const SizedBox(height: 16),
                _buildSettingItem(
                  icon: Icons.notifications_none_outlined,
                  title: 'Notifications settings',
                  onTap: () {},
                ),

                const SizedBox(height: 32),
                _buildSectionHeader('GENERAL'),
                const SizedBox(height: 16),
                _buildSettingItem(
                  icon: Icons.language_outlined,
                  title: 'Languages',
                  trailingText: 'English',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.star_outline,
                  title: 'Leave a Review',
                  onTap: () {},
                ),

                const SizedBox(height: 32),
                _buildSectionHeader('DATA & LEGAL'),
                const SizedBox(height: 16),
                _buildSettingItem(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  trailingIcon: Icons.open_in_new,
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  trailingIcon: Icons.open_in_new,
                  onTap: () {},
                ),

                const SizedBox(height: 64),
                _buildAppVersion(),
                const SizedBox(height: 24),
                _buildLogoutButton(context),
                const SizedBox(height: 12),
                _buildDeleteAccountButton(),
                const SizedBox(height: 128), // Space for bottom nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Settings',
            style: GoogleFonts.manrope(
              color: const Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.50,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(UserProfile profile) {
    return Container(
      width: double.infinity,
      height: 344,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.80),
            Colors.white.withValues(alpha: 0.40),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.white.withValues(alpha: 0.60),
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x660058BC),
            blurRadius: 20,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative background circle
          Positioned(
            left: -39,
            top: -39,
            child: Container(
              width: 160,
              height: 160,
              decoration: const ShapeDecoration(
                color: Color(0x0C0058BC),
                shape: CircleBorder(),
              ),
            ),
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 112,
                    height: 112,
                    padding: const EdgeInsets.all(4),
                    decoration: const ShapeDecoration(
                      color: Color(0xFF0058BC),
                      shape: CircleBorder(),
                    ),
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(width: 4, color: Colors.white),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(profile.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const ShapeDecoration(
                          color: Color(0xFF0058BC),
                          shape: CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                profile.fullName,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF0A0C10),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.60,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0x190058BC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Text(
                  'julian.pierce@sanctuary.wellness',
                  style: GoogleFonts.manrope(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          color: const Color(0xFF414755),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? trailingText,
    IconData? trailingIcon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 64,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF0058BC), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF1A1C1F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (trailingText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      trailingText,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF414755),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Icon(
                  trailingIcon ?? Icons.chevron_right,
                  color: const Color(0xFFC1C6D7),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppVersion() {
    return Center(
      child: Text(
        'APP VERSION 2.4.0 (CLINICAL)',
        style: GoogleFonts.inter(
          color: const Color(0xFF717786),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0058BC), Color(0xFF0070EB)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x330058BC),
            blurRadius: 15,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(32),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Logout',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: ShapeDecoration(
        color: const Color(0x19FFDAD6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(32),
          child: Center(
            child: Text(
              'Delete Account',
              style: GoogleFonts.manrope(
                color: const Color(0xFFBA1A1A),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
