import 'package:amazone_clonee/common/widgets/stars.dart';
import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/product_detail/servics/productdetail_service.dart';
import 'package:amazone_clonee/feature/search/screen/searchscreen.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Productdetailscreen extends StatefulWidget {
  static const String routename = '/product-details';
  final Productmodel Product;
  const Productdetailscreen({super.key, required this.Product});

  @override
  State<Productdetailscreen> createState() => _ProductdetailscreenState();
}

class _ProductdetailscreenState extends State<Productdetailscreen> {
  double avgrating = 0;
  double myrating = 0;
  final ProductdetailService productdetailService = ProductdetailService();
  void navigatetosearchscreen(String query) {
    Navigator.pushNamed(context, Searchscreen.routename, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    print(widget.Product.rating!.length);
    for (int i = 0; i < widget.Product.rating!.length; i++) {
      print({"object"});
      totalRating += widget.Product.rating![i].rating;
      print("totalrating$totalRating");

      if (widget.Product.rating![i].userId ==
          Provider.of<User_Provider>(context, listen: false).user.id) {
        myrating = widget.Product.rating![i].rating;
        print("myarting$myrating");
      }

      if (totalRating != 0) {
        avgrating = totalRating / widget.Product.rating!.length;
      }
      print("avgrating$avgrating");
    }
  }

  void addToCart() {
    productdetailService.addToCart(context: context, Product: widget.Product);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatetosearchscreen,
                      // This method  takes argument query from onFieldSubmitted  function that passes a String of that Textformfield
                      // also can be used as this if new to this ;
                      // (String query) {
                      //   print(query);
                      // },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap:
                              () {}, // nothing happening on clicking the icon
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(top: 08),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        hintText: "Search Products",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.mic, color: Colors.black, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.Product.description),
                  Stars(rating: avgrating),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.Product.description,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            CarouselSlider(
              items: widget.Product.images.map((i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: size.height / 4,
                      width: size.width,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: size.height / 4,
              ),
            ),
            Container(color: Colors.black12, height: 8),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: "Deal Price: ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "\$${widget.Product.price}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.Product.description),
            ),
            Container(color: Colors.black12, height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width / 2 - 50,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(color: Colors.orangeAccent),
                  child: Text(
                    "Buy Now",
                    style: GoogleFonts.firaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: addToCart,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width / 2 - 60,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 222, 11),
                  ),
                  child: Text(
                    " Add To cart",
                    style: GoogleFonts.firaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rate The Product",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.orangeAccent),
              onRatingUpdate: (rating) {
                productdetailService.rateproduct(
                  context: context,
                  Product: widget.Product,
                  rating: rating,
                );
              },
              initialRating: myrating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ],
        ),
      ),
    );
  }
}
