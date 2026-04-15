import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/dashboard_widgets.dart';
import 'widgets/custom_bottom_nav.dart';
import 'providers/navigation_provider.dart';
import '../auth/providers/profile_provider.dart';
import 'views/log_history_view.dart';
import 'log_entry_screen.dart';
import 'views/inventory_view.dart';
import 'peptide_library_screen.dart';
import 'views/settings_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Standard Dashboard Header always visible or part of the view
            if (currentIndex == 0)
              DashboardHeader(
                userName: profile.fullName,
                avatarUrl: profile.avatarUrl,
              ),
            
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: [
                  _DashboardView(profile: profile),
                  const LogHistoryView(),
                  const InventoryView(),
                  const SettingsView(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(navigationProvider.notifier).state = index,
      ),
    );
  }
}

class _DashboardView extends ConsumerWidget {
  final UserProfile profile;

  const _DashboardView({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NextLogCard(
            peptide: 'BPC-157',
            time: 'Today, 8:00 PM',
            location: 'Abdomen',
            dosage: '250mcg',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LogEntryScreen()),
            ),
          ),
          const SizedBox(height: 34),
          const WeightMetricCard(
            weight: 78.4,
            unit: 'kg',
            lastUpdated: '2 hours ago',
          ),
          const SizedBox(height: 34),
          const Row(
            children: [
              StatItem(label: 'TOTAL', value: '24', subLabel: 'Logs'),
              SizedBox(width: 16),
              StatItem(label: 'ACTIVE', value: '2', subLabel: 'Peptides'),
              SizedBox(width: 16),
              StatItem(label: 'STOCK', value: '15%', subLabel: 'Remaining'),
            ],
          ),
          const SizedBox(height: 48),
          _SectionHeader(
            title: 'Recent Activity',
            actionText: 'View History',
            onAction: () => ref.read(navigationProvider.notifier).state = 1,
          ),
          const SizedBox(height: 16),
          const Column(
            children: [
              ActivityTile(peptide: 'CJC-1295', usage: 'Abdomen', time: 'Yesterday'),
              SizedBox(height: 12),
              ActivityTile(peptide: 'BPC-157', usage: 'Shoulder', time: '2 days ago'),
              SizedBox(height: 12),
              ActivityTile(peptide: 'CJC-1295', usage: 'Abdomen', time: '3 days ago'),
            ],
          ),
          const SizedBox(height: 48),
          _SectionHeader(
            title: 'Browse Peptides',
            actionText: 'View All',
            onAction: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PeptideLibraryScreen()),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: const [
                BrowseCard(title: 'BPC-157', subTitle: 'Tissue & Joint Recovery'),
                SizedBox(width: 16),
                BrowseCard(title: 'CJC-1295', subTitle: 'Performance Support'),
                SizedBox(width: 16),
                BrowseCard(title: 'Semax', subTitle: 'Cognitive Performance'),
                SizedBox(width: 16),
                BrowseCard(title: 'Ipamorelin', subTitle: 'Muscle Preservation'),
              ],
            ),
          ),
          const SizedBox(height: 100), // Spacing for bottom nav
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            color: const Color(0xFF1A1C1F),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.50,
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionText,
            style: GoogleFonts.inter(
              color: const Color(0xFF0058BC),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

