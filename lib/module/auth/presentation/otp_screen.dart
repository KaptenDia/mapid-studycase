import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapid/helper/navigator.dart';
import 'package:mapid/module/home/presentation/home_screen.dart';
import 'package:mapid/shared/themes/themes.dart';
import 'package:mapid/shared/widget/button/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  final int _otpLength = 6;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late AnimationController _timerController;
  late AnimationController _submitScaleController;

  Timer? _countdownTimer;
  int _secondsRemaining = 59;
  bool _canResend = false;
  bool _isSuccess = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 59),
    )..forward();

    _submitScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );

    _startCountdown();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _secondsRemaining = 59;
      _canResend = false;
    });
    _timerController.forward(from: 0);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
          _canResend = true;
        });
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _resendCode() {
    for (final c in _controllers) {
      c.clear();
    }
    _startCountdown();
    setState(() {
      _isSuccess = false;
      _errorMessage = null;
    });
    _focusNodes[0].requestFocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Kode baru telah dikirim.',
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      ),
    );
  }

  String get _currentOtp => _controllers.map((c) => c.text).join();

  bool get _isComplete => _currentOtp.length == _otpLength;

  void _onFieldChanged(int index, String value) {
    setState(() => _errorMessage = null);
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < digits.length && index + i < _otpLength; i++) {
        _controllers[index + i].text = digits[i];
      }
      final nextIndex = (index + digits.length).clamp(0, _otpLength - 1);
      _focusNodes[nextIndex].requestFocus();
    }
    setState(() {});
  }

  void _onKeyBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      setState(() {});
    }
  }

  Future<void> _submit() async {
    // Tap animation
    await _submitScaleController.reverse();
    await _submitScaleController.forward();

    // TODO: Replace with actual OTP validation
    if (_currentOtp == '123456') {
      setState(() => _isSuccess = true);
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        navigator.pushAndRemoveUntil(HomeScreen());
      }
    } else {
      setState(() => _errorMessage = 'Kode OTP tidak valid. Coba lagi.');
      HapticFeedback.mediumImpact();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timerController.dispose();
    _submitScaleController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48.h,
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxWidth: 450.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF0D5BDA), Color(0xFF001E62)],
                            ),
                          ),
                        ),

                        Column(
                          children: [
                            _buildHeading(),
                            SizedBox(height: 32.h),
                            _buildOtpRow(),
                            SizedBox(height: 12.h),
                            _buildTimerRow(),
                            if (_errorMessage != null) ...[
                              SizedBox(height: 12.h),
                              _buildErrorBanner(),
                            ],
                            SizedBox(height: 24.h),
                            Padding(
                              padding: EdgeInsets.all(12.dg),
                              child: CustomButton(
                                text: _isSuccess ? 'Berhasil!' : 'Verifikasi',
                                onPressed: _submit,
                                isEnabled: _isComplete,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeading() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 24.h),
      Text(
        'Masukkan kode OTP',
        textAlign: TextAlign.center,
        style: AppTextStyle.title1.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.2,
        ),
      ),
      SizedBox(height: 8.h),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyle.body.copyWith(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          children: [
            const TextSpan(text: 'Kode 6-digit telah dikirim ke\n'),
            TextSpan(
              text: 'user@email.com',
              style: AppTextStyle.body.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildOtpRow() {
    final width = (MediaQuery.of(context).size.width - 80.w) / _otpLength;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_otpLength, (i) => _buildOtpCell(i, width)),
      ),
    );
  }

  Widget _buildOtpCell(int index, double size) {
    final isFilled = _controllers[index].text.isNotEmpty;
    final isFocused = _focusNodes[index].hasFocus;
    final hasError = _errorMessage != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isFilled ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: hasError
              ? Colors.red.shade400
              : isFocused
              ? AppColors.primaryColor
              : isFilled
              ? const Color(0xFF1D9E75)
              : const Color(0xFFDDDDDD),
          width: isFocused ? 2.0 : 1.5,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.12),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            _onKeyBackspace(index);
          }
          return KeyEventResult.ignored;
        },
        child: Center(
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: AppTextStyle.title2.copyWith(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            onChanged: (v) => _onFieldChanged(index, v),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _canResend
          ? TextButton(
              onPressed: _resendCode,
              child: Text(
                'Kirim ulang kode',
                style: AppTextStyle.caption.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          : RichText(
              text: TextSpan(
                style: AppTextStyle.caption.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'Kirim ulang dalam '),
                  TextSpan(
                    text: '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: AppTextStyle.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
    ],
  );

  Widget _buildErrorBanner() => Container(
    margin: EdgeInsets.all(12.dg),
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: AppColors.backgroundOverdue,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          _errorMessage!,
          style: AppTextStyle.caption.copyWith(
            fontSize: 13.sp,
            color: AppColors.backgroundUnpaid,
          ),
        ),
      ],
    ),
  );
}
