class MetaModel {
  late int currentPage;
  int? from;
  late int lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaModel(
      {required this.currentPage,
      this.from,
      required this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  MetaModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
