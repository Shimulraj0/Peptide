import 'package:flutter/material.dart';
import 'views/log_entry_view.dart';

class LogEntryScreen extends StatelessWidget {
  const LogEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9F9FE),
      body: SafeArea(
        bottom: false,
        child: LogEntryView(),
      ),
    );
  }
}
