import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatelessWidget {
  final String title;
  final String address;
  final VoidCallback onEdit;
  final VoidCallback? onTap;

  const DeliveryAddressCard({
    Key? key,
    required this.title,
    required this.address,
    required this.onEdit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // --- Title Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Row(
                    children: const [
                      Icon(Icons.edit, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "تعديل",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // --- Address Row ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.black54),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    address,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
