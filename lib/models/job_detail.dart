class JobDetail {
  String? title;
  String? description;
  String? length;
  String? value;
  String? date;
  String? imageURL;
  String? type;
  String? distance;
  String? applicants;

  JobDetail({
    this.title,
    this.description,
    this.length,
    this.value,
    this.date,
    this.imageURL,
    this.type,
    this.distance,
    this.applicants,
  });

  JobDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    length = json['length'];
    value = json['value'];
    date = json['date'];
    imageURL = json['imageURL'];
    type = json['type'];
    distance = json['distance'];
    applicants = json['applicants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['length'] = this.length;
    data['value'] = this.value;
    data['date'] = this.date;
    data['imageURL'] = this.imageURL;
    data['type'] = this.type;
    data['distance'] = this.distance;
    data['applicants'] = this.applicants;
    return data;
  }
}
