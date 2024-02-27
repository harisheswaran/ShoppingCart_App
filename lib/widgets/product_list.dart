import 'package:flutter/material.dart';
import 'package:tutorial3/page/product_details.dart';
import 'package:tutorial3/widgets/products_card.dart';

import '../global_variables.dart';


class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters=const [
    'All',
    'Sparx',
    'Nike',
    'Adidas',
    'Bata',
    'Puma'
  ];
  late String selectedFilters;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFilters=filters[0];
  }
  @override
  Widget build(BuildContext context) {
    const border= OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(40))
    );
    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child:Text(
                    'Shoe\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child:ListView.builder(
                  itemCount: filters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    final filter=filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFilters=filter;
                          });
                        },
                        child:Chip(
                          backgroundColor: selectedFilters==filter?
                          Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(245, 247, 249, 1),
                          side:const BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          label: Text(filter),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ) ,
                      ),
                    );
                  }
              ) ,
            ),
            Expanded(
              child: LayoutBuilder(
                  builder: (context,constraints){
                    if(constraints.maxWidth>650){
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context,index){
                            final product=products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context){
                                          return ProductDetails(product: product);
                                        }
                                    )
                                );
                              },
                              child: ProductCard(
                                title: product['title'] as String,
                                price: product['price'] as double,
                                image: product['imageUrl'] as String,
                                bgcolor: index.isEven ? const Color.fromRGBO(204, 237, 250, 1.0):
                                const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            );
                          }
                      );
                    }
                    else{
                      return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context,index){
                              final product=products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context){
                                            return ProductDetails(product: product);
                                          }
                                      )
                                  );
                                },
                                child: ProductCard(
                                  title: product['title'] as String,
                                  price: product['price'] as double,
                                  image: product['imageUrl'] as String,
                                  bgcolor: index.isEven ? const Color.fromRGBO(204, 237, 250, 1.0):
                                  const Color.fromRGBO(245, 247, 249, 1),
                                ),
                              );
                            },
                          );
                     }
                  }
              ),
            )
          ],
        )
    );
  }
}
