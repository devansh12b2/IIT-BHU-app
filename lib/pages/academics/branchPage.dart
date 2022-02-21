import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/academics/branch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iit_app/ui/snackbar.dart';

// ignore: must_be_immutable
class BranchPage extends StatefulWidget {
  //const BranchPage({ Key? key }) : super(key: key);
  final Branch branch;
  BranchPage(this.branch);

  @override
  _BranchPageState createState() => _BranchPageState(branch);
}

class _BranchPageState extends State<BranchPage> {
  final Branch branch;
  _BranchPageState(this.branch);
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF3F9FF);


  String _url = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            InkWell(
                onTap: ()async{
                  showSnackBar(context,'Fetching Details ...',primaryColor,secondaryColor);
                  try{
                    final response = await getRequiredAcademicInfo(0, branch.tag);

                    _url = response.body['resource_url'];

                    openUrl(_url);
                  }catch(e){
                    showSnackBar(context, 'Could not fetch the details!', Colors.white, Colors.red);
                  }

                },
                splashColor: primaryColor,
                borderRadius: BorderRadius.circular(15),
                child: academicInfo('Study Materials', 'assets/academics/studyMaterials.png')),
            SizedBox(height: 40,),
            InkWell(
                onTap: ()async{
                  showSnackBar(context,'Fetching Details ...',primaryColor,secondaryColor);
                  try{
                    final response = await getRequiredAcademicInfo(1, branch.tag);
                    _url = response.body['schedule_url'];
                    openUrl(_url);
                  }catch(e){
                    showSnackBar(context, 'Could not fetch the details!', Colors.white, Colors.red);
                  }
                },
                splashColor: primaryColor,
                borderRadius: BorderRadius.circular(15),
                child: academicInfo('Academic Schedule', 'assets/academics/academicShedule.png')),
            SizedBox(height: 40,),
            InkWell(
                onTap: ()async{
                  showSnackBar(context,'Fetching Details ...',primaryColor,secondaryColor);
                  try{
                    final response = await getRequiredAcademicInfo(2, branch.tag);
                    _url = response.body['profs_and_HODs'];
                    openUrl(_url);
                  }catch(e){
                    showSnackBar(context, 'Could not fetch the details!', Colors.white, Colors.red);
                  }
                },
                splashColor: primaryColor,
                borderRadius: BorderRadius.circular(15),
                child: academicInfo('Profs and H.O.D.s', 'assets/academics/profs.png')),

               
          ],
        ),
      ),
    );
  }


  getRequiredAcademicInfo(infoIndex , dept)async{
    //TODO:Get the users YearOfJoining from Email .
    //TODO:if the user is guest .. ask to login first.
    if (infoIndex == 0)
      return await AppConstants.service.getStudyMaterials('$dept');
    else if (infoIndex == 1)
      return await AppConstants.service.getAcademicSchedule('$dept', '2019');
    else
      return await AppConstants.service.getProfsAndHODs('$dept');
  }
  openUrl(String url)async{
    if(!await launch(url)) showSnackBar(context, 'Could not fetch the details!', Colors.white, Colors.red);
    // if(await canLaunch(url)){
    //   launch(url);
    // }else{
    //   showSnackBar(context, 'Could not fetch the details!', Colors.white, Colors.red);
    // }
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
            branch.branchName,
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 23,
            ),
          ),

          SizedBox(width: 25,),

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
                    : NetworkImage(
                    AppConstants.currentUser.photo_url),

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

  void showSnackBar(BuildContext context,String text,Color textColor,Color bgColor) {
    final snackBar = new SnackBar(
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text,style: TextStyle(
              color: textColor,
            fontWeight: FontWeight.w400
          ),),
        ],
      ),
      backgroundColor: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Container academicInfo(String reqInfo,String img) {

    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 3,
            shadowColor: containerColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.height * 0.17,
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(15)),

              child: Image.asset(img,scale: 0.5,),

            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            reqInfo,
            style: GoogleFonts.lato(

                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),

          ),
        ],
      ),
    );
  }
}
