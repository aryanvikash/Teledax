import 'package:Teledax/screens/common/icon_selector.dart';
import 'package:Teledax/screens/common/reuseable_items.dart';
import 'package:Teledax/style/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ItemCard extends StatelessWidget {
  var item;
  var chatId;
  var baseurl;
  ItemCard(
      {@required this.item, @required this.chatId, @required this.baseurl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: accents,
      highlightColor: Colors.white30,
      onTap: () => Navigator.pushNamed(context, "/fileinfo",
          arguments: {"item": item, "chatid": chatId, "baseurl": baseurl}),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: Padding(
              padding: const EdgeInsets.only(left: 3, top: 20),
              child: autoIconSelector(item.mimeType),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                item.insight,
                style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        item.mimeType,
                        style: TextStyle(
                          color: fontColor,
                        ),
                      ),
                      Text(
                        item.size,
                        style: TextStyle(color: fontColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100, top: 10),
                    child: Text(
                      DateFormat('hh:mm:a - dd-MM-yy').format(item.date),
                      style: TextStyle(
                          color: fontColor, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            trailing: IconButton(
                tooltip: "open in external apps",
                icon: Icon(
                  MdiIcons.openInApp,
                  color: SecondaryColor,
                ),
                onPressed: () async => await showAutoIntent(
                    url: "$baseurl/$chatId/${item.fileId}/download",
                    mimeType: item.mimeType)),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}
