import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text_generator/colours/colours_page.dart';
import 'package:gradient_text_generator/databasing/database.dart';
import 'package:gradient_text_generator/databasing/provider.dart';
import 'package:gradient_text_generator/home/home_page.dart';
import 'package:gradient_text_generator/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle('Gradient Text Generator');
    setWindowMaxSize(Size.infinite);
    setWindowMinSize(Size(800, 800));
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProviderService())
    ],
    child: const MainApp()
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        // Light mode TODO dark mode
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.purple,
          primary: Colors.purple[200],
          secondary: Colors.white,
          tertiary: Colors.purple[400]
          
        ),
        useMaterial3: true
      ),
      home: const Navigation()
    );
  } // Widget build
} // MainApp


// Widget for navigating the different pages
class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
} // Navigation

class _NavigationState extends State<Navigation> with TickerProviderStateMixin{
  
  late int _pageIndex; // Variable to determine selected page

  @override
  void initState() {
    super.initState();
    
    // TODO implement a load-in-page here
    _pageIndex = 0;

    _initializeData();
  }

  Future<void> _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasRun = prefs.getBool('hasRun') ?? false;

    if(!hasRun && mounted){
      var provider = Provider.of<ProviderService>(context, listen: false);
      await prefs.setBool('hasRun', true);
    }
  }

  // Displaying a page based on which one was selected
  Widget _selectedPage(index){
    switch (index) {
      case 0:
      return HomePage();
      case 1:
      return ColoursPage();
      default:
      return Center(child: Text("HEY! YOU BROKE MY CODE!"));
    }
  }

  // Function for when a different page is selected
  _changePage(index){
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Consumer<ProviderService>(
            builder: (context, provider, child){
            return FutureBuilder(
              future: provider.getColourList('Gradient Text Generator'),
              builder: (context, snapshot) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: snapshot.connectionState==ConnectionState.done?
                        provider.colourList:
                        <Color>[Colors.yellow, Colors.orange, Colors.purple, Colors.blue],
                    ).createShader(bounds);
                  },
                  child: StyledText(
                    'Gradient Text Generator',
                    bold: true,
                    fontSize: 30,
                    styleColour: Colors.white,
                  ),
                );
              }
            );
            }
          )
        ),
      ),
      body: Row(
        children: <Widget> [
          NavigationRail(
            
            selectedIndex: _pageIndex,
            groupAlignment: -1.0,
            labelType: NavigationRailLabelType.all,
            
            onDestinationSelected: _changePage,

            destinations: const <NavigationRailDestination> [
              
              // Home selection
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined), 
                selectedIcon: Icon(Icons.home),
                label: StyledText('Home',),
              ),
              
              // Colours selection
              NavigationRailDestination(
                icon: Icon(Icons.brush_outlined), 
                selectedIcon: Icon(Icons.brush),
                label: StyledText('Colours'),
              ),
            ],
          ),

          VerticalDivider(),

          Expanded(
            child: _selectedPage(_pageIndex),
          ),
        ],
      ),
    );
  } // Widget build
} // _NavigationState