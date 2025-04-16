import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Navigation()
    );
  }
}



class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with TickerProviderStateMixin{
  
  late PageController _controller; // Controller for different pages
  late int _pageIndex; // Variabl customizablee to see current page

  @override
  void initState() {
    super.initState();
    
    // TODO implement a laod in data spot here
    _pageIndex = 0;
    _controller = PageController(
      initialPage: _pageIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool get _desktopOrWeb =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.macOS || TargetPlatform.linux || TargetPlatform.windows => true,
        TargetPlatform.android || TargetPlatform.iOS || TargetPlatform.fuchsia => false,
      }; 


  @override
  Widget build(BuildContext context){
    final ThemeData theme = Theme.of(context);

    return Scaffold(
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
                label: Text(
                  'Home',
                  style: TextStyle(fontFamily: 'AnonymousPro'),
                ),
              ),
              
              // Colours selection
              NavigationRailDestination(
                icon: Icon(Icons.brush_outlined), 
                selectedIcon: Icon(Icons.brush),
                label: Text(
                  'Colours',
                  style: TextStyle(fontFamily: 'AnonymousPro'),
                ),
              ),
            ], // Destinations
          ),

          VerticalDivider(),

          Expanded(
            child: _selectedPage(_pageIndex),
          ),
        ], // Children
      ),
    );
  }

  Widget _selectedPage(index){
    switch (index) {
      case 0:
      return Container(child: Text("Main"));
      case 1:
      return Container(child: Text("Colours"));
      default:
      return Container(child: Text("This shouldn't happen"));
    }
  }

  _changePage(index){
    setState(() {
      _pageIndex = index;
    });
  }
}