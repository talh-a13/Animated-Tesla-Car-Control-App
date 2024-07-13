import 'package:flutter/material.dart';
import 'package:flutter_animated_tesla_app/Model/Typespis.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';
class typepsicard extends StatelessWidget {
  const typepsicard({
    super.key,
    required this.isBottomTwotyre,
    required this.tyrepsi,
  });
  final bool isBottomTwotyre;
  final Typepsi tyrepsi;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaualtpadding),
      decoration: BoxDecoration(
          color: tyrepsi.isLowpressure
              ? secondaryColor.withOpacity(0.1)
              : Colors.white10,
          border: Border.all(
              color: tyrepsi.isLowpressure ? secondaryColor : primaryColor,
              width: 2),
          borderRadius: BorderRadius.circular(6)),
      child: isBottomTwotyre
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lowpressureText(context),
                Spacer(),
                psiMethod(context, psi: tyrepsi.psi.toString()),
                const SizedBox(
                  height: defaualtpadding,
                ),
                Text(
                  '${tyrepsi.temp}\u2103',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiMethod(context, psi: tyrepsi.psi.toString()),
                const SizedBox(
                  height: defaualtpadding,
                ),
                Text(
                  '${tyrepsi.temp}\u2103',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                lowpressureText(context),
              ],
            ),
    );
  }

  Column lowpressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Low'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          'Pressure'.toUpperCase(),
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Text psiMethod(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
          text: psi,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
          children: [
            TextSpan(text: 'psi', style: TextStyle(fontSize: 24)),
          ]),
    );
  }
}
