class ToDoListModel {
  String? sId;
  String? userid;
  String? title;
  String? description;
  bool? status;
  int? iV;

  ToDoListModel(
      {this.sId,
      this.userid,
      this.title,
      this.description,
      this.status,
      this.iV});

  ToDoListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}
