import 'package:flutter/material.dart';


class ConversationCard extends StatelessWidget {
  final Function onTap;
  const ConversationCard({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ClipOval(
        child: Image.network('https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Nain Acero',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
            ),
          ),
          Text(
            '12:34 am',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          )
        ],
      ),
      subtitle: Text('Nuevo Mensaje'),
    );
  }
}