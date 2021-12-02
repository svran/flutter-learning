import 'package:flutter/material.dart';
import 'package:svran_flutter_study/game/providers/model/game_card.dart';

class SvranGameCardWidget extends StatelessWidget {
  final SvranGameCard card;

  const SvranGameCardWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData ic;
    Color icColor;
    String valueTxt;
    if (card.cardType == SvranGameCardType.kill) {
      ic = Icons.download;
      icColor = Colors.red;
      valueTxt = "(${card.min}~${card.max})";
    } else if (card.cardType == SvranGameCardType.reply) {
      ic = Icons.upload;
      icColor = Colors.green;
      valueTxt = "(${card.min}~${card.max})";
    } else {
      ic = Icons.help_outline;
      icColor = Colors.blue;
      valueTxt = "";
    }
    return Center(
      child: Card(
        color: Colors.white.withOpacity(0.5),
        elevation: 3,
        child: SizedBox(
          width: 100,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Text(card.name),
              Align(child: Text(card.cardDesc, style: TextStyle(fontSize: 12)), alignment: Alignment.center),
              Align(child: Icon(ic, color: icColor, size: 14), alignment: Alignment.bottomLeft),
              Align(child: Text(valueTxt, style: TextStyle(fontSize: 12)), alignment: Alignment.bottomRight),
            ]),
          ),
        ),
      ),
    );
  }
}
