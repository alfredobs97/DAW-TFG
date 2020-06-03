import 'package:flutter/material.dart';
import 'sign-in.dart';
import 'sign-up.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = PageController(initialPage: 0);
  final List<Widget> tabs = [SignIn(), SignUp()];
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: DefaultTabController(
            length: tabs.length,
            child: LayoutBuilder(builder: (ctx, constraints) {
              return constraints.maxWidth > 660 ? _loginWeb() : _loginMobile();
            })));
  }

  _loginMobile() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          child: Image.asset('assets/logo.png',)
        ),
        TabBar(labelColor: Colors.black, tabs: [
          Tab(
            text: 'Login',
          ),
          Tab(
            text: 'Registro',
          )
        ]),
        Expanded(child: TabBarView(children: tabs))
      ],
    );
  }

  _loginWeb() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TabBar(labelColor: Colors.black, tabs: [
                  Tab(
                    text: 'Login',
                  ),
                  Tab(
                    text: 'Registro',
                  )
                ]),
                Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: TabBarView(children: tabs)),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Image.asset('assets/logo.png', fit: BoxFit.fill,)
        ),
      ],
    );
  }
}
