import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
                "Welcome Khalid",
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
            // Profile
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
              onTap: () {},
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
}
