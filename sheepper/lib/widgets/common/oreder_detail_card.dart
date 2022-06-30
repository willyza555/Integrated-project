import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sheepper/models/order.dart';
import 'package:sheepper/models/product.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/api/product.dart';
import 'package:sheepper/services/provider/order_detail_list.dart';
import 'package:sheepper/services/provider/product_of_order_list.dart';
import 'package:sheepper/widgets/common/alert.dart';

class OrderDetailCard extends StatelessWidget {
  final OrderDetailModel orderDetail;
  final ProductForm1 productDetail;
  //final Function onDecrease;

  const OrderDetailCard({
    Key? key,
    required this.orderDetail,
    required this.productDetail,
    //required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var value = TextEditingController(text: "${orderDetail.quantity}");
    print(value);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/food.jpeg",
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productDetail.name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
          Text(
            "${orderDetail.quantity}",
            style: Theme.of(context).textTheme.headline2,
          ),
          // IconButton(
          //   icon: Icon(Icons.remove),
          //   onPressed: () {
          //     onDecrease(orderDetail);
          //   },
          // ),
        ],
      ),
    );
  }
}
