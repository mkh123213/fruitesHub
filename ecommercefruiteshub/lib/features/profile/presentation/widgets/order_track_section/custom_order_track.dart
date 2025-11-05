import 'package:flutter/material.dart';

class OrderTrackWidget extends StatelessWidget {
  final String orderNumber;
  final DateTime orderDate;
  final double price;
  final int itemCount;

  const OrderTrackWidget({
    Key? key,
    required this.orderNumber,
    required this.orderDate,
    required this.price,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.badge, color: Colors.green), // Package Icon
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'طلب رقم: #$orderNumber',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'تم الطلب: ${orderDate.toLocal()}'.split(
                    ' ',
                  )[0], // Just the date
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  'عدد الطلبات: $itemCount',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  '${price.toStringAsFixed(2)} جنيه',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
