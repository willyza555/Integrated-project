import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheepper/models/order.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final Function showInfoHandler;

  const OrderCard({
    Key? key,
    required this.order,
    required this.showInfoHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(14);
    final TextStyle detailStyle = GoogleFonts.poppins(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );

    return InkWell(
      onTap: () => showInfoHandler(order.order_id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: double.maxFinite,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Color.fromARGB(81, 255, 255, 255).withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 48, // Image radius
                      backgroundImage: NetworkImage(
                          'https://www.harley-davidson.com/content/dam/h-d/images/product-images/bikes/motorcycle/2022/2022-low-rider-st/gallery/2022-low-rider-st-motorcycle-g2.jpg'),
                    ),
                    Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                          ),
                          child: Text(
                            "Order ${order.seq}",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text("Rider Id : ${order.rider_id!.substring(19)}",
                            style: detailStyle),
                        Flexible(
                          child: Text(
                              "Customer: ${order.firstname} ${order.lastname}",
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: detailStyle),
                        ),
                        Text("Total : ${order.total}", style: detailStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
