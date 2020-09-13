class ErrorModel {
  ErrorModel(this.message);

  int status;

  String shortcode;

  String message;

  @override
  String toString() {
    return 'ErrorModel[status=$status, shortcode=$shortcode, message=$message, ]';
  }

  ErrorModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
      status = json['status'];
      shortcode = json['shortcode'];
      message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'shortcode': shortcode, 'message': message};
  }

  static List<ErrorModel> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ErrorModel>()
        : json.map((value) => new ErrorModel.fromJson(value)).toList();
  }

  static Map<String, ErrorModel> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ErrorModel>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new ErrorModel.fromJson(value));
    }
    return map;
  }
}
