class FakeHadethModel {
  int? id;
  String? text;
  SubValid? subValid;
  SubValid? ruling;

  FakeHadethModel({this.id, this.text, this.subValid, this.ruling});

  FakeHadethModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    subValid = json['sub_valid'] != null
        ? SubValid.fromJson(json['sub_valid'])
        : null;
    ruling =
        json['ruling'] != null ?  SubValid.fromJson(json['ruling']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    if (this.subValid != null) {
      data['sub_valid'] = this.subValid!.toJson();
    }
    if (this.ruling != null) {
      data['ruling'] = this.ruling!.toJson();
    }
    return data;
  }
}

class SubValid {
  int? id;
  String? text;

  SubValid({this.id, this.text});

  SubValid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}