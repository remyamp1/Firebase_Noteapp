import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_noteapp/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class NoteApp extends StatefulWidget {
  

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  late Box box;
   List<Map<String,String>> itemList=[];

  TextEditingController titleController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  Stream<QuerySnapshot>? NoteStrem;

  getontheload() async{
    NoteStrem=await Database.getNoteitems();
    setState(() {});
  }
 
  @override
  void initState(){
    super.initState();
     box=Hive.box("MyBox");
     final storedItems=box.get('itemsList');
     if(storedItems is List){
      itemList=List<Map<String,String>>.from(
        storedItems.map((e)=>Map<String,String>.from(e))
      );
     }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTEAPP'),backgroundColor: Colors.blue,
      ),
body: 
GridView.builder(
  itemCount: itemList.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
 itemBuilder: (
  
  context,index){
  final item=itemList[index];
  return Container(
    height: 300,
    width: double.infinity,
    child: Column(
      children: [
        Text(item['title']?? 'No title'),
        Text(item['category']?? 'No category'),
        Text(item['description']?? 'No description'),
        Text(item['date']?? 'No date')
      ],
    ),
  );
 }),

floatingActionButton: FloatingActionButton(onPressed: (){
      showModalBottomSheet(context: context, builder: (BuildContext context){
        
        return Container(
height: 400,
width: double.infinity,
child: Padding(
  padding: const EdgeInsets.all(15.0),
  child: Column(
    children: [
      SizedBox(
        height: 50,
        width: 300,
        child: TextField(
          controller: titleController,
          decoration: InputDecoration(border: OutlineInputBorder(),label:Text('Title')),)),
      SizedBox(height: 10),
       SizedBox(
        height:50,
        width: 300,
        child: TextField(
          controller: categoryController,
          decoration: InputDecoration(border: OutlineInputBorder(),label:Text('Category')),)),
      SizedBox(height: 10),
       SizedBox(
        height: 50,
        width: 300,
        child: TextField(
          controller: descriptionController,
          decoration: InputDecoration(border: OutlineInputBorder(),label:Text('Description')),)),
      SizedBox(height: 10),
       SizedBox(
        height: 50,
        width: 300,
        child: TextField(
          controller: dateController,
          decoration: InputDecoration(border: OutlineInputBorder(),label:Text('Date')),)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              setState(() {
                itemList.add({'title':titleController.text,
                'category':categoryController.text,
                'description':descriptionController.text,
                'date':dateController.text,

              });
              box.put(
                'itemsList',
                 itemList.map((e)=>Map<String,dynamic>.from(e)
                ).toList());
            });
              titleController.clear();
              categoryController.clear();
              descriptionController.clear();
              dateController.clear();
            Navigator.pop(context);
            },

             child: Text('Add')
             ),
            SizedBox(width: 5),
              TextButton(onPressed: (){
                Navigator.of(context);
              }, child: Text('Cancle')),
          ],
        )
      
    ],
  ),
),

        );
      });
    },
    child: Icon(Icons.add),),
    );
  }
}