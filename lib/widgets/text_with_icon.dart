import 'package:actividad_05/widgets/text_with_icon_implementation.dart';
import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextWithIconImplementation(label: label);
  }
}
