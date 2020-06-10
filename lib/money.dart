import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
import 'homea.dart';
import 'viewexpenses.dart';
import 'viewincome.dart';
class money extends StatefulWidget {
  @override
  _moneyState createState() => _moneyState();
}

class _moneyState extends State<money> with SingleTickerProviderStateMixin {
  TabController _MytabController;

  @override
  void initState() {
    super.initState();
    _MytabController = TabController(vsync: this, length: 2);
  }
  var Myso = "date";
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Income",),
              Tab(text: "Expenses",),

            ],
          ),
          title: Text('Account log'),
        ),
        body: TabBarView(
          children: [

            ViewIncome(),
            ViewExpenses(),
          ],
        ),
      ),
    );
    //leading: showDate(),

  }
}

