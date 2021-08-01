import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/app_state.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
import '../repositories/auth_repository.dart';

class HealthPersonnelHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: AssetImage('assets/cover.jpg'),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: InkWell(
                  child: Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 7,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, -(MediaQuery.of(context).size.width / 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FloatingButton(
                      icon: Icons.add,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutePath.child_registration);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'New',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FloatingButton(
                      icon: Icons.search,
                      onPressed: () {
                        Navigator.pushNamed(context, RoutePath.child_search);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Existing',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: Container()),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: DitButton(
              label: 'Logout',
              textStyle: TextStyle(color: Colors.white, fontSize: 18),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                if (context.read<AppState>().isLoggedIn) {
                  context.read<AppState>().setIsLoggedIn(false);
                  try {
                    await context
                        .read<AuthRepository>()
                        .logoutHealthPersonnel();
                  } catch (e) {
                    print('During Logout ->' + e.toString());
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key key, this.icon, this.onPressed}) : super(key: key);

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 5,
      child: RawMaterialButton(
        fillColor: Colors.white,
        shape: CircleBorder(),
        elevation: 2.0,
        child: Icon(
          icon,
          color: Colors.black38,
          size: MediaQuery.of(context).size.width / 5 - 60,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
