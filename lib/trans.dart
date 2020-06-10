import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'addalldataexpenses.dart';
import 'addalldataincome.dart';

class Trans extends StatefulWidget {
  @override
  _TransState createState() => _TransState();
}

class _TransState extends State<Trans> with SingleTickerProviderStateMixin  {
  int _selectedIndex = 0;
  TabController _myTabController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    _myTabController = TabController(vsync: this, length: 5);
  }
  var Myso = "date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        // visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              label: 'income',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () async {
                Route route =
                MaterialPageRoute(builder: (context) => add_alldata_income());
                var returnBack = await Navigator.push(context, route);
                //await getincome_categaryList();
              }),
          SpeedDialChild(
              child: Icon(Icons.brush),
              backgroundColor: Colors.blue,
              label: 'expenses',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: ()  async {
                Route route =
                MaterialPageRoute(builder: (context) => add_alldata_expenses());
                var returnBack = await Navigator.push(context, route);
                //await getincome_categaryList();
              }//=> print('SECOND CHILD'),
          ),

        ],
      ),
      //  );
      // }

      appBar: AppBar(
        bottom: TabBar(
          controller:_myTabController,
          tabs:[
            Tab(text: 'Daily',),
            // SELECT * FROM test WHERE date BETWEEN '2011-01-11' AND '2011-08-11',
            Tab(text: 'Calender',),
            Tab(text: 'Weekly',),
            Tab(text: 'Monthly',),
            Tab(text: 'Total',),
          ], ),
        leading: Mydate(context),
        title: Text('2020 '),
        backgroundColor: Colors.red,
        centerTitle: false,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.bookmark,
                color: Colors.white ,),
              onPressed: (){}),
          IconButton(
            icon: Icon( Icons.search,
              color: Colors.white,),
            onPressed: (){},
          )
        ],),

    );

  }
  Widget Mydate(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          getDate(context);
        },
        child: Text(Myso),
      ),
    );
  }
  getDate(BuildContext context) async {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    setState(() {
      Myso = selectedDate.toString();
    });
  }
}
