import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    super.key, required this.constrains,
  });
final BoxConstraints constrains;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '220 mi',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        const Text(
          '62 %',
          style: TextStyle(fontSize: 24),
        ),
        Spacer(),
        Text(
          'Charging'.toUpperCase(),
          style: TextStyle(fontSize: 24),
        ),
        const Text(
          '18 min remaining ',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: constrains.maxHeight * 0.14),
        const DefaultTextStyle(
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('22 mi/hr'),
              Text(
                  '                                         232 v')
            ],
          ),
        ),
        SizedBox(height: defaualtpadding)
      ],
    );
  }
}
