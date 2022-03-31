import 'package:flutter/material.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Início',
      style: optionStyle,
    ),
    Text(
      'Index 1: Favoritos',
      style: optionStyle,
    ),
    Text(
      'Index 2: Playlists',
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
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kColorBlue,
              ),
              accountEmail: Text("email@email.com"),
              accountName: Text('Usuário Logado'),
              currentAccountPicture: CircleAvatar(
                child: Text('U', style: TextStyle(fontSize: 26.0),)
              ),
            ),
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
              leading: Icon(Icons.email),
              title: Text('Mensagens'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: Text('Estatíticas'),
              onTap: () => {},
            ),
            Divider(color: Color.fromARGB(31, 0, 0, 0), thickness: 1,),
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
              onTap: () => {context.read<AuthService>().logout()},
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
