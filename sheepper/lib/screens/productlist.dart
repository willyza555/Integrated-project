import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheepper/models/product.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/api/user.dart';
import 'package:sheepper/services/constants.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/button.dart';
import 'package:sheepper/widgets/common/my_back_button.dart';
import 'package:sheepper/services/api/product.dart';
import 'package:image_picker/image_picker.dart';

class Productlist extends StatefulWidget {
  const Productlist({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  List<ProductForm1> listproduct = [];
  String name = "";

  Future<void> _getProfile() async {
    try {
      var result = await UserApi.getRestaurantInfo();
      if (result is InfoResponse) {
        name = result.data['name'];
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  Future<void> _getproducts() async {
    try {
      var result = await ProductApi.getRestaurantInfo();
      if (result is InfoResponse) {
        List<ProductForm1> temp = [];
        for (var e in result.data) {
          temp.add(ProductForm1.fromJson(e));
        }
        setState(() {
          listproduct = temp;
        });
      }
    } on DioError catch (err) {
      Alert.errorAlert(err, context);
    }
  }

  void initState() {
    super.initState();
    _getproducts();
    _getProfile();
  }

  Future<void> _add(String name, int price, File image) async {
    // listproduct.add(productOfFood(name: name, price: price));
    try {
      var result = await ProductApi.addProductInfo(productOfFood.set(
          name: name, price: price, pictureUrl: "", picture: image));
      _getproducts();
    } on DioError catch (err) {
      Alert.errorAlert(err, context);
    }
  }

  Future<void> _update(String id) async {
    try {
      var result = await ProductApi.updateDoneProduct(id);
      _getproducts();
    } on DioError catch (err) {
      Alert.errorAlert(err, context);
    }
  }

  Future<void> _delete(String id) async {
    try {
      ProductApi.deleteProductInfo(id);
      _getproducts();
    } on DioError catch (err) {
      Alert.errorAlert(err, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Stack(children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,0,0),
                  child: picres(name: name),
                ),
              ],
            ),
          ]),
          foodlist(
            add: _add,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: ListView.builder(
              itemCount: listproduct.length,
              itemBuilder: (context, index) {
                return food(
                  isSoldOut: listproduct[index].isSoldOut,
                  list: listproduct[index].id,
                  name: listproduct[index].name,
                  price: listproduct[index].price,
                  pictureUrl: listproduct[index].pictureUrl,
                  update: _update,
                  delete: _delete,
                );
              },
            ),
          ),
        ],
      )),
    ));
  }
}

class picres extends StatelessWidget {
  const picres({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFADADAD),
          ),
          child: Container(
            
            width: 350,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                          colors: [Colors.white, Colors.transparent],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter)
                      .createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: name.contains("KinKun")
                    ? Image.asset(
                        'assets/res1.jpg',
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/res2.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(top: 180),
            child: Text(name, style: Theme.of(context).textTheme.headline1))
      ],
    );
  }
}

class foodlist extends StatefulWidget {
  const foodlist({Key? key, required this.add}) : super(key: key);
  final Function add;
  @override
  State<foodlist> createState() => _foodlistState();
}

class _foodlistState extends State<foodlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("List Of Food", style: Theme.of(context).textTheme.headline2),
          addbut(add: widget.add),
        ],
      ),
    );
  }
}

class food extends StatefulWidget {
  const food(
      {Key? key,
      required this.name,
      required this.price,
      required this.update,
      required this.list,
      required this.delete,
      required this.isSoldOut,
      required this.pictureUrl})
      : super(key: key);
  final String name;
  final int price;
  final Function update;
  final String list;
  final Function delete;
  final bool isSoldOut;
  final String pictureUrl;
  // final void delete;
  @override
  State<food> createState() => _foodState();
}

class _foodState extends State<food> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 1.0,
          color: Colors.black,
        )),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFADADAD),
                  ),
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                                  colors: [Colors.white, Colors.transparent],
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter)
                              .createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: widget.pictureUrl != null
                            ? Image.network(
                                Constants.baseUrl + widget.pictureUrl,
                                fit: BoxFit.contain,
                                height: 150,
                              )
                            : Image.asset(
                                'assets/res2.png',
                                fit: BoxFit.contain,
                                height: 150,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(widget.price.toString(),
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  SizedBox(
                    width: 80,
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.update(widget.list.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: widget.isSoldOut ? Colors.red : Colors.orange,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Sold Out",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  )
                ],
              ),
              Material(
                child: IconButton(
                    onPressed: () {
                      widget.delete(widget.list.toString());
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.orange,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

class addbut extends StatefulWidget {
  const addbut({Key? key, required this.add}) : super(key: key);
  final Function add;
  @override
  State<addbut> createState() => _addbutState();
}

class _addbutState extends State<addbut> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddDialog(
              add: widget.add,
            ),
          );
        },
        icon: Icon(Icons.add),
      ),
    ));
  }
}

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key, required this.add}) : super(key: key);
  final Function add;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> with TickerProviderStateMixin {
  var name = TextEditingController();
  var price = TextEditingController();
  String imgpath = "";
  late File tmpFile;
  File? image;
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  void clearText() {
    name.clear();
    price.clear();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imgTemp = File(image.path);
      setState(() {
        imgpath = image.path;
        this.image = imgTemp;
      });
    } catch (e) {
      print("fail $e");
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 400,
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context, 'Close'),
                    icon: Icon(Icons.close),
                    color: Colors.black,
                  ),
                ),
                Text(
                  'ADD PRODUCT',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.restaurant),
                          label: Text('Name of product *'),
                        ),
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          return (value != null)
                              ? 'Please enter your product name'
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          icon: Icon(Icons.price_change),
                          label: Text('Price *'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        // padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.image,
                                color: Color.fromARGB(255, 127, 120, 120)),
                            Container(
                              margin: EdgeInsets.only(right: 15, left: 15),
                              child: ElevatedButton(
                                onPressed: () {
                                  pickImage();
                                },
                                child: Text("Add image"),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.only(
                                            bottom: 4,
                                            top: 4,
                                            left: 10,
                                            right: 10))),
                              ),
                            ),
                            image != null
                                ? Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )
                                : Text("No image selected"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.add(name.text.toString(),
                          int.parse(price.text.toString()), image);
                      clearText();
                      Navigator.pop(context, 'Close');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
