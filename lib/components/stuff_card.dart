import 'dart:io';

import 'package:flutter/material.dart';

import 'package:borrowed_stuff/models/stuff.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class StuffCard extends StatelessWidget {
  final Stuff stuff;
  final Function onEdit;
  final Function onDelete;

  StuffCard({
    Key key,
    this.stuff,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSlidableStuffCard();
  }

  _buildStuffCard(Stuff stuff) {
    return Card(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        child: ListTile(
        title: Text(stuff.description),
        subtitle: Text(stuff.contactName),
        
        leading: CircleAvatar(
          child: stuff.photoExist
              ? null
              : Text('${stuff.description.toUpperCase()[0]}'),
          backgroundImage:
              stuff.photoExist ? FileImage(File(stuff.photoPath)) : null,
        ),
        trailing: Text(stuff.loadDateString),
      ),
    );
  }

  _buildSlidableStuffCard() {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildStuffCard(stuff),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: onEdit,
        ),
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: onDelete,
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Ligar',
          color: Colors.green,
          icon: Icons.phone,
          onTap: () => _makePhoneCall('tel:'+stuff.phone),
        
        ),
      ]
    );
  }
}

 Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }