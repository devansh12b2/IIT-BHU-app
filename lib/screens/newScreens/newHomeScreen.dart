import 'package:flutter/material.dart';
import 'package:iit_app/data/internet_connection_interceptor.dart';
import 'package:iit_app/external_libraries/fab_circular_menu.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/screens/newScreens/events.dart';
import 'package:iit_app/screens/newScreens/noticeboard.dart';

class NewHomeScreen extends StatefulWidget {
  final BuildContext context;
  final GlobalKey<FabCircularMenuState> fabKey;
  final Function(bool refreshed) reload;

  const NewHomeScreen({Key key, this.context, this.fabKey, this.reload})
      : super(key: key);

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen>
    with SingleTickerProviderStateMixin {
  //TabController _tabController;

  void onRefresh() async {
    try {
      await AppConstants.updateAndPopulateWorkshops();
      await AppConstants.updateAndPopulateNotices();
      //await AppConstants.getNoticeDetailFromDatabase(noticeId: 1);
    } on InternetConnectionException catch (_) {
      AppConstants.internetErrorFlushBar.showFlushbar(context);
      return;
    } catch (err) {
      print(err);
    }
    this.widget.reload(true);
  }

  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return RefreshIndicator(
      displacement: 60,
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8.0),
              child: Text(
                'Noticeboard',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Color(0xFF176ede),
                  letterSpacing: .2,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8.0, bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: screensize.height * 0.35,
                    child: NoticeBoard(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 15.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/allWorkshops'),
                    child: Text(
                      'View More',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color(0xFF176ede),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Events(),
          ),
        ],
      ),
    );
  }
}
