import 'package:contact/bloc.dart';
import 'package:contact/contact_model.dart';
import 'package:contact/db_heleper.dart';
import 'package:flutter/material.dart';

class ContactDialog{
  static void showAddContactDialog(BuildContext context){
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.white,
        context: context, builder: (context){
      return Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                controller: controllerPhone,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: (){
                DataBaseHelper base = DataBaseHelper();
                ContactModel item = ContactModel(
                    name: controllerName.text,
                    phone: controllerPhone.text);
                base.saveContact(item);
                contactBloc.getBaseAll();
                Navigator.pop(context);
              }, child: Text("Saqlash"))
            ],
          ),
        ),
      );
    });
  }
}