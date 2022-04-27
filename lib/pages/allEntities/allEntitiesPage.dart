import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:iit_app/data/internet_connection_interceptor.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:iit_app/model/colorConstants.dart';
import 'package:iit_app/ui/drawer.dart';
import 'package:iit_app/ui/entity_custom_widgets.dart';
import 'package:built_collection/built_collection.dart';

class EntitiesPage extends StatefulWidget {
  @override
  _EntitiesPageState createState() => _EntitiesPageState();
}

class _EntitiesPageState extends State<EntitiesPage> {
  void initState() {
    super.initState();
  }

  Future<bool> onPop() async {
    Navigator.pushNamed(context, '/home');
    return true;
  }

  void reload() async {
    try {
      await AppConstants.updateAndPopulateAllEntities();
      setState(() {
        endPosts = [];
        councilPosts = [];
        endInd = -1;
      });
    } on InternetConnectionException catch (_) {
      AppConstants.internetErrorFlushBar.showFlushbar(context);
      return;
    } catch (err) {
      print(err);
    }
  }

  List<dynamic> endPosts = [];
  List<dynamic> councilPosts = [];
  int endInd = -1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: SafeArea(
          minimum: const EdgeInsets.all(2.0),
          child: Scaffold(
            backgroundColor: ColorConstants.homeBackground,
            appBar: AppBar(
              leading: IconButton(
                color: ColorConstants.btnColor,
                iconSize: 30,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: ColorConstants.headingColor,
              automaticallyImplyLeading: false,
              title: Text(
                "All Entities and Councils",
                style: TextStyle(color: ColorConstants.btnColor),
              ),
            ),
            drawer: SideBar(context: context),
            body: RefreshIndicator(
              displacement: 60,
              onRefresh: () async => reload(),
              child: _getAllEntities(),
            ),
          )),
    );
  }

  Widget _getAllEntities({Function reload}) {
    return Container(
        child: FutureBuilder<Response<BuiltList<EntityListPost>>>(
      future: AppConstants.service.getAllEntity(),
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
          final posts = snapshot.data.body
              //?.where((entity) => entity.is_permanent != true)
              ?.toBuiltList();
          endPosts = [];
          posts.forEach((p0) {
            endPosts.add(p0);
          });
          //allposts.addAll(posts);
          return FutureBuilder(
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return snap.data;
                } else {
                  return EntityCustomWidgets.getPlaceholder();
                }
              },
              future: _buildAllEntitiesBodyPosts(context, reload: reload));
        } else {
          return Center(
            child: EntityCustomWidgets.getPlaceholder(),
          );
        }
      },
    ));
  }

  Future<Widget> _buildAllEntitiesBodyPosts(BuildContext context,
      {Function reload}) async {
    var posts = endPosts;
    endInd = posts.length;
    final snap = await AppConstants.service.getAllCouncils();
    final post = snap.body?.toBuiltList();
    posts.addAll(post);
    posts = posts.reversed.toList();
    endInd = post.length;

    return Container(
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            if (index >= endInd) {
              return EntityCustomWidgets.getEntityCard(context,
                  entity: posts[index], horizontal: true, reload: reload);
            } else {
              return EntityCustomWidgets.getCouncilyCard(context,
                  entity: posts[index], horizontal: true, reload: reload);
            }
          }),
    );
  }
}
