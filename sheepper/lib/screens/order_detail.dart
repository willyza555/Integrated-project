import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/models/order.dart';
import 'package:sheepper/models/product.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/screens/orderlist.dart';
import 'package:sheepper/services/api/order.dart';
import 'package:sheepper/services/api/product.dart';
import 'package:sheepper/services/provider/order_detail_list.dart';
import 'package:sheepper/services/provider/order_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/button.dart';
import 'package:sheepper/widgets/common/oreder_detail_card.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key, this.id}) : super(key: key);
  final String? id;
  static const routeName = "/order";

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool isLoading = true;
  late OrderModel order;
  List<OrderDetailModel> listData = [];
  List<ProductForm1> listProduct = [];

  Future<void> _getOrder() async {
    Provider.of<OrderDetailListProvider>(context, listen: false)
        .changeLoadState(true);
    //print(widget.args!['id']);
    try {
      //print(widget.args.toString());
      var result = await OrderApi.getOrder(widget.id!);

      if (result is InfoResponse) {
        setState(() {
          order =
              OrderModel.fromJson(result.data["order"], result.data["order"]);
          var temp = result.data["order_detail"]
              .map<OrderDetailModel>((e) => OrderDetailModel.fromJson(e));

          if (temp != null) {
            for (var i in result.data["order_detail"]) {
              listData.add(OrderDetailModel.fromJson(i));
            }
          }
          Provider.of<OrderDetailListProvider>(context, listen: false)
              .changeLoadState(false);
        });
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context).then((_) =>
          Provider.of<OrderDetailListProvider>(context, listen: false)
              .changeLoadState(false));
    }
  }

  Future<void> _getProduct() async {
    try {
      listData.forEach((e) async {
        var result = await ProductApi.getProductInfo(e.product_id);
        if (result is InfoResponse) {
          listProduct.add(ProductForm1.fromJson(result.data));
        }
      });
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  // Future<void> _decreaseAmount(OrderDetailModel data) async {
  //   try {
  //     Provider.of<OrderDetailListProvider>(context, listen: false)
  //         .orderDetailList
  //         .forEach((e) {
  //       if (e.product_id == data.product_id && e.order_id == data.order_id) {
  //         e.quantity = e.quantity - 1;
  //       }
  //     });
  //     var result = await OrderApi.updateOrder(
  //         Provider.of<OrderDetailListProvider>(context, listen: false)
  //             .orderDetailList);
  //     if (result is InfoResponse) {
  //       _getOrder();
  //     }
  //   } on DioError catch (e) {
  //     Alert.errorAlert(e, context);
  //   }
  // }

  Future<void> _doneOrder() async {
    try {
      var result = await OrderApi.doneOrder(order.order_id);

      if (result is InfoResponse) {
        Navigator.maybePop(context);
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getOrder().then((_) {
      _getProduct().then((_) => Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              isLoading = false;
            });
          }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: isLoading
          ? const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/orderlist.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ${order.seq}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            '${listData.length} order',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    color: Color(0xFF63448A),
                    height: 3,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5),
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: listData.isEmpty
                              ? const Center(child: Text("No product"))
                              : OrderDetailCard(
                                  orderDetail: listData[index],
                                  productDetail: listProduct[index],
                                  //onDecrease: _decreaseAmount,
                                ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: Color(0xFF63448A),
                    height: 3,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        '\$${order.total}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                    text: 'Done',
                    clickHandler: _doneOrder,
                  ),
                ],
              ),
            ),
    );
  }
}
