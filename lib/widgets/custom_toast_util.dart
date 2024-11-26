import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

///Custom Toast Util used to show toast message in different success, failure situations
class CustomToastUtil {
  static final _toastUtil = CustomToastUtil._();
  static final List<_ToastProperties> _toastQueue = [];
  static bool _isShowingToast = false;
  static late BuildContext _context;
  static OverlaySupportEntry? _overlayEntry;
  static Timer? _timer;

  CustomToastUtil._();

  ///
  factory CustomToastUtil() {
    return _toastUtil;
  }

  ///Init function
  static void init(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    _context = context;
  }

  ///Customizable Toast Message
  static void showToast({
    String? message,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor,
    IconData? prefixIcon,
    Widget? trailing,
  }) {
    final toast = _ToastProperties(
      message: message ?? 'Oops! We came across an error.',
      textColor: textColor ?? Colors.white,
      borderColor: borderColor ?? Colors.redAccent,
      backgroundColor: backgroundColor ?? Colors.redAccent,
      trailing: trailing ?? const SizedBox.shrink(),
      prefixIcon: prefixIcon ?? Icons.warning_amber_outlined,
    );
    _toastQueue.add(toast);
    if (!_isShowingToast) {
      _buildToast();
    }
  }

  ///Toast Message after success scenario
  static void showSucessToast({
    String? message,
    IconData? prefixIcon,
    Widget? trailing,
  }) {
    final toast = _ToastProperties(
      message: message ?? 'Success',
      textColor: Colors.white,
      borderColor: Colors.greenAccent,
      backgroundColor: Colors.greenAccent,
      trailing: trailing ?? const SizedBox.shrink(),
      prefixIcon: prefixIcon ?? Icons.check,
    );
    _toastQueue.add(toast);
    if (!_isShowingToast) {
      _buildToast();
    }
  }

  ///Toast Message after Failure Scenario
  static void showFailureToast({
    String? message,
    IconData? prefixIcon,
    Widget? trailing,
  }) {
    final toast = _ToastProperties(
      message: message ?? 'Oops! We came across an error.',
      textColor: Colors.white,
      borderColor: Colors.redAccent,
      backgroundColor: Colors.redAccent,
      trailing: trailing ?? const SizedBox.shrink(),
      prefixIcon: prefixIcon ?? Icons.warning_amber_outlined,
    );
    _toastQueue.add(toast);
    if (!_isShowingToast) {
      _buildToast();
    }
  }

  ///Function to hide current toast
  static void hideCurrentToast() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.dismiss();
    _overlayEntry = null;
    _onToastComplete();
  }

  static void _buildToast() async {
    _isShowingToast = true;
    await Future.delayed(const Duration(milliseconds: 200));
    final toast = _toastQueue[0];
    _overlayEntry = showOverlay(
      duration: Duration.zero,
      context: _context,
      (context, progress) => DefaultTextStyle(
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ).copyWith(color: toast.textColor),
        child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: 40,
          ),
          duration: const Duration(milliseconds: 100),
          builder: (context, value, child) {
            return Positioned(
              bottom: value,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: toast.borderColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          color: toast.borderColor.withOpacity(0.4))
                    ]),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: toast.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 18,
                        child: FittedBox(
                          child: Icon(
                            toast.prefixIcon,
                            color: toast.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          toast.message,
                          style: TextStyle(
                            fontSize: 12,
                            color: toast.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      toast.trailing,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    _timer = Timer(const Duration(seconds: 3), () {
      _overlayEntry?.dismiss();
      _overlayEntry = null;
      _onToastComplete();
    });
  }

  static void _onToastComplete() {
    _isShowingToast = false;
    _toastQueue.removeAt(0);
    if (_toastQueue.isNotEmpty) {
      _buildToast();
    }
  }
}

class _ToastProperties {
  final String message;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final IconData prefixIcon;
  final Widget trailing;
  _ToastProperties({
    required this.message,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.prefixIcon,
    required this.trailing,
  });
}
