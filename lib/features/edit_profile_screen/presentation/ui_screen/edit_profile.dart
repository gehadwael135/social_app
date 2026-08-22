import 'package:flutter/material.dart';
import 'package:social_app/core/utils/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  TextEditingController nameControler = TextEditingController();
  TextEditingController bioControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 25, fontWeight: .w500),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "UPDATE",
              style: TextStyle(fontWeight: .w600, color: Colors.blue,fontSize: 18),
            ),
          ),
        ],
      ),
     
      body: Column(
        children: [
          Stack(
            alignment: .bottomCenter,
            children: [
              Stack(alignment: .topEnd,
                children: [
                   Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                  child: Image.network(
                    "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                    fit: BoxFit.cover,
                    height: 160,
                    width: .infinity,
                  ),
                ),
              ),
         Transform.translate(offset: Offset(-20, 20),
          child:  CircleAvatar(backgroundColor: Colors.blue,radius: 20,
            child:IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,size: 20,)) ,)
          ,)
              ],)
             ,Stack(alignment: .bottomEnd,
              children: [
               Transform.translate(
                offset: Offset(0, 30),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                    ),
                  ),
                ),
              ),
             Transform.translate(offset: Offset(-5, 27),
          child:  CircleAvatar(backgroundColor: Colors.blue,radius: 20,
            child:IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,size: 20,)) ,)
          ,)
             ],)
             
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextField(
              text: "e.g:Gehad Wael",
              icon: Icons.people,
              label: "Name",
              controller: nameControler,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: CustomTextField(
              text: "Write Your Bio ...",
              icon: Icons.border_color_outlined,
              label: "Bio",
              controller: bioControler,
            ),
          ),
        ],
      ),
    );
  }
}
