class UserModel{
  String? userId;
  String? userName;
  String? Phone;
  String? email;

  UserModel({this.email,this.userId,this.userName,this.Phone});

  UserModel.fromJson(Map<String,dynamic> json){
    userId=json['userId'];
    userName=json['userName'];
    Phone=json['Phone'];
    email=json['email'];
  }
  Map <String ,dynamic> toMap(){
    return{
      'userId':userId,
      'userName':userName,
      'Phone':Phone,
      'email':email,
    };
  }
}