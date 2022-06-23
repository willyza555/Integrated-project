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
import 'package:sheepper/services/api/order.dart';
import 'package:sheepper/services/api/product.dart';
import 'package:sheepper/services/provider/order_detail_list.dart';
import 'package:sheepper/services/provider/order_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/button.dart';
import 'package:sheepper/widgets/common/oreder_detail_card.dart';

class Order extends StatefulWidget {
  const Order({Key? key, this.args}) : super(key: key);
  final Map<String, dynamic>? args;
  static const routeName = "/order";

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool isLoading = true;
  late OrderModel order;

  Future<void> _getOrder() async {
    Provider.of<OrderDetailListProvider>(context, listen: false)
        .changeLoadState(true);
    try {
      var result = await OrderApi.getOrder("62af6e1068e9dd0d9ab5b448");
      if (result is InfoResponse) {
        setState(() {
          order = OrderModel.fromJson(result.data["order"]);
          var temp = result.data["order_detail"]
              .map<OrderDetailModel>((e) => OrderDetailModel.fromJson(e));

          if (temp != null) {
            Provider.of<OrderDetailListProvider>(context, listen: false)
                .updateList([...temp]);
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
      Provider.of<OrderDetailListProvider>(context, listen: false)
          .orderDetailList
          .forEach((e) async {
        var result = await ProductApi.getProductInfo(e.product_id);
        if (result is InfoResponse) {
          Provider.of<UpdateProductOfOrder>(context, listen: false)
              .updateAmountOfProduct(ProductForm.fromJson(result.data));
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
        _getOrder();
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
              color: Colors.red[100],
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
                            'Order 11',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            '${Provider.of<OrderDetailListProvider>(context, listen: false).orderDetailList.length} order',
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
                      itemCount: Provider.of<UpdateProductOfOrder>(context,
                              listen: false)
                          .product
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Provider.of<UpdateProductOfOrder>(context,
                                      listen: false)
                                  .product
                                  .isEmpty
                              ? const Center(child: Text("No product"))
                              : OrderDetailCard(
                                  orderDetail:
                                      Provider.of<OrderDetailListProvider>(
                                              context,
                                              listen: false)
                                          .orderDetailList[index],
                                  productDetail:
                                      Provider.of<UpdateProductOfOrder>(context,
                                                  listen: false)
                                              .product[
                                          (Provider.of<UpdateProductOfOrder>(
                                                          context,
                                                          listen: false)
                                                      .product
                                                      .length -
                                                  1) -
                                              index],
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
