class GetTaskModel {
  String? creatorId;
  String? createdAt;
  String? assigneeId;
  String? assignerId;
  int? commentCount;
  bool? isCompleted;
  String? content;
  String? description;
  Due? due;
  String? duration;
  String? id;
  List<String>? labels;
  int? order;
  int? priority;
  String? projectId;
  String? sectionId;
  String? parentId;
  String? url;

  GetTaskModel(
      {this.creatorId,
      this.createdAt,
      this.assigneeId,
      this.assignerId,
      this.commentCount,
      this.isCompleted,
      this.content,
      this.description,
      this.due,
      this.duration,
      this.id,
      this.labels,
      this.order,
      this.priority,
      this.projectId,
      this.sectionId,
      this.parentId,
      this.url});

  GetTaskModel.fromJson(Map<String, dynamic> json) {
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    assigneeId = json['assignee_id'];
    assignerId = json['assigner_id'];
    commentCount = json['comment_count'];
    isCompleted = json['is_completed'];
    content = json['content'];
    description = json['description'];
    due = json['due'] != null ? new Due.fromJson(json['due']) : null;
    duration = json['duration'];
    id = json['id'];
    labels = json['labels'].cast<String>();
    order = json['order'];
    priority = json['priority'];
    projectId = json['project_id'];
    sectionId = json['section_id'];
    parentId = json['parent_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator_id'] = this.creatorId;
    data['created_at'] = this.createdAt;
    data['assignee_id'] = this.assigneeId;
    data['assigner_id'] = this.assignerId;
    data['comment_count'] = this.commentCount;
    data['is_completed'] = this.isCompleted;
    data['content'] = this.content;
    data['description'] = this.description;
    if (this.due != null) {
      data['due'] = this.due!.toJson();
    }
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['labels'] = this.labels;
    data['order'] = this.order;
    data['priority'] = this.priority;
    data['project_id'] = this.projectId;
    data['section_id'] = this.sectionId;
    data['parent_id'] = this.parentId;
    data['url'] = this.url;
    return data;
  }
}

class Due {
  String? date;
  bool? isRecurring;
  String? datetime;
  String? string;
  String? timezone;

  Due({this.date, this.isRecurring, this.datetime, this.string, this.timezone});

  Due.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isRecurring = json['is_recurring'];
    datetime = json['datetime'];
    string = json['string'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['is_recurring'] = this.isRecurring;
    data['datetime'] = this.datetime;
    data['string'] = this.string;
    data['timezone'] = this.timezone;
    return data;
  }
}
