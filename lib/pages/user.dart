import 'package:flutter/material.dart';

class model {
  String? title  ;
  String? des ;
  String? id ;

  model({required this.title , required this.des , this.id});

  Map<String,dynamic>toJson(){
    return{
      title! :"title" ,
      des! : "des" ,
      id! :"id"
    };
  }
  fromJson(json){
     return{
       title : json['title'],
       des :json['des'],
       id:json['id']
     };
  }

}