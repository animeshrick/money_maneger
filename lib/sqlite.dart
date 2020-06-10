import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SQLite {
  SQLite();

  setup() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter_money2.db');

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table

          await db.execute(
              'CREATE TABLE [users] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,mobile text,password text,profile_image text,name text)');
          await db.execute(
              "INSERT INTO users(mobile, password,name)VALUES('7548956589','1234','minoti')");
          await db.execute(
              'CREATE TABLE [income_categary] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,category_name text,category_icon text,create_a_date date)');
          await db.execute(
              'CREATE TABLE [expense_category] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,category_name text,category_icon text,category_date text)');
          await db.execute(
              'CREATE TABLE [account_log] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT,ammount double,income_category_id integer,expense_category_id integer,account_id integer,transaction_type text,perpus_transaction text,tranasction_bill_img text,create_date date)');
          await db.execute(
              'CREATE TABLE [account] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,account_name text,account_balance double,users_id integer)');
        });
  }

  delete() async {

  }

  connect() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter_money2.db');
    Database db = await openDatabase(path, version: 1);
    return db;
  }

  static successToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
  }

  static errorToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
  }

  login(String mobile, String password) async {
    final db = await connect();
    try {
      final users = await db.rawQuery(
          "SELECT * FROM users where mobile='$mobile' AND password ='$password'");
      return users;
    } catch (e) {
      print(e);
    }
  }

  storelogininfo(String mobile, String password,
      int user_id,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobile);
    await prefs.setString('password', password);
    await prefs.setBool('is_login', true);
    await prefs.setInt('user id', user_id);
  }

  is_login() async {
    var is_login = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var foundUser = await prefs.getBool('is_login');
    print('founduser');
    print(foundUser);
    if (foundUser == null) {
      is_login = false;
    } else {
      is_login = true;
    }
    return is_login;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user id');
  }

  addNewAccount(data) async {
    final db = await connect();
    try {
      var id = await db.insert('account', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  getAccountList() async {
    final db = await connect();
    final userID = await getUserId();
    final users = await db.rawQuery("SELECT * FROM account ");
    return users;
  }
  addexpensecategory(data) async {
    final db = await connect();
    try {
      var id = await db.insert('expense_category ', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  getexpense_categoryList() async {
    final db = await connect();
    final userID = await getUserId();
    final users = await db.rawQuery("SELECT * FROM expense_category ");
    return users;
  }
  addincomecategory(data) async {
    final db = await connect();
    try {
      var id = await db.insert(' income_categary', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  getincome_categaryList() async {
    final db = await connect();
    final userID = await getUserId();
    final users = await db.rawQuery("SELECT * FROM income_categary ");
    return users;
  }
  addaccount_log(data) async {
    final db = await connect();
    try {
      var id = await db.insert('account_log ', data);
      return id;
    } catch (e) {
      print(e);
    }
  }
  getaccount_log(t_type) async {
    final db = await connect();
    final userID = await getUserId();
    final users=
    await db.rawQuery("SELECT * FROM account_log ORDER BY id DESC ");
    return users;
  }
  getcategory_nameId(Id,TableName) async {
    final db = await connect();
    final userID = await getUserId();
    final users =
    await db.rawQuery("SELECT * FROM $TableName WHERE Id ='$Id'");
   // if (TableName == 'expense_category') {
    //  return users[0]["category_name"];
   // }
    return users[0]["category_name"];
  }
  daily() async {
    var date=new DateTime.now();
    var formated_date = date.year.toString() + '-' +
        date.month.toString() + '-' +
        date.day.toString();
    final db = await connect();
    final userID = await getUserId();
    final users = await db.rawQuery("SELECT * FROM account_log WHERE create_date ='formated_date ");
    return users;
  }
  weekly() async {
    final db = await connect();
    final userID = await getUserId();
    final users = await db.rawQuery("SELECT * FROM account ");
    return users;
  }
  monthly() async {
    var date=new DateTime.now();
    var start_date = date.year.toString() + '-' +
        date.month.toString() + '-01';
    var end_date = date.year.toString() + '-' +
        date.month.toString() + '-31';
    final db = await connect();
    final users = await db.rawQuery("SELECT * FROM account_log WHERE create_date BETWEEN $start_date AND $end_date");
    return users;
  }
  total()async{
    final db = await connect();
    final users = await db.rawQuery("SELECT * FROM account_log ");
    return users;
  }
}
