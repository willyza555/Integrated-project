import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/models/order.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/api/order.dart';
import 'package:sheepper/services/provider/history_order_detail_list.dart';
import 'package:sheepper/services/provider/order_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/order_card.dart';

class HistoryOrderList extends StatefulWidget {
  const HistoryOrderList({Key? key}) : super(key: key);
  static const routeName = "/history";

  @override
  State<HistoryOrderList> createState() => _HistoryOrderListState();
}

class _HistoryOrderListState extends State<HistoryOrderList> {
  bool isLoading = true;
  late dynamic realResult;
  Future<void> _gethistoryorder() async {
    Provider.of<OrderListProvider>(context, listen: false)
        .changeLoadState(true);
    try {
      var result = await OrderApi.getBigHistoryOrder();

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
    _gethistoryorder();

    Provider.of<HistoryOrderDetailListProvider>(context, listen: false)
        .deleteList();
    Provider.of<UpdateProductOfOrder>(context, listen: false).deleteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/orderlist.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        color: Colors.orange[400],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("History orders",
                  style: Theme.of(context).textTheme.headline1),
              Divider(
                color: Color.fromARGB(255, 3, 25, 44),
                thickness: 2,
              ),
              Expanded(
                child: realResult["orders"] != null
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: realResult["orders"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderCard(
                            order: OrderModel.fromJson(
                                realResult["orders"][index],
                                realResult["customer"][index]),
                            showInfoHandler: _showInfo,
                          );
                        },
                      )
                    : Text("no order"),
              )
            ]),
      ),
    );
  }

  void _showInfo(String id) {
    // Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
    //   'id': id,
    // });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondRoute()),
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
