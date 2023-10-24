import 'package:flutter/material.dart';

class ContainerItem extends StatefulWidget {
  final String title;
  final String image;
  final int price;
  final Function()? onTap;
  const ContainerItem({
    Key? key,
    required this.price,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ContainerItem> createState() => _ContainerItemState();
}
class _ContainerItemState extends State<ContainerItem> {
  bool lov = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(widget.image), fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 20,
              color: Color.fromARGB(14, 90, 78, 78),
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(126, 0, 0, 0),
                    Color.fromARGB(168, 48, 39, 39)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(4),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          lov = !lov;
                        });
                      },
                      icon: Icon(
                        lov ? Icons.favorite : Icons.favorite_border,
                        color: lov ?  Colors.red  : Colors.pink ,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text('\$${widget.price}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
