import 'package:customer249/models/resource_booking_model.dart';
import 'package:customer249/models/user_model.dart';
import 'package:customer249/pages/drawerPages/manage_booking.dart';
import 'package:customer249/pages/home_page.dart';
import 'package:customer249/provider/api_services.dart';
import 'package:customer249/widgets/Loading_widget.dart';
import 'package:customer249/widgets/resource_booking_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        height: height,
        decoration: BoxDecoration(color: Colors.purple),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //image
            SizedBox(
              height: height / 50,
            ),
            Container(
              child: IconButton(
                iconSize: width / 8,
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {},
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            //username
            SizedBox(
              height: height / 50,
            ),
            Center(
              child: Text(
                "${UserModel.user.email}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: height / 25,
            ),
            // points
            Center(
              child: Text(
                "Remaining points",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: height / 200,
            ),
            Center(
              child: Text(
                " ${UserModel.user.points ?? ""}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: height / 25,
            ),
            // Profile
            ListTile(
              onTap: () {},
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Manage booking
            ListTile(
              onTap: () async {
                try {
                  showLoadingDialog(context);
                  // make the api call
                  List<ResourceBookingModel> allBookings =
                      await Provider.of<ApiService>(context, listen: false)
                          .getAllBookings();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ManageBookingPage(bookingsList: allBookings)),
                  );
                } catch (e) {}
              },
              leading: Icon(Icons.book_online, color: Colors.white),
              title: Text(
                "Manage Bookings",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Requests status
            ListTile(
              onTap: () {},
              leading: Icon(Icons.pending, color: Colors.white),
              title: Text(
                "Requests status",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Purchase points
            ListTile(
              onTap: () async {},
              leading: Icon(Icons.money, color: Colors.white),
              title: Text(
                "Purchase Points",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Service history
            ListTile(
              onTap: () {},
              leading: Icon(Icons.table_chart_outlined, color: Colors.white),
              title: Text(
                "Services History",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // About Us
            ListTile(
              onTap: () {},
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text(
                "About Us",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Log Out
            ListTile(
              onTap: () {
                showLoadingDialog(context);
                _logOut(context);
                Navigator.pop(context);
              },
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logOut(context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove("jwtToken");
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pop(context);
    Navigator.pushNamed(context, HomePage.pageName);
    Provider.of<ApiService>(context, listen: false).logOut();
  }
}
