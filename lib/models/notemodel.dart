class Notemodel{
  // userid will be a phone number
  String? idf ;
  String? useridf ;
  String? titlef ;
  String? contentf ;
  DateTime? dateAddedf ;
  Notemodel({this.idf , this.useridf ,this.titlef , this.contentf ,this.dateAddedf});
  factory Notemodel.fromMap(Map<String, dynamic>map){
    return Notemodel(
      idf:map["id"], // thing in "" are same as in backend
      useridf:map["userid"],
      titlef:map["title"],
      contentf:map["content"],
      dateAddedf:DateTime.tryParse(map["dateAdded"]),
    );
  }
  Map<String,dynamic> toMap(){
    return {
      "id":idf ,
      "userid":useridf,
      "title":titlef,
      "content":contentf ,
      "dateadded":dateAddedf!.toIso8601String(),
    };
  }

}
