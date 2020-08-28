// To parse this JSON data, do
//
//     final searchItem = searchItemFromJson(jsonString);

import 'dart:convert';

SearchItem searchItemFromJson(String str) =>
    SearchItem.fromJson(json.decode(str));

String searchItemToJson(SearchItem data) => json.encode(data.toJson());

class SearchItem {
  SearchItem({
    this.itemList,
    this.prevPage,
    this.curPage,
    this.nextPage,
    this.search,
    this.name,
    this.logo,
  });

  List<ItemList> itemList;
  bool prevPage;
  int curPage;
  bool nextPage;
  String search;
  String name;
  dynamic logo;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
        itemList: List<ItemList>.from(
            json["item_list"].map((x) => ItemList.fromJson(x))),
        prevPage: json["prev_page"],
        curPage: json["cur_page"],
        nextPage: json["next_page"],
        search: json["search"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "item_list": List<dynamic>.from(itemList.map((x) => x.toJson())),
        "prev_page": prevPage,
        "cur_page": curPage,
        "next_page": nextPage,
        "search": search,
        "name": name,
        "logo": logo,
      };
}

class ItemList {
  ItemList({
    this.fileId,
    this.media,
    this.mimeType,
    this.insight,
    this.date,
    this.size,
    this.url,
  });

  int fileId;
  bool media;
  String mimeType;
  String insight;
  DateTime date;
  String size;
  dynamic url;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        fileId: json["file_id"],
        media: json["media"],
        mimeType: json["mime_type"],
        insight: json["insight"],
        date: DateTime.parse(json["date"]),
        size: json["size"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "media": media,
        "mime_type": mimeType,
        "insight": insight,
        "date": date.toIso8601String(),
        "size": size,
        "url": url,
      };
}
