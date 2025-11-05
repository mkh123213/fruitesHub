import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  Counter({
    super.key,
    required this.onClickIncrease,
    required this.onClickDecrese,
    required this.onChangedvalue,
    required this.value,
  });
  final VoidCallback onClickIncrease;
  final VoidCallback onClickDecrese;
  final ValueChanged<int> onChangedvalue;
  int value;
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  bool isClickedAdd = false;
  bool isClickedremove = false;

  @override
  Widget build(BuildContext context) {
    // widget.onChangedvalue(value);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: isClickedAdd
              ? AppColors.primaryColor
              : Colors.transparent,
          child: GestureDetector(
            onTap: () {
              widget.value++;

              isClickedAdd = true;
              isClickedremove = false;
              widget.onClickIncrease();

              setState(() {});
            },
            child: Icon(
              Icons.add,
              color: isClickedAdd ? AppColors.white : AppColors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.value.toString()),
        ),
        CircleAvatar(
          backgroundColor: isClickedremove
              ? AppColors.primaryColor
              : Colors.transparent,
          child: GestureDetector(
            onTap: () {
              widget.value == 0 ? null : widget.value--;
              widget.onClickDecrese();
              isClickedremove = true;
              isClickedAdd = false;

              setState(() {});
            },
            child: Icon(
              Icons.remove,
              color: isClickedremove ? AppColors.white : AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
