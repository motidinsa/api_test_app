class ServerResponse {
  String? name;
  String? job;
  String? id;
  String? createdAt;

  ServerResponse.fromJson(Map<String, dynamic> json,bool? isUpdate) {
    name = json['name'];
    job = json['job'];
    id = json['id'];
    createdAt = isUpdate==true?json['updatedAt']:json['createdAt'];
  }
}
