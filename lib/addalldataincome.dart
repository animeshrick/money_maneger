import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money/sqlite.dart';

class add_alldata_income extends StatefulWidget {
  @override
  _add_alldata_incomeState createState() => _add_alldata_incomeState();
}

class _add_alldata_incomeState extends State<add_alldata_income> {
  String _image;

  Future getImage(source) async {
    var image = await ImagePicker.pickImage(source: source);
    print(image.path);
    setState(() {
      _image = image.path.toString();
    });
  }

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final dateController = TextEditingController();
  String Income_Account = '';
  String Date = '';
  String Select_income_category = '1';
  String Image = '';
  List income_categary = [];
  List account = [];
  String Select_accounts = '1';
  final datecontroller = TextEditingController();

  //String Account ='';
  String remark = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getincome_categaryList();
    getAccountList();
  }

  var Myso = "date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolkey,
        appBar: AppBar(
          title: Text("Add Income Category".toUpperCase()),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
              Container(
                height: 10,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: Select_income_category,
                hint: Text('Please choose a Income Category'),
                items: income_categary.map((income) {
                  return DropdownMenuItem<String>(
                    value: income['id'].toString(),
                    child: Text(income['category_name'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    Select_income_category = value.toString();
                  });
                },
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: Select_accounts,
                hint: Text('Please choose an account'),
                items: account.map((accountName) {
                  return DropdownMenuItem<String>(
                    value: accountName['id'].toString(),
                    child: Text(accountName['account_name'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    Select_accounts = value.toString();
                  });
                },
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.keyboard),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Enter Your Income Ammount',
                  labelText: 'Income Ammount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    Income_Account = value;
                  });
                },
              ),
              Container(
                height: 10,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: dateController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(fontSize: 14.0),
                      labelStyle: TextStyle(fontSize: 16.0),
                      hintText: 'Enter Your date of Income',
                      labelText: 'income date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.date_range),
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2020, 01, 01),
                        maxTime: DateTime(2050, 12, 30), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      var formated_date = date.year.toString() +
                          '-' +
                          date.month.toString() +
                          '-' +
                          date.day.toString();
                      dateController.text = formated_date;
                      print('confirm $date');
                    });
                    // currentTime: DateTime.now(),
                    //locale: LocaleType.zh);
                  },
                )
              ]),
              Container(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.receipt),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Your Remarks',
                  labelText: 'purpose or note or remark',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    remark = value;
                  });
                },
              ),
              Container(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  color: Colors.red,
                  textColor: Colors.white,
                  icon: Icon(Icons.add_a_photo),
                  label: Text("Take a Bill Image".toUpperCase()),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
              ),
              Container(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(
                      color: Colors.red,
                      textColor: Colors.white,
                      icon: Icon(Icons.image),
                      label:
                          Text("Choose Bill Image From Gallery ".toUpperCase()),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      })),
              Container(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.red,
                  textColor: Colors.white,
                  icon: Icon(Icons.add_circle_outline),
                  label: Text("Add New Income Category".toUpperCase()),
                  onPressed: () async {
                    print('hii');
                    var createlog = await SQLite().addaccount_log({
                      'ammount': Income_Account,
                      'income_category_id ': Select_income_category,
                      'account_id': Select_accounts,
                      'transaction_type': 'credit',
                      'perpus_transaction': remark,
                      'tranasction_bill_img': _image,
                      'create_date': dateController.text,
                    });
                    print(createlog);
                    // print(Select_income_category);
                    //  print(purpose_of_transaction);
                    //Route route = MaterialPageRoute(builder: (context)=> ViewIncome());
                    //var returnBack =await Navigator.push(context, route);
                  },
                ),
              )
            ])));
  }

  getincome_categaryList() async {
    final result = await SQLite().getincome_categaryList();
    print(result);
    setState(() {
      income_categary = result;
    });
  }

  getAccountList() async {
    final result = await SQLite().getAccountList();
    print(result);
    setState(() {
      account = result;
    });
  }
}
