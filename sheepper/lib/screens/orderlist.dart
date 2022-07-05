import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/models/order.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/screens/order_detail.dart';
import 'package:sheepper/services/api/order.dart';
import 'package:sheepper/services/provider/order_detail_list.dart';
import 'package:sheepper/services/provider/order_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/order_card.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);
  static const routeName = "/orderlist";

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool isLoading = true;
  dynamic realResult = [];
  Timer? timer;


  Future<void> _getorder() async {
    Provider.of<OrderListProvider>(context, listen: false)
        .changeLoadState(true);
    try {
      var result = await OrderApi.getBigOrder();

      if (result is InfoResponse) {
        setState(() {
          realResult = result.data;
        });

        Provider.of<OrderListProvider>(context, listen: false)
            .changeLoadState(false);

        // print("2");
        // print(Provider.of<OrderListProvider>(context, listen: true).orders);
      }
    } on DioError catch (e) {
      print(e);
      Alert.errorAlert(e, context).then((value) => null);
      Provider.of<OrderListProvider>(context, listen: false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getorder().then((value) => Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        isLoading = false;
      });
    }).then((value) =>timer =
        Timer.periodic(Duration(milliseconds: 500), (Timer t) => _getorder())));
    
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading? Center( child: CircularProgressIndicator()) : Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/orderlist.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order list", style: Theme.of(context).textTheme.headline1),
              Divider(
                color: Color.fromARGB(255, 3, 25, 44),
                thickness: 2,
              ),
              Expanded(
                  child: realResult["orders"] != null
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: realResult["orders"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderCard(
                              order: OrderModel.fromJson(
                                  realResult["orders"][index],
                                  realResult["customer"][index] ??
                                      realResult["customer"]
                                          [realResult["customer"].length - 1]),
                              showInfoHandler: _showInfo,
                            );
                          },
                        )
                      : Text("no order"))
            ]),
      ),
    );
  }

  void _showInfo(String id) {
    // Navigator.of(context).pushNamed(OrderDetail.routeName, arguments: {
    //   'id': id,
    // });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetail(id: id)),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
