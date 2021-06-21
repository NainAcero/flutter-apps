import 'package:flutter/material.dart';
import 'package:flutter_sql/db/app_theme.dart';
import 'package:flutter_sql/db/users_store.dart';
import 'package:flutter_sql/models/user.dart';
import 'package:sembast/sembast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<User> _users = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  _load() async {
    final Finder finder = Finder(
      sortOrders: [
        SortOrder(
          'name',
        ),
      ],
      filter: Filter.greaterThanOrEquals(
        'age', 37,
      ),
    );
    this._users = await UsersStore.instance.find(finder: finder);
    setState(() {});
  }

  _add() async {
    final User user = User.fake();
    await UsersStore.instance.add(user);
    this._users.add(user);
    setState(() {});
  }

  _delete() async {
    final Finder finder = Finder(
      filter: Filter.and(
        [
          Filter.greaterThan('age', 70),
          Filter.matches('name', '^Miss'),
        ],
    ));
    final int count = await UsersStore.instance.delete(finder: finder);
    final SnackBar snackBar = SnackBar(content: Text("$count items deleted"));
    _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    this._load();
  }

  _deleteUser(User user) async {
    final Finder finder = Finder(filter: Filter.byKey(user.id));
    final int count = await UsersStore.instance.delete(finder: finder);
    final SnackBar snackBar = SnackBar(content: Text("User deleted"));
    _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    this._load();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Switch(
                value: MyAppTheme.instance.darkEnabled, 
                onChanged: (bool enabled) {
                  MyAppTheme.instance.change(enabled);
                }
              )
            ],
          ),
          body: ListView.builder(
            itemBuilder: (_, index) {
              final User user = this._users[index];
              return ListTile(
                title: Text(user.name!),
                subtitle: Text("age: ${user.age}, email: ${user.email}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    this._deleteUser(user);
                  },
                )
              );
            },
            itemCount: this._users.length,
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: this._load,
                heroTag: 'reload',
                child: Icon(
                  Icons.repeat,
                  color: Colors.white,
                ),
                backgroundColor: Colors.green,
              ),
              SizedBox(width: 15),
              FloatingActionButton(
                onPressed: this._delete,
                heroTag: 'clear',
                child: Icon(
                  Icons.clear_all,
                  color: Colors.white,
                ),
                backgroundColor: Colors.redAccent,
              ),
              SizedBox(width: 15,),
              FloatingActionButton(
                onPressed: this._add,
                heroTag: 'add',
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
      ),
    );
  }
}