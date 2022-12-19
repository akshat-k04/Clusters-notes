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
      idf:map["idOfEveryNote"], // thing in "" are same as in backend
      useridf:map["email"],
      titlef:map["title"],
      contentf:map["content"],
      dateAddedf:DateTime.tryParse(map["dateadded"]),
    );
  }
  Map<String,dynamic> toMap(){
    return {
      "idOfEveryNote":idf ,
      "email":useridf,
      "title":titlef,
      "content":contentf ,
      "dateadded":dateAddedf!.toIso8601String(),
    };
  }

}
