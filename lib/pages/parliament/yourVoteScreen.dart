import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/external_libraries/spin_kit.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/parliament/addSuggestionScreen.dart';
import 'package:iit_app/ui/snackbar.dart';

class VoteScreen extends StatefulWidget {
  //const VoteScreen({Key? key}) : super(key: key);

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF4F9FF);

  List votes = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuggestions();
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
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(
                      'Suggestions',
                      style: GoogleFonts.lato(
                          color: primaryColor,
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...votes.map((e) => voteDetails(size, e)).toList(),
                ],
              ),
            ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>AddSuggestion())
              ).then((value) {
                getSuggestions();
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
      ),
    );
  }

  getSuggestions() async {
    setState(() {
      isLoading = true;
    });
    final res = await AppConstants.service.getParliamentSuggestions();

    print("The suggestions are - ${res.body}");
    List response = res.body;

    await getAllSuggestionDetails(response);
    setState(() {
      isLoading = false;
      print("votes are - $votes");
    });
  }

  Future<void> getAllSuggestionDetails(List<dynamic> response) async {
    votes = [];
    for(var i=0;i<response.length;i++){
      final suggestionDetails = await AppConstants.service
          .getParliamentSuggestionDetails(response[i]['id'], AppConstants.djangoToken);

      print("Suggestion details are - ${suggestionDetails.body}");
      votes.add(suggestionDetails.body);
      print("After adding votes = $votes");
    }
  }

  upvoteSuggestion(int id) async {
    final response = await AppConstants.service
        .upvoteASuggestion(id, AppConstants.djangoToken);
    print("Reponse of Upvoting - ${response.body} - ${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        var index = votes.indexWhere((element) => element['id'] == id);
        votes[index]['upvotes'] = votes[id - 1]['upvotes'] ?? 0;
        votes[index]['upvotes'] += 1;
      });
      showSnackBar(
          context, "Thanks for your feedback", Colors.white, Colors.green);
    } else
      showSnackBar(context, response.body['Error'], Colors.white, Colors.red);
  }

  downvoteSuggestion(int id) async {
    final response = await AppConstants.service
        .downvoteASuggestion(id, AppConstants.djangoToken);

    print("Reponse of DownVoting - ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        var index = votes.indexWhere((element) => element['id'] == id);
        votes[index]['downvotes'] = votes[id - 1]['downvotes'] ?? 0;
        votes[index]['downvotes'] += 1;
      });
      showSnackBar(
          context, "Thanks for your feedback", Colors.white, Colors.green);
    } else
      showSnackBar(context, response.body['Error'], Colors.white, Colors.red);
  }

  Widget voteDetails(Size size, vote) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                vote['title'],
                style: GoogleFonts.lato(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                vote['description'] ?? '',
                style: GoogleFonts.lato(
                  color: primaryColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                vote['date'].split('T')[0] ?? '',
                style: GoogleFonts.lato(
                  color: primaryColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      upvoteSuggestion(vote['id']);
                      print("Upvoted Successfully!");
                    },
                    child: Icon(
                      Icons.thumb_up_alt_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    vote['upvotes'].toString() == "null"
                        ? "0"
                        : vote['upvotes'].toString(),
                    style: GoogleFonts.lato(
                      color: primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      downvoteSuggestion(vote['id']);
                      print("Downvoted successfully");
                    },
                    child: Icon(
                      Icons.thumb_down_alt_rounded,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    vote['downvotes'].toString() == "null"
                        ? "0"
                        : vote['downvotes'].toString(),
                    style: GoogleFonts.lato(
                      color: primaryColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              )
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
            'Your Vote',
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
