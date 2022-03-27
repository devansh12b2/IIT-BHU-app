import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:iit_app/data/internet_connection_interceptor.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:built_collection/built_collection.dart';

//import 'package:iit_app/screens/newScreens/new_home_app_bar.dart';
import 'package:iit_app/screens/newScreens/noticeboard.dart';

import 'events.dart';

FutureBuilder searchNotices(BuildContext context, Future noticeFuture,
    {String searchVal = "lit"}) {
  return FutureBuilder<BuiltList<BuiltAllNotices>>(
      future: noticeFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data
              .where(
                  (element) => element.title.toLowerCase().contains(searchVal))
              .toBuiltList();
          print(data);
          if (data.isEmpty) {
            return Text("No Notices Found");
          }
          return builtAllNotices(context, data);
        } else {
          return CircularProgressIndicator();
        }
      });
  //builtAllNotices(context, data);
}

FutureBuilder<Response> buildWorkshopsFromSearch(
    {BuildContext context,
    BuiltWorkshopSearchByStringPost searchPost,
    Future workshopFuture,
    Function reload}) {
  return FutureBuilder<Response<BuiltAllWorkshopsPost>>(
    future: workshopFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          if (snapshot.error is InternetConnectionException) {
            AppConstants.internetErrorFlushBar.showFlushbar(context);
          }
        }
        if (snapshot.data == null ||
            (snapshot.data.body.active_workshops.isEmpty &&
                snapshot.data.body.past_workshops.isEmpty)) {
          return Text(
            'No Events found',
            textAlign: TextAlign.center,
          );
        }
        final posts = snapshot.data.body;
        print(posts);
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: builtAllWorkshopsBodyPosts(context, posts, reload: reload));
      } else {
        // Show a loading indicator while waiting for the posts
        return Center(
            child:
                CircularProgressIndicator() //WorkshopCustomWidgets.getPlaceholder(),
            );
      }
    },
  );
}

Widget buildResultsFromSearch(BuildContext context,
    {BuiltWorkshopSearchByStringPost searchPost,
    String searchval,
    Function reload,
    Future workshopFuture,
    Future noticeFuture}) {
  return Center(
    child: ListView(
      children: [
        Text(
          'Events',
          style: TextStyle(
            fontFamily: 'Gilroy',
            color: Color(0xFF176ede),
            letterSpacing: .2,
            fontSize: 23.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: <Widget>[
        //       Container(
        //         height: screensize.height * 0.285,
        //         child: ListView.builder(
        //           shrinkWrap: true,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: posts.active_workshops.length,
        //           padding: EdgeInsets.only(top: 1.0, right: 0.0),
        //           itemBuilder: (context, index) {
        //             final w = posts.active_workshops[index];
        //             final bool isClub = w.club != null;
        //             var logoFile;
        //             if (isClub)
        //               logoFile =
        //                   AppConstants.getImageFile(w.club.small_image_url);
        //             else
        //               logoFile =
        //                   AppConstants.getImageFile(w.entity.small_image_url);
        //             return GestureDetector(
        //               onTap: () {
        //                 Navigator.of(context).push(
        //                   PageRouteBuilder(
        //                     pageBuilder: (_, __, ___) => WorkshopDetailPage(w.id,
        //                         workshop: w, isPast: false),
        //                     transitionsBuilder: (context, animation,
        //                             secondaryAnimation, child) =>
        //                         FadeTransition(opacity: animation, child: child),
        //                   ),
        //                 );
        //               },
        //               child: EventCard(
        //                 image: isClub
        //                     ? (w.club.small_image_url == null ||
        //                             w.club.small_image_url == ''
        //                         ? AssetImage('assets/iitbhu.jpeg')
        //                         : logoFile == null
        //                             ? NetworkImage(w.club.small_image_url)
        //                             : FileImage(logoFile))
        //                     : (w.entity.small_image_url == null ||
        //                             w.entity.small_image_url == ''
        //                         ? AssetImage('assets/iitbhu.jpeg')
        //                         : logoFile == null
        //                             ? NetworkImage(w.entity.small_image_url)
        //                             : FileImage(logoFile)),
        //                 eventstatus: true,
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       Container(
        //         height: screensize.height * 0.285,
        //         child: ListView.builder(
        //           shrinkWrap: true,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: posts.past_workshops.length,
        //           padding: EdgeInsets.only(top: 1.0, right: 10.0),
        //           itemBuilder: (context, index) {
        //             final w = posts.past_workshops[index];
        //             final bool isClub = w.club != null;
        //             var logoFile;
        //             if (isClub)
        //               logoFile =
        //                   AppConstants.getImageFile(w.club.small_image_url);
        //             else
        //               logoFile =
        //                   AppConstants.getImageFile(w.entity.small_image_url);
        //             return GestureDetector(
        //               onTap: () {
        //                 Navigator.of(context).push(
        //                   PageRouteBuilder(
        //                     pageBuilder: (_, __, ___) => WorkshopDetailPage(w.id,
        //                         workshop: w, isPast: true),
        //                     transitionsBuilder: (context, animation,
        //                             secondaryAnimation, child) =>
        //                         FadeTransition(opacity: animation, child: child),
        //                   ),
        //                 );
        //                 // .then((value) => reload());
        //               },
        //               child: EventCard(
        //                 image: isClub
        //                     ? (w.club.small_image_url == null ||
        //                             w.club.small_image_url == ''
        //                         ? AssetImage('assets/iitbhu.jpeg')
        //                         : logoFile == null
        //                             ? NetworkImage(w.club.small_image_url)
        //                             : FileImage(logoFile))
        //                     : (w.entity.small_image_url == null ||
        //                             w.entity.small_image_url == ''
        //                         ? AssetImage('assets/iitbhu.jpeg')
        //                         : logoFile == null
        //                             ? NetworkImage(w.entity.small_image_url)
        //                             : FileImage(logoFile)),
        //                 eventstatus: false,
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        buildWorkshopsFromSearch(
          searchPost: searchPost,
          context: context,
          workshopFuture: workshopFuture,
        ),

        SizedBox(
          height: 10,
        ),

        Text(
          'Notice Board',
          style: TextStyle(
            fontFamily: 'Gilroy',
            color: Color(0xFF176ede),
            letterSpacing: .2,
            fontSize: 23.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        searchNotices(context, noticeFuture, searchVal: searchval)
      ],
    ),
  );
}
