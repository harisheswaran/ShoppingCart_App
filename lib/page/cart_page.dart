import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
        style: Theme.of(context).appBarTheme.titleTextStyle,),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context,index){
            final cartItem=cart[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(context: context,
                      builder: (context) {
                          return AlertDialog(
                            title: Text('Delete Product',
                            style: Theme.of(context).textTheme.titleMedium,),
                            content: const Text('Are you sure want to delete this item?'),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.of(context).pop();
                              } ,
                                  child: const Text('No',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                              ),
                              TextButton(onPressed: () {
                                Provider.of<CartProvider>(context,listen: false).removeCart(cartItem);
                                Navigator.of(context).pop();
                              } ,
                                child: const Text('Yes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                      });
                },
                  icon: const Icon(Icons.delete,color: Colors.red,),
              ),
              title: Text(cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['sizes']}'),
            );
          }
      ),
    );
  }
}
