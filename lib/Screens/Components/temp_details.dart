import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/temp_button.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
import 'package:flutter_animated_tesla_app/Screens/homecontroller.dart';
class Tempdetails extends StatelessWidget {
  const Tempdetails({
    super.key,
    required homecontroller controller,
  }) : _controller = controller;

  final homecontroller _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaualtpadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBin(
                  isActive: _controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Cool',
                  press: _controller.updateCoolSelectedTab,
                ),
                SizedBox(
                  width: defaualtpadding,
                ),
                TempBin(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: 'assets/icons/heatShape.svg',
                  title: 'Heat',
                  activeColor: Colors.red,
                  press: _controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_drop_up,
                    size: 48,
                  )),
                  const Text(
            '29' + '\u2103',
            style: TextStyle(fontSize: 89),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 48,
              )),
         
            ],
          ),
           const Spacer(),
          const Text('CURRENT TEMPERATURE'),
          const SizedBox(
            height: defaualtpadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INSIDE'.toUpperCase(),
                  ),
                  Text(
                    '20' + '\u2103',
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              SizedBox(
                width: defaualtpadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OUTSIDE'.toUpperCase(),
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '35' + '\u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
