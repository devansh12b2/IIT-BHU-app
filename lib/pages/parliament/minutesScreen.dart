import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/external_libraries/spin_kit.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/parliament/addMinutes.dart';

class MinutesScreen extends StatefulWidget {
  //const MinutesScreen({Key? key}) : super(key: key);

  @override
  _MinutesScreenState createState() => _MinutesScreenState();
}

class _MinutesScreenState extends State<MinutesScreen>
    with SingleTickerProviderStateMixin {
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF4F9FF);

  Map<String, bool> visibility = {};
  AnimationController controller;

  List<List> minutes = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
    getMinutes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: (isLoading)
          ? Center(
              child: LoadingCircle,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ...minutes
                      .map((e) =>
                          showCommitteeMinutes(size, e[0]['committee'], e))
                      .toList(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
      floatingActionButton:
          (AppConstants.currentUser.can_add_parliament_details != null &&
                  AppConstants.currentUser.can_add_parliament_details == true)
              ? Container(
                  height: 50,
                  width: 50,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>AddMinutes())
                        ).then((value){
                          getMinutes();
                        });
                      },
                      backgroundColor: secondaryColor,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
    );
  }

  getMinutes() async {
    setState(() {
      isLoading = true;
    });
    final res = await AppConstants.service.getParliamentUpdates();
    print("The Updates are - ${res.body}");
    List response = res.body;
    int numOfCommittees = 0;
    response.forEach((element) {
      if (element['committee'] > numOfCommittees)
        numOfCommittees = element['committee'];
    });
    minutes = [];
    for (int i = 0; i < numOfCommittees; i++) minutes.add([]);

    response.forEach((e) {
      Map<String, dynamic> data = {
        "committee": "Committee ${e['committee']}",
        "id": e['id'],
        "title": e['title'],
        "date": e['date'],
        "description": e['description']
      };
      minutes[e['committee'] - 1].add(data);
    });
    setState(() {
      isLoading = false;
    });
  }

  showCommitteeMinutes(Size size, committeeName, List committeeMinutes) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              visibility[committeeName] = (visibility[committeeName] == null)
                  ? true
                  : !visibility[committeeName];
            });
          },
          radius: 2 * size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 15, bottom: 15),
                child: Text(
                  committeeName,
                  style: GoogleFonts.lato(
                      color: primaryColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
              !(visibility[committeeName] == false ||
                      visibility[committeeName] == null)
                  ? Icon(Icons.keyboard_arrow_right_rounded)
                  : Icon(Icons.keyboard_arrow_down_rounded)
            ],
          ),
        ),
        !(visibility[committeeName] == false ||
                visibility[committeeName] == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...committeeMinutes
                      .map((e) => minuteDetails(size, e))
                      .toList()
                ],
              )
            : Container(),
        //...committee1Minutes.map((e) => minuteDetails(size, e)).toList(),
      ],
    );
  }

  Widget minuteDetails(Size size, minute) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 0.95,
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: secondaryColor.withOpacity(0.5),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                minute['title'],
                style: GoogleFonts.lato(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                minute['description'] ?? "",
                style: GoogleFonts.lato(
                  color: primaryColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
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
            'Minutes',
            style: GoogleFonts.lato(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 23,
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
