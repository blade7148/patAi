import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorText extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorText({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(Icons.error_outline, color: Colors.red, size: 16.sp),
            ),
          ),
          TextSpan(
            text: message,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.sp,
            ),
          ),
          if (onRetry != null) ...[
            TextSpan(
              text: ' • ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            TextSpan(
              text: 'Retry',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              recognizer: onRetry != null
                  ? (TapGestureRecognizer()..onTap = onRetry)
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}
