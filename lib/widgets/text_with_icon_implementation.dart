import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWithIconImplementation extends StatelessWidget {
  const TextWithIconImplementation({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [          
          Text(
            label, 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
            ),
          Icon(Icons.arrow_forward, size: 30)
        ],
      ),
    );
  }

}