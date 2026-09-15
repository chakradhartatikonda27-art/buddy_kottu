import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/order_model.dart';
import '../../../../core/constants/app_colors.dart';

class OrderTimeline extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderTimeline({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'status': OrderStatus.ORDER_RECEIVED, 'label': 'Order received', 'time': '6:02 PM'},
      {'status': OrderStatus.ACCEPTED, 'label': 'Accepted by store', 'time': '6:03 PM'},
      {'status': OrderStatus.PREPARING, 'label': 'Preparing your order', 'time': 'In progress'},
      {'status': OrderStatus.OUT_FOR_DELIVERY, 'label': 'Out for delivery', 'time': 'Pending'},
      {'status': OrderStatus.DELIVERED, 'label': 'Delivered', 'time': 'Pending'},
    ];

    final currentIdx = currentStatus.stepIndex;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isDone = index <= currentIdx;
          final isCurrent = index == currentIdx;

          Color dotColor = AppColors.cardBorder;
          if (isDone) dotColor = AppColors.green;
          if (isCurrent) dotColor = AppColors.accent;

          return SizedBox(
            height: index == steps.length - 1 ? 30 : 54,
            child: Stack(
              children: [
                if (index < steps.length - 1)
                  Positioned(
                    left: 11.5,
                    top: 24,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: isDone && index < currentIdx ? AppColors.green : AppColors.cardBorder,
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          isDone ? '✓' : (isCurrent ? '●' : ''),
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['label'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            fontWeight: isDone || isCurrent ? FontWeight.w700 : FontWeight.w600,
                            color: isDone || isCurrent ? AppColors.text : AppColors.muted,
                          ),
                        ),
                        Text(
                          step['time'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 10.5,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
