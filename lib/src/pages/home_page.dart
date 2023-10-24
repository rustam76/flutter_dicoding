
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dicoding/src/model/product.dart';
import 'package:flutter_dicoding/src/service/api_service.dart';
import 'package:flutter_dicoding/src/widget/container_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product>? _products = [];
  List<dynamic>? _category = [];
  int statusCurrentIndex = 0;
  var grid = 2;
  int carts = 0;
  void getDataProduct() async {
    _products = (await ApiService().fetchDataProduct())!;
    _category = await ApiService().categoryProduct();
    print(_category);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void searchDataProduct(String search) async {
    setState(() {
      if (search.isEmpty) {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => setState(() {}));
        getDataProduct();
      } else {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => setState(() {}));
        getSearch(search);
      }
    });
  }

  void getSearch(String search) async {
    _products = (await ApiService().searchData(search));
  }

  void setCategory(String category) async {
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    _products = (await ApiService().setCategoryData(category))!;
  }

  void loadCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      carts = prefs.getInt('cartCount') ?? 0;
      print(carts);
    });
  }

  

  @override
  void initState() {
    super.initState();
    getDataProduct();
    loadCartCount();
    // categoryDataProduct();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            grid = 2;
            // return grid;
          } else if (constraints.maxWidth <= 1200) {
            grid = 4;
          } else {
            grid = 6;
          }
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Elevtriv",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
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
                          carts != 0
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
                                      carts
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: TextField(
                    onChanged: searchDataProduct,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: width / 1.12,
                    height: height / 13,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _category!.length + 1,
                      itemBuilder: (contex, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              statusCurrentIndex = i;
                              if (i == 0) {
                                getDataProduct();
                              } else {
                                setCategory(_category![i - 1]);
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              // width: 120
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                ),
                                color: statusCurrentIndex == i
                                    ? Colors.amber
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    i == 0 ? "All" : _category![i - 1],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: statusCurrentIndex == i
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                _products == null || _products!.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ContainerCard(
                        gridCount: grid,
                        products: _products,
                        carts: carts,
                      )
              ],
            ),
          );
        }),
      );
    });
  }
}

class ContainerCategory extends StatefulWidget {
  final List<dynamic>? category;
  const ContainerCategory({required this.category, super.key});

  @override
  State<ContainerCategory> createState() => _ContainerCategoryState();
}

class _ContainerCategoryState extends State<ContainerCategory> {
  int statusCurrentIndex = 0;
  List<dynamic>? category = [];
  void seTcetogory() {
    setState(() {
      getDataProduct();
    });
  }

  void getDataProduct() async {
    // _products = (await ApiService().fetchDataProduct())!;
    category = await ApiService().categoryProduct();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: width / 1.12,
        height: height / 13,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.category!.length,
          itemBuilder: (contex, i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  statusCurrentIndex = i;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  // width: 120
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400]!,
                    ),
                    color:
                        statusCurrentIndex == i ? Colors.amber : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.category![i],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: statusCurrentIndex == i
                                ? Colors.white
                                : Colors.black,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
