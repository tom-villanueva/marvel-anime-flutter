import 'package:actividad_05/routes.dart';
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
          IconButton(
            icon: const Icon(Icons.arrow_forward), 
            onPressed: () => Navigator.pushNamed(context, ROUTE_NAMES[label])
          )
        ],
      ),
    );
  }

}