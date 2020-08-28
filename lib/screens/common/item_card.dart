import 'package:Teledax/screens/common/icon_selector.dart';
import 'package:Teledax/style/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  var item;
  var chatId;
  ItemCard({@required this.item, this.chatId});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashColor: accents,
          onTap: () => Navigator.pushNamed(context, "/fileinfo",
              arguments: {"item": item, "chatid": chatId}),
          child: ListTile(
            hoverColor: Colors.amberAccent,
            isThreeLine: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: autoIconSelector(item.mimeType),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Text(
                item.insight,
                style: TextStyle(color: Colors.white),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.mimeType,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.size,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text(
                        item.date.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
