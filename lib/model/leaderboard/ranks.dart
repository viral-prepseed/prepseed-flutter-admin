class getRanks {
  bool? success;
  int? rank;
  dynamic percentile;
  int? rating;

  getRanks({this.success, this.rank, this.percentile, this.rating});

  getRanks.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    rank = json['rank'];
    percentile = json['percentile'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['rank'] = this.rank;
    data['percentile'] = this.percentile;
    data['rating'] = this.rating;
    return data;
  }
}
