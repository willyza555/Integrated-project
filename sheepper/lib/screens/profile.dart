import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/api/user.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/my_back_button.dart';
import 'package:sheepper/widgets/common/switch.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.args}) : super(key: key);
  final Map<String, dynamic>? args;
  static const routeName = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name = "";
  late bool isOpen = false;

  Future<void> _getProfile() async {
    try {
      var result = await UserApi.getRestaurantInfo();
      if (result is InfoResponse) {
        setState(() {
          name = result.data['name'];
        });

        isOpen = result.data['isOpen'];
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  Future<void> _closeAndOpenRes() async {
    try {
      await UserApi.closAndOpen();
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    _getProfile();
    _closeAndOpenRes();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/resprofile.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: name.contains("KinKun")
                      ? Image.asset(
                          'assets/res1.jpg',
                          fit: BoxFit.fill,
                        ).image
                      : Image.asset(
                          'assets/res2.png',
                          fit: BoxFit.fill,
                        ).image,
                ),
                Container(
                    width: 500,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 237, 223, 223),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(children: [
                        Text(name,
                            style: Theme.of(context).textTheme.headline2),
                        Divider(
                          color: Colors.black,
                        ),
                        Container(
                            height: 200,
                            child: SwitchScreen(
                              isOpen: isOpen,
                              handler: _closeAndOpenRes,
                            )),
                      ]),
                    )),
                Center(
                  child: Container(
                    child: MyBackButton(),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
