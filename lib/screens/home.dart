import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_open/screens/news_videos.dart';
import 'package:mobile_app_open/screens/profile_edit.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/validators.dart';
import 'package:provider/provider.dart';

import '../services/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
<<<<<<< HEAD
      NewsVideos()
    ,
=======
    NewsVideos(),
>>>>>>> master
    Text(
      'Favoritos',
      style: optionStyle,
    ),
    Text(
      'Playlists',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var userName = checkEmptyValue(user.displayName);
    var userPhoto = checkEmptyValue(user.photoURL);
    var userEmail = checkEmptyValue(user.email);
    var firstLetter =
        !userEmail.isEmpty ? userEmail.substring(0, 1).toUpperCase() : '';

    _buildUserDrawerHeader() {
      if (user.displayName == null && user.photoURL == null) {
        return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kColorBlue,
            ),
            accountEmail: Text("${user.email}"),
            accountName: null,
            currentAccountPicture: CircleAvatar(
                backgroundColor: kColorYellow,
                child: Text(
                  firstLetter,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kColorBlue),
                )));
      } else {
        return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kColorBlue,
            ),
            accountEmail: Text("${userEmail}"),
            accountName: Text('${userName}'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(userPhoto),
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/open-unifeob.png',
          width: 100.0,
        ),
        backgroundColor: kColorBlue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildUserDrawerHeader(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Meu canal'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Meus cursos'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Meu perfil'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile())),
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Mensagens'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: Text('Estatíticas'),
              onTap: () => {},
            ),
            Divider(
              color: Color.fromARGB(31, 0, 0, 0),
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda e Feedback'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
<<<<<<< HEAD
              onTap: () => {context.read<AuthService>().logout(), context.read<GoogleSignInProvider>().logout()},
=======
              onTap: () => {
                context.read<AuthService>().logout(),
                // context.read<GoogleSignInProvider>().logout()
              },
>>>>>>> master
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Início',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlists',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kColorYellow,
        unselectedItemColor: kColorWhite,
        onTap: _onItemTapped,
      ),
    );
  }
}
