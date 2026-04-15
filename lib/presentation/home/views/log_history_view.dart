import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../widgets/log_widgets.dart';

class LogHistoryView extends ConsumerWidget {
  const LogHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SafeArea(
          child: LogHeader(
            onBack: () => ref.read(navigationProvider.notifier).state = 0,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
              bottom: 128,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimelineSection(
                  date: 'Today',
                  children: const [
                    LogTimelineCard(
                      peptide: 'BPC-157',
                      location: 'Abdomen',
                      dosage: '250mcg',
                      time: '08:00 PM',
                      dotColor: Color(0xFF0058BC),
                      iconBgColor: Color(0x190058BC),
                      icon: Icons.colorize_outlined,
                    ),
                    LogTimelineCard(
                      peptide: 'CJC-1295',
                      location: 'Left Thigh',
                      dosage: '100mcg',
                      time: '07:30 AM',
                      dotColor: Color(0x660058BC),
                      iconBgColor: Color(0x19006687),
                      icon: Icons.biotech_outlined,
                    ),
                  ],
                ),
                TimelineSection(
                  date: 'Yesterday',
                  children: const [
                    LogTimelineCard(
                      peptide: 'BPC-157',
                      location: 'Right Shoulder',
                      dosage: '250mcg',
                      time: '09:15 PM',
                      dotColor: Color(0xFFC1C6D7),
                      iconBgColor: Color(0xFFE8E8ED),
                      icon: Icons.opacity_outlined,
                    ),
                  ],
                ),
                TimelineSection(
                  date: 'Oct 24, 2023',
                  isLast: true,
                  children: const [
                    LogTimelineCard(
                      peptide: 'Ipamorelin',
                      location: 'Abdomen',
                      dosage: '200mcg',
                      time: '08:45 PM',
                      dotColor: Color(0xFFC1C6D7),
                      iconBgColor: Color(0xFFE8E8ED),
                      icon: Icons.science_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
