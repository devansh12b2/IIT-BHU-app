import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/pages/academics/branch.dart';
import 'package:iit_app/pages/academics/branchPage.dart';

class AcademicsPage extends StatefulWidget {
  //const AcademicsPage({Key? key}) : super(key: key);

  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  Color primaryColor = Color(0xFF176EDE);
  Color bgColor = Color(0xFFFFFFFF);
  Color secondaryColor = Color(0xFFBBD9FF);
  Color containerColor = Color(0xFFF3F9FF);

  List branches = [
    //required tag for Architecture branch
    Branch(tag: 'none', branchName: 'Architecture', img: 'assets/academics/electrical.png'),
    Branch(tag: 'bce', branchName: 'Biochemical', img: 'assets/academics/electrical.png'),
    Branch(tag: 'bme', branchName: 'Biomedical', img: 'assets/academics/electrical.png'),
    Branch(tag: 'cer', branchName: 'Ceramic', img: 'assets/academics/electrical.png'),
    Branch(tag: 'che', branchName: 'Chemical', img: 'assets/academics/electrical.png'),
    Branch(tag: 'civ', branchName: 'Civil', img: 'assets/academics/electrical.png'),
    Branch(tag: 'cse', branchName: 'Computer Science', img: 'assets/academics/electrical.png'),
    Branch(tag: 'eee', branchName: 'Electrical', img: 'assets/academics/electrical.png'),
    Branch(tag: 'ece', branchName: 'Electronics', img: 'assets/academics/electrical.png'),
    Branch(tag: 'mat', branchName: 'Maths and Computing', img: 'assets/academics/electrical.png'),
    Branch(tag: 'mec', branchName: 'Mechanical', img: 'assets/academics/electrical.png'),
    Branch(tag: 'met', branchName: 'Metallurgy', img: 'assets/academics/electrical.png'),
    Branch(tag: 'min', branchName: 'Mining', img: 'assets/academics/electrical.png'),
    //required tag for Pharmaceutical branch.
    Branch(tag: 'none', branchName: 'Pharmaceutical', img: 'assets/academics/electrical.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return branchItem(branches[index]);
          },
          itemCount: branches.length,
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
            'Academics',
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

  // PreferredSize customAppBar(BuildContext context) {
  //   return PreferredSize(
  //     preferredSize: buildAppBar(context).preferredSize,
  //     child: Container(
  //       height: buildAppBar(context).preferredSize.height,
  //       color: primaryColor,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   icon: Icon(Icons.arrow_back_ios_rounded),
  //                   color: secondaryColor,
  //                   iconSize: 30,
  //                 ),
  //                 SizedBox(
  //                   width: 1,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(bottom: 0),
  //                   child: Text(
  //                     'Academics',
  //                     style: TextStyle(
  //                       color: secondaryColor,
  //                      // fontWeight: FontWeight.w300,
  //                       fontSize: 23,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 5),
  //               child: Container(
  //                 height: 35.0,
  //                 width: 35.0,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: (AppConstants.currentUser == null ||
  //                         AppConstants.isGuest == true ||
  //                         AppConstants.currentUser.photo_url == '')
  //                         ? AssetImage('assets/guest.png')
  //                         : NetworkImage(
  //                         AppConstants.currentUser.photo_url),
  //                     fit: BoxFit.fill,
  //                   ),
  //                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //                   border: Border.all(color: Colors.blueGrey, width: 2.0),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void openBranch(Branch branchData) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BranchPage(branchData)));
  }

  InkWell branchItem(Branch branchData) {
    return InkWell(
      onTap: () => openBranch(branchData),
      splashColor: primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
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
                child: Image.asset(branchData.img),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              branchData.branchName,
              style: GoogleFonts.lato(
                  color: primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
