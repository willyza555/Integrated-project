import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sheepper/services/constants.dart';

class MongoDatabase {
  static var db,
      orderCollection,
      restaurantColl,
      userColl,
      orderDetailColl,
      productColl;
  static connect() async {
    db = await Db.create(Constants.mongoConnUrl);
    await db.open();
    inspect(db);
    orderCollection = db.collection(Constants.orderCollection);
    restaurantColl = db.collection(Constants.rest);
    userColl = db.collection(Constants.user);
    orderDetailColl = db.collection(Constants.orderDetail);
    productColl = db.collection(Constants.product);
  }

  static steamData(email, context) async {
    var user = await userColl.findOne({'email': email});
    var rest = await restaurantColl.findOne({'owner_id': user['_id']});
    // print('user: $all_user');
    // print('rest: $all_rest');
    var stream = orderCollection.watch(<Map<String, Object>>[
      {
        r'$match': {'operationType': 'insert'}
      }
    ]);

    var controller = stream.listen((changeEvent) async {
      Map fullDocument = changeEvent.fullDocument;
      var orderDe = await orderDetailColl
          .find({'order_id': fullDocument['_id']}).toList();
      var food = [];
      // await orderDe.map((e) async =>
      //     print(await productColl.findOne({'_id': e['product_id']})));

      for (var i = 0; i < orderDe.length; i++) {
        var temp = await productColl.findOne({'_id': orderDe[i]['product_id']});
        if (temp != null) {
          food.add(temp);
        }
      }

      if (fullDocument['res_id'] == rest['_id']) {
        return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  title: Text('New order'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Order ID: ${fullDocument['seq']}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: ListView.builder(
                            itemCount: orderDe.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // food[index] != null
                                  Text(
                                    food[index]['name'] ?? 'null',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  //: Text('null'),
                                  //  orderDe[index] != null
                                  Text(
                                    orderDe[index]['quantity'].toString(),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  )
                                  // : Text('0')
                                ],
                              );
                            }),
                      ),
                      Text(
                        'Total: ${fullDocument['total']}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFF4141)),
                            onPressed: () async {
                              await orderCollection
                                  .remove(where.id(fullDocument['_id']));
                              await orderDetailColl
                                  .remove({'order_id': fullDocument['_id']});
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Text(
                              "Refuse",
                              style: Theme.of(context).textTheme.headline2,
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFFB941)),
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: Text(
                              "Accept",
                              style: Theme.of(context).textTheme.headline2,
                            )),
                      ],
                    ),
                  ],
                ));
      }
    });
  }
}
