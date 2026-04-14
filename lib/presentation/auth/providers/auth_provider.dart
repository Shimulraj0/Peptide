import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationState {
  final bool isLoading;
  final int resendTimer;
  final String? error;

  VerificationState({
    this.isLoading = false,
    this.resendTimer = 0,
    this.error,
  });

  VerificationState copyWith({
    bool? isLoading,
    int? resendTimer,
    String? error,
  }) {
    return VerificationState(
      isLoading: isLoading ?? this.isLoading,
      resendTimer: resendTimer ?? this.resendTimer,
      error: error ?? this.error,
    );
  }
}

class VerificationNotifier extends StateNotifier<VerificationState> {
  VerificationNotifier() : super(VerificationState());

  Timer? _timer;

  void startResendTimer() {
    state = state.copyWith(resendTimer: 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer > 0) {
        state = state.copyWith(resendTimer: state.resendTimer - 1);
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    state = state.copyWith(isLoading: false);
    return true; // Assume success for now
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final verificationProvider = StateNotifierProvider<VerificationNotifier, VerificationState>((ref) {
  return VerificationNotifier();
});
