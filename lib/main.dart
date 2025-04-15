import 'package:flutter/material.dart';


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

class _NavigationState extends State<Navigation> {
  
  late PageController _controller; // Controller for different pages
  late int _pageIndex; // Variable to see current page

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    
    // TODO implement a laod in data spot here
    _pageIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
            
            onDestinationSelected: (int index){
              setState(() {
                _pageIndex = index;
              });
            },

            destinations: <NavigationRailDestination> [
              
              // Home selection
              NavigationRailDestination(
                icon: Icon(Icons.home), 
                label: Text(
                  'Home',
                  style: TextStyle(fontFamily: 'AnonymousPro'),
                ),
                selectedIcon: Icon(Icons.home_filled)
              ),
              
              // Colours selection
              NavigationRailDestination(
                icon: Icon(Icons.brush_outlined), 
                label: Text(
                  'Colours',
                  style: TextStyle(fontFamily: 'AnonymousPro'),
                ),
                selectedIcon: Icon(Icons.brush)
              ),
            ], // Destinations
          ),

          VerticalDivider(),

          PageView(
            controller: _controller,
            allowImplicitScrolling: false,
            children: <Widget> [
              Center(
                child: Text(
                  'HOME'
                ),
              ),
    
              Center(
                child: Text(
                  'COLOURS'
                ),
              ),
            ],
          ),
        ], // Children
      ),
    );
  }
}




