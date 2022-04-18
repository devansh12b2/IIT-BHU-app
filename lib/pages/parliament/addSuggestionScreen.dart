import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/external_libraries/spin_kit.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';

class AddSuggestion extends StatefulWidget {
  //const AddSuggestion({Key? key}) : super(key: key);

  @override
  _AddSuggestionState createState() => _AddSuggestionState();
}

class _AddSuggestionState extends State<AddSuggestion> {
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF4F9FF);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool addingSuggestion = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: ListView(
          children: [
            SizedBox(height: 20,),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                focusColor: primaryColor,
                labelText: "Title"
              ),
            ),
            SizedBox(height: 15,),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  focusColor: primaryColor,
                  labelText: "Description"
              ),
            ),
            SizedBox(height: 40,),
            Center(
              child: GestureDetector(
                onTap: (){
                  createSuggestion();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: (addingSuggestion)?SpinKitThreeBounce(
                        color: primaryColor,
                        size: 25,
                      ):Text(
                        "Add Suggestion",
                        style: GoogleFonts.lato(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  createSuggestion()async{
    setState(() {
      addingSuggestion = true;
    });

    var result = await AppConstants.service.createParliamentSuggestion(
      AppConstants.djangoToken,
      CreateSuggestionPost(
            (b) => b
          ..title = titleController.text
          ..description = descriptionController.text
      ),
    );

    print("The result is - ${result.statusCode}");
    setState(() {
      addingSuggestion = false;
    });
    Navigator.pop(context);
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: secondaryColor,
        iconSize: 30,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Suggestion',
            style: GoogleFonts.lato(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 21,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (AppConstants.currentUser == null ||
                    AppConstants.isGuest == true ||
                    AppConstants.currentUser.photo_url == '')
                    ? AssetImage('assets/guest.png')
                    : NetworkImage(AppConstants.currentUser.photo_url),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: Colors.blueGrey, width: 2.0),
            ),
          )
        ],
      ),
    );
  }
}
