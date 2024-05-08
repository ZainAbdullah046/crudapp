class ModelCrud {
  String? sId;
  String? taskName;
  String? taskDescription;
  String? taskDueDate;
  String? taskPriority;

  ModelCrud(
      {this.sId,
      this.taskName,
      this.taskDescription,
      this.taskDueDate,
      this.taskPriority});

  ModelCrud.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    taskDueDate = json['taskDueDate'];
    taskPriority = json['taskPriority'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['taskName'] = this.taskName;
    data['taskDescription'] = this.taskDescription;
    data['taskDueDate'] = this.taskDueDate;
    data['taskPriority'] = this.taskPriority;
    return data;
  }
}
