// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dicoding/src/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DetailPage extends StatefulWidget {
  final Product products;
  int carts;

  DetailPage({required this.carts, required this.products, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? imageNetwork;

  @override
  void initState() {
    super.initState();
    imageNetwork = widget.products.thumbnail;
    loadCartCount();
  }

  void imageSlide(String img) {
    setState(() {
      imageNetwork = img;
    });
  }

  void cartsBuy(int n) {
    widget.carts = n;
  }

  void loadCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.carts = prefs.getInt('cartCount') ?? 0;
     
    });
  }

  void saveCartCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartCount', count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(children: <Widget>[
            Image.network(
              imageNetwork!,
              width: MediaQuery.of(context).size.width,
              height: 360,
              fit: BoxFit.fitHeight,
            ),
            SafeArea(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      widget.carts != 0
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .red, // Warna latar belakang notifikasi
                                ),
                                child: Text(
                                  widget.carts
                                      .toString(), // Jumlah barang (sesuaikan dengan jumlah yang diinginkan)
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : Text(""),
                    ],
                  )
                ],
              ),
            )),
          ]),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 11,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.products.images!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      imageSlide(widget.products.images![index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 14,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        image: DecorationImage(
                            image: NetworkImage(widget.products.images![index]),
                            fit: BoxFit.cover),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 20,
                            color: Color.fromARGB(14, 90, 78, 78),
                          )
                        ],
                      ),
                    ));
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.products.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(widget.products.rating.toString() + " Review")
                          ],
                        ),
                      ],
                    ),
                    Text('\$${widget.products.price}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Description",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.products.description,
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 114, 114),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      wordSpacing: 2),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Stock",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.products.stock.toString() + " " + "Buah",
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 114, 114),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      wordSpacing: 2),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 15,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.amber,
            onPressed: () {
              setState(() {
                setState(() {
                  widget.carts++;
                  saveCartCount(widget.carts);
                });
              });
            },
            child: Text("Buy Now"),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
