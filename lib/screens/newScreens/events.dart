import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iit_app/data/internet_connection_interceptor.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:iit_app/pages/worshop_detail/workshopDetailPage.dart';
import 'package:async/async.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<Response<BuiltAllWorkshopsPost>> future;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    future = AppConstants.service.getAllWorkshops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: buildAllWorkshopsBody(context));
  }

  FutureBuilder<Response> buildAllWorkshopsBody(BuildContext context,
      {Function reload}) {
    Size screensize = MediaQuery.of(context).size;
    return FutureBuilder<Response<BuiltAllWorkshopsPost>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is InternetConnectionException) {
              AppConstants.internetErrorFlushBar.showFlushbar(context);
            }
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final posts = snapshot.data.body;

          return builtAllWorkshopsBodyPosts(context, posts, reload: reload);
        } else {
          return Container(
            height: screensize.height * 0.285,
            child: Row(
              children: [
                SizedBox(
                  width: screensize.width * 0.44,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF176ede),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Widget builtAllWorkshopsBodyPosts(
    BuildContext context, BuiltAllWorkshopsPost posts,
    {Function reload}) {
  Size screensize = MediaQuery.of(context).size;
  return Row(
    children: <Widget>[
      Container(
        height: kIsWeb ? 250 : screensize.height * 0.285,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: posts.active_workshops.length,
          padding: EdgeInsets.only(top: 1.0, right: 10.0),
          itemBuilder: (context, index) {
            final w = posts.active_workshops[index];
            final bool isClub = w.club != null;
            var logoFile;
            if (isClub)
              logoFile = AppConstants.getImageFile(w.club.small_image_url);
            else
              logoFile = AppConstants.getImageFile(w.entity.small_image_url);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        WorkshopDetailPage(w.id, workshop: w, isPast: false),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: EventCard(
                image: isClub
                    ? (w.club.small_image_url == null ||
                            w.club.small_image_url == ''
                        ? AssetImage('assets/iitbhu.jpeg')
                        : logoFile == null
                            ? NetworkImage(w.club.small_image_url)
                            : FileImage(logoFile))
                    : (w.entity.small_image_url == null ||
                            w.entity.small_image_url == ''
                        ? AssetImage('assets/iitbhu.jpeg')
                        : logoFile == null
                            ? NetworkImage(w.entity.small_image_url)
                            : FileImage(logoFile)),
                eventstatus: true,
              ),
            );
          },
        ),
      ),
      Container(
        height: kIsWeb ? 250 : screensize.height * 0.285,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: posts.past_workshops.length,
          padding: EdgeInsets.only(top: 1.0, right: 10.0),
          itemBuilder: (context, index) {
            final w = posts.past_workshops[index];
            final bool isClub = w.club != null;
            var logoFile;
            if (isClub)
              logoFile = AppConstants.getImageFile(w.club.small_image_url);
            else
              logoFile = AppConstants.getImageFile(w.entity.small_image_url);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        WorkshopDetailPage(w.id, workshop: w, isPast: true),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
                );
                // .then((value) => reload());
              },
              child: EventCard(
                image: isClub
                    ? (w.club.small_image_url == null ||
                            w.club.small_image_url == ''
                        ? AssetImage('assets/iitbhu.jpeg')
                        : logoFile == null
                            ? NetworkImage(w.club.small_image_url)
                            : FileImage(logoFile))
                    : (w.entity.small_image_url == null ||
                            w.entity.small_image_url == ''
                        ? AssetImage('assets/iitbhu.jpeg')
                        : logoFile == null
                            ? NetworkImage(w.entity.small_image_url)
                            : FileImage(logoFile)),
                eventstatus: false,
              ),
            );
          },
        ),
      ),
    ],
  );
}

class EventCard extends StatelessWidget {
  const EventCard({
    this.image,
    this.eventstatus,
  });

  final ImageProvider<Object> image;
  final bool eventstatus;
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    var cardwidth = kIsWeb ? 200 : screensize.width * 0.445;
    var cardheight = kIsWeb ? 200 : screensize.height * 0.245;
    return GestureDetector(
      onTap: null,
      child: Container(
        margin: EdgeInsets.only(left: 1.0, right: 1.0),
        width: cardwidth * 1.05,
        height: cardheight * 1.1,
        child: Stack(
          children: [
            Container(
              height: cardheight,
              width: cardwidth,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(
                      1.0,
                      1.0,
                    ), //Offset
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
                image: new DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (eventstatus == true)
              Positioned(
                top: 0.0,
                right: 5.0,
                child: EventOnline(),
              ),
          ],
        ),
      ),
    );
  }
}

class EventOnline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0,
      width: 15.0,
      decoration:
          BoxDecoration(color: Color(0xFF00d823), shape: BoxShape.circle),
    );
  }
}
