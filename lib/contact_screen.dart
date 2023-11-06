import 'package:contact/add_contact_dialog.dart';
import 'package:contact/bloc.dart';
import 'package:contact/contact_model.dart';
import 'package:contact/db_heleper.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    contactBloc.getBaseAll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<List<ContactModel>>(
        stream: contactBloc.getBaseStream,
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
              itemBuilder: (ctx,index){
                return GestureDetector(
                  onLongPress: (){
                    DataBaseHelper base = DataBaseHelper();
                    base.deleteBase(snapshot.data![index].id);
                    contactBloc.getBaseAll();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.green,
                    child: Column(
                      children: [
                        Text(snapshot.data![index].name),
                        Text(snapshot.data![index].id.toString()),
                        Text(snapshot.data![index].phone),
                      ],
                    ),
                  ),
                );
              });
        }
        return Container(color: Colors.red,);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ContactDialog.showAddContactDialog(context);
        },
      ),
    );
  }
}
