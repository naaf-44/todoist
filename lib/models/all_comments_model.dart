class AllCommentsModel {
  String? content;
  String? id;
  String? postedAt;
  Null? projectId;
  String? taskId;
  Attachment? attachment;

  AllCommentsModel(
      {this.content,
        this.id,
        this.postedAt,
        this.projectId,
        this.taskId,
        this.attachment});

  AllCommentsModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    postedAt = json['posted_at'];
    projectId = json['project_id'];
    taskId = json['task_id'];
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['posted_at'] = this.postedAt;
    data['project_id'] = this.projectId;
    data['task_id'] = this.taskId;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    return data;
  }
}

class Attachment {
  String? fileName;
  String? fileType;
  String? fileUrl;
  String? resourceType;

  Attachment({this.fileName, this.fileType, this.fileUrl, this.resourceType});

  Attachment.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    resourceType = json['resource_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    data['resource_type'] = this.resourceType;
    return data;
  }
}
