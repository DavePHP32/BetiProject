import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Bibliothèque permettant l'envoie de l'application
import 'package:url_launcher/url_launcher.dart'; // Bibliothèque permetteant d'aller sur app store ou play store
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() {
  //bannière de debugage
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Définition de  la bannière de débogage à false
      theme: ThemeData(
        primarySwatch: Colors.amber, // Couleur principale utilisée pour l'AppBar et autres éléments
      ),

      home: HomePage(),

    );
  }
}

class HomePage extends StatelessWidget {

  @override
  void initState(){

  }
  final String appPackageName = "untitled6"; //le nom du package de l'application

  void _openAppStoreOrPlayStore() async {
    if (Platform.isIOS) {
      final String url = "https://itunes.apple.com/app/$appPackageName";//Definition de l'url allant vers play store
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Impossible d'ouvrir l'App Store");
      }
    } else if (Platform.isAndroid) {
      final String url = "https://play.google.com/store/apps/details?id=$appPackageName";//Definition de l'url allant vers play sto
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Impossible d'ouvrir le Play Store");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber, // Couleur de fond de l'AppBar en jaune
          title: Text(
              'Betiba',
            style:TextStyle(
              fontWeight:FontWeight.bold,
              fontSize:26,

            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //les actions
              },
            ),


          ],
          bottom: TabBar(
            tabs: [
          Tab(
          child: Text(
          'CATÉGORIES',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            'TOUS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            'NUMÉROS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
            ],
          ),

        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white, //couleur du txet),
            ),
          ),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('img/studioShine.png'),
                ),
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('img/SDF.png'),
                      alignment: Alignment.centerLeft,
                    fit:BoxFit.cover
                  ),
                  //color: Colors.amber,

                ),
              ),
              ListTile(
                leading: Icon(
                    Icons.border_all,
                  color:Colors.amber,
                ),
                title: Text('Tous'),
                onTap: () {
                  // Naviguer vers la page "Tous"
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite,
                  color:Colors.amber,
                ),
                title: Text('Favoris'),
                onTap: () {
                  // Naviguer vers la page "Favoris"
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.info,
                  color:Colors.amber,
                ),
                title: Text('À propos de nous'),
                onTap: () {
                  Navigator.pushNamed(context, '/aboutUs');
                  // Naviguer vers la page "À propos de nous"

                },
              ),
              ListTile(
                leading: Icon(
                    Icons.share,
                  color:Colors.amber
                ),
                title: Text('Partager l\'appli'),
                onTap: () {
                  // Naviguer vers la page "Partager l'appli"
                  // Partager l'application avec d'autres personnes
                  Share.share('Téléchargez notre superbe application !');
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.insert_comment_outlined,
                  color: Colors.amber,
                ),
                title: Text('Commentaires & avis'),
                onTap: () {
                  // Naviguer vers la page "Commentaires & avis"
                  // Rediriger vers le Play Store pour les commentaires et avis
                  _openAppStoreOrPlayStore();
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.settings,
                  color:Colors.amber,
                ),
                title: Text('Paramètres'),
                onTap: () {
                  Navigator.pushNamed(context, '/parametres');
                  // Naviguer vers la page "Paramètres
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.monetization_on,
                  color:Colors.amber,
                ),
                title: Text('Nous soutenir '),
                onTap: () {
                  // Naviguer vers la page "Faire un don"
                  Navigator.pushNamed(context, '/helpUs');
                },
              ),
              // Ajoutez d'autres éléments de la sidebar ici
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Page 1 avec la liste déroulante
            SingleChildScrollView(
              child: MyExpansionPanelList(),
            ),
            // Page 2 avec la liste d'éléments contenant deux Row
            Page2Content(),
            // Page 3
            Center(
              child: Text('Contenu de la page 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyExpansionPanelList extends StatefulWidget {
  @override
  _MyExpansionPanelListState createState() => _MyExpansionPanelListState();
}

class _MyExpansionPanelListState extends State<MyExpansionPanelList> {
  List<bool> _isExpandedList = [false, false];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpandedList[index] = !isExpanded;
          });
        },
        children: [
        ExpansionPanel(
        headerBuilder: (context, isExpanded) {
      return ListTile(
        leading: _isExpandedList[0] ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
        title: Text('Liste 1'),
      );
    },
    body: Column(
    children: [
    ListTile(
    title: Text('Sous-liste 1'),
    ),
    ListTile(
    title: Text('Sous-liste 2'),
    ),
    ],
    ),
    isExpanded: _isExpandedList[0],
    ),
    ExpansionPanel(
    headerBuilder: (context, isExpanded) {
    return ListTile(
    leading: _isExpandedList[1] ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
      title: Text('Liste 2'),
    );
    },
      body: Column(
        children: [
          ListTile(
            title: Text('Sous-liste 1'),
          ),
          ListTile(
            title: Text('Sous-liste 2'),
          ),
        ],
      ),
      isExpanded: _isExpandedList[1],
    ),
        ],
    );
  }
}

// Page 2 avec la liste d'éléments contenant deux Row

class Page2Content extends StatefulWidget {
  @override
  _Page2ContentState createState() => _Page2ContentState();
}

class _Page2ContentState extends State<Page2Content> {
  late Future<QuerySnapshot> _dataFuture;

  @override
  void initState() {
    super.initState();
    _refreshData(); // Initial data load
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataFuture = FirebaseFirestore.instance.collection('song').get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<QuerySnapshot>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('An error occurred: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data found.');
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final songData =
              snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final songId = songData['id'] ?? '';
              final songTitle = songData['titre'] ?? '';
              final songInterprete = songData['interprete'] ?? '';
              final songProduction = songData['production'] ?? '';
              final songParoles = songData['paroles'] ?? '';
              final songUrl = songData['urlaudio'] ?? '';

              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/songDetails',
                      arguments: {
                        'songId': songId.toString(),
                        'songTitle': songTitle,
                        'songInterprete': songInterprete,
                        'songProduction': songProduction,
                        'songParoles': songParoles,
                        'songUrl': songUrl,
                      },
                    );
                  },
                  leading: Text(
                    'N°$songId',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    songTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songInterprete),
                      SizedBox(height: 4.0),
                      Text(songProduction),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}