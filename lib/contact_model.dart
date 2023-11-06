class ContactModel {
  int id;
  String name;
  String phone;

  ContactModel({required this.name, required this.phone, this.id = 0});

  Map<String,Object> toJson()=>{
    "name":name,
    "phone":phone,
  };
}
