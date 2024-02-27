import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
class ProductDetails extends StatefulWidget {
  final Map<String,Object> product;
  const ProductDetails({super.key, required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize=0;
  void onTap(){
    if(selectedSize!=0) {
      Provider.of<CartProvider>(context, listen: false).addCart(
          {
            'id': widget.product['id'],
            'title': widget.product['title'],
            'price': widget.product['price'],
            'imageUrl': widget.product['imageUrl'],
            'company': widget.product['company'],
            'sizes': selectedSize,
          }
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!!'))
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your size!!'))
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details',
          style: Theme.of(context).appBarTheme.titleTextStyle,),
        ),
      body: Column(
        children:[
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String,
            height: 250,),
          ),
          const Spacer(flex: 2,),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(226, 231, 231, 1.0),
              borderRadius: BorderRadius.circular(40),
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('₹${widget.product['price']}',
                style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context,index){
                        final size=(widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize=size;
                              });
                            },
                            child: Chip(
                                label: Text(size.toString()),
                                 backgroundColor: selectedSize==size?
                                      Theme.of(context).colorScheme.primary :
                                  null,
                            ),
                          ),
                        );
                      },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                      onPressed:onTap,
                      icon: const Icon(Icons.shopping_cart,color: Colors.black,),
                      label: const Text('Add to Cart',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
