import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Protocol {
  final String title;
  final String status;
  final double progress;
  final String nextDose;
  final Color accentColor;

  Protocol({
    required this.title,
    required this.status,
    required this.progress,
    required this.nextDose,
    required this.accentColor,
  });
}

class ProtocolNotifier extends StateNotifier<List<Protocol>> {
  ProtocolNotifier() : super([
    Protocol(
      title: 'BPC-157 Protocol',
      status: 'Restorative Phase • Week 4/8',
      progress: 0.65,
      nextDose: 'Today, 08:00 PM',
      accentColor: const Color(0xFF0058BC),
    ),
    Protocol(
      title: 'CJC-1295 / Ipamorelin',
      status: 'Growth Phase • Week 2/12',
      progress: 0.18,
      nextDose: 'Tomorrow, 09:30 AM',
      accentColor: const Color(0xFF6366F1),
    ),
  ]);

  void addProtocol(Protocol protocol) {
    state = [...state, protocol];
  }

  void updateProgress(int index, double progress) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Protocol(
            title: state[i].title,
            status: state[i].status,
            progress: progress,
            nextDose: state[i].nextDose,
            accentColor: state[i].accentColor,
          )
        else
          state[i],
    ];
  }
}

final protocolProvider = StateNotifierProvider<ProtocolNotifier, List<Protocol>>((ref) {
  return ProtocolNotifier();
});
