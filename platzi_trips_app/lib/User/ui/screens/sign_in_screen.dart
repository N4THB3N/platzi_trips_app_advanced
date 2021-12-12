import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  UserBloc userBloc;
  double screenWidht;
  AsyncSnapshot snapshot;
  double screenwith;

  @override
  Widget build(BuildContext context) {
    screenWidht = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // snapshot - data - Object User

        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    child: Container(
                  width: screenwith,
                  child: Text(
                    "Welcome \n This is your Travel App",
                    style: TextStyle(
                        fontSize: 37.0,
                        fontFamily: "Lato",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                ButtonGreen(
                  text: "Login with Gmail",
                  onPressed: () {
                    userBloc.signIn().then((auth.User user) {
                      userBloc.updateUserData(User(
                          uid: user.uid,
                          name: user.displayName,
                          email: user.email,
                          photoURL: user.photoURL));
                    });
                  },
                  width: 300.0,
                  heigth: 50.0,
                )
              ])
        ],
      ),
    );
  }
}
