import 'package:flutter/material.dart';
import 'package:sheepper/widgets/common/button.dart';
import 'package:sheepper/widgets/common/my_back_button.dart';
import 'package:sheepper/widgets/common/button.dart';

class productlist extends StatefulWidget {
  const productlist({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<productlist> createState() => _productlistState();
}

class _productlistState extends State<productlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            MyBackButton(),
            picres(),
            foodlist(),
            food(),
          ],
        ));
  }
}

class picres extends StatelessWidget {
  const picres({Key? key}) : super(key: key);

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
          child: 
          Container(
          width: 400,
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
                child: Image.asset(
                  'assets/res2.png',
                  fit: BoxFit.fill,
                )),
          ),
        ),
        ),
        
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(top: 180),
          child: Text("RES2",
              style: TextStyle(color: Colors.black, fontSize: 30.0)),
        )
      ],
    );
  }
}

class foodlist extends StatefulWidget {
  const foodlist({Key? key}) : super(key: key);

  @override
  State<foodlist> createState() => _foodlistState();
}

class _foodlistState extends State<foodlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "List Of Food",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          ElevatedButton(
            onPressed: null,
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class food extends StatefulWidget {
  const food({Key? key}) : super(key: key);

  @override
  State<food> createState() => _foodState();
}

class _foodState extends State<food> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/res2.png',
                width: 100,
                height: 100,
              ),
              Column(
                children: [
                  Text(
                    "name",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "100",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text("sold out"),
                  )
                ],
              ),
              ElevatedButton.icon(onPressed: null, icon: Icon(Icons.delete) , label:Text('delete'),),
            ],
          )
        ],
      ),
    );
  }
}
