import 'package:flutter/material.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppsHome(),
    );
  }
}

class AppsHome extends StatelessWidget {
  const AppsHome({Key? key}) : super(key: key);

  /// SnackBar message code
  SnackBarMessage(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// AppBar
      appBar: AppBar(
        /// appBar
        title: Text("Mess App"),
        //titleSpacing: 15,
        centerTitle: true,
        toolbarOpacity: 1,
        toolbarHeight: 85,
        elevation: 25,
        backgroundColor: Colors.blueAccent,

        /// set action icon in appbar
        actions: [
          IconButton(
            onPressed: () {
              SnackBarMessage('Search', context);
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                SnackBarMessage('Call', context);
              },
              icon: Icon(Icons.add_call)),
          IconButton(
              onPressed: () {
                SnackBarMessage('Settings', context);
              },
              icon: Icon(Icons.settings_applications))
        ],
      ),

      /// Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text('1'),
          // Text('2'),
          // Text('3'),
          // Text('4'),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   //crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text('a'),
          //     Text('b'),
          //     Text('c'),
          //     Text('d'),
          //   ],
          // )

          /// Container
          Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(20),
            //color: Colors.redAccent,
            child: Text('This is Container', style: TextStyle(fontSize: 24)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.greenAccent, width: 5),
              color: Colors.redAccent,
            ),
          ),

          /// Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.black,
              elevation: 25,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )
            ),
            onPressed: (){
            SnackBarMessage('Tap me', context);
          },
              child: Text('Tap me'),
          )
        ],
      ),

      /// floating action button
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () {
          SnackBarMessage('This is Camera action', context);
        },
        backgroundColor: Colors.blueAccent,
        hoverColor: Colors.blueGrey,
      ),

      /// bottom navigation bar / tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedFontSize: 18,
        unselectedFontSize: 8,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add_sharp), label: 'Notification'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.read_more), label: 'Read more')
        ],
        onTap: (int index) {
          if (index == 0) {
            SnackBarMessage('See Notifications', context);
          }
          if (index == 1) {
            SnackBarMessage('Goto Home', context);
          }
          if (index == 2) {
            SnackBarMessage('Read  more', context);
          }
        },
      ),

      /// Navigation Drawer
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  accountName: Text('Mess Name', style: TextStyle(color: Colors.white),),
                  accountEmail: Text('messSylhet2023@gmail.com', style: TextStyle(color: Colors.white)),
                  currentAccountPicture: Image.network('https://cdn0.iconfinder.com/data/icons/education-school-science/100/29-512.png'),
                  //currentAccountPictureSize: Size.square(150),
                )
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              hoverColor: Colors.grey,
              onTap: () {
                SnackBarMessage('My Profile', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              hoverColor: Colors.grey,
              onTap: () {
                SnackBarMessage('Goto Home', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Contact with Manager'),
              hoverColor: Colors.grey,
              onTap: () {
                SnackBarMessage('Call to Manager', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.report_gmailerrorred_outlined),
              title: Text('Report to Manager'),
              hoverColor: Colors.grey,
              onTap: () {
                SnackBarMessage('Report to Manager', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text('About'),
              hoverColor: Colors.grey,
              onTap: () {
                SnackBarMessage('About Us', context);
              },
            ),
          ],
        ),
      ),

    );
  }
}
