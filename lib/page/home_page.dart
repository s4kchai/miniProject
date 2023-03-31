import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/cart_model.dart';
import '../../../models/product.dart';
import 'package:finalproject/page/cartpage.dart';
import 'package:finalproject/page/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Widget> wiggets = [];
  List<ProductModel> productsModels = [];
  _HomePageState() : wiggets = [];
  List<ProductModel> cartItems = [];
  Stream<QuerySnapshot> getProducts() {
    return _firestore.collection('product').snapshots();
  }

  @override
  Widget _buildProductList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('product').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var document = snapshot.data!.docs[index];
            var model =
                ProductModel.fromMap(document.data() as Map<String, dynamic>);
            return createWidget(model, index);
          },
        );
      },
    );
  }

  Widget _buildFeaturedProduct({String? name, double? price, String? image}) {
    return ListView(
      children: [
        Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                height: 350,
                width: 260,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 290,
                      width: 160,
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage("images/$image")),
                      ),
                    ),
                    Text(
                      "\$ $price",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 171, 230, 210)),
                    ),
                    Text(
                      name!,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryProduct({String? image, int? color}) {
    return CircleAvatar(
      maxRadius: 42,
      backgroundColor: Color(color!),
      child: Container(
          height: 40,
          child: Image(
            // color: Colors.white,
            image: AssetImage("images/$image"),
          )),
    );
  }

  bool homeColor = true;
  bool cartColor = false;
  bool logoutColor = false;
  void getdata() {}

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp();
    print('inirialize Success');

    final snapshot = await _firestore.collection('product').get();
    productsModels = snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    wiggets = productsModels
        .asMap()
        .map((index, model) => MapEntry(index, createWidget(model, index)))
        .values
        .toList();

    setState(() {});
  }

  Widget createWidget(ProductModel model, int index) => Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 49, child: Image.network(model.cover)),
              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                model.name,
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
              // Text(model.price + '\฿'),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    cartItems.add(productsModels[index]); // add product to cart
                  });
                },
                color: Colors.green[200],
                child: Text(
                  'Add to Cart - ${model.price} ฿',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CartPage(cartItems: cartItems);
        })),
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_bag),
      ),
      key: _key,
      appBar: AppBar(
        title: const Text(
          'home',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.green[800],
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none, color: Colors.green[800])),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'logged in as  : ',
                style: TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  size: 70,
                  color: Colors.green[400],
                ),
                backgroundColor: Colors.green[200],
              ),
              decoration: BoxDecoration(color: Colors.green[200]),
              accountEmail: Text(
                user.email!,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            ListTile(
              selected: homeColor,
              onTap: () {
                setState(() {
                  homeColor = true;
                  cartColor = false;
                  logoutColor = false;
                });
              },
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              selected: cartColor,
              onTap: () {
                setState(() {
                  cartColor = true;
                  homeColor = false;
                  logoutColor = false;
                });
              },
              leading: Icon(Icons.history_edu),
              title: Text('History'),
            ),
            ListTile(
              selected: logoutColor,
              onTap: () {
                setState(() {
                  logoutColor = true;
                  homeColor = false;
                  cartColor = false;
                });
                FirebaseAuth.instance.signOut();
              },
              leading: Icon(
                Icons.logout_sharp,
                // color: Colors.grey[700],
              ),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
      body: wiggets.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.extent(
              maxCrossAxisExtent: 200,
              children: wiggets,
            ),
    );
  }
}
