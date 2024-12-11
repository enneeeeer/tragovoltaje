import 'package:TragoVoltaje/firebase_options.dart';
import 'package:flutter/material.dart';  
import 'package:firebase_core/firebase_core.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:firebase_auth/firebase_auth.dart';  

void main() async {  
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());  
}  

class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Compras In-App',  
      home: MembershipScreen(),  
    );  
  }  
}  

class MembershipScreen extends StatefulWidget {  
  @override  
  _MembershipScreenState createState() => _MembershipScreenState();  
}  

class _MembershipScreenState extends State<MembershipScreen> {  
  List<ProductDetails> products = [];  
  final String membershipId = "premium_monthly"; // Cambia a tu ID de producto  

  @override  
  void initState() {  
    super.initState();  
    _initializeInAppPurchase();  
    _listenToPurchaseUpdated();  
  }  

  Future<void> _initializeInAppPurchase() async {  
    final bool available = await InAppPurchase.instance.isAvailable();  
    if (available) {  
      _loadProducts();  
    }  
  }  

  Future<void> _loadProducts() async {  
    Set<String> ids = <String>{membershipId}; // Aquí agrega todos los IDs de tus productos  
    ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(ids);  
    if (response.notFoundIDs.isEmpty) {  
      setState(() {  
        products = response.productDetails;  
      });  
    }  
  }  

  void _listenToPurchaseUpdated() {  
    InAppPurchase.instance.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {  
      _processPurchase(purchaseDetailsList);  
    });  
  }  

  Future<void> _processPurchase(List<PurchaseDetails> purchaseDetailsList) async {  
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {  
      if (purchaseDetails.status == PurchaseStatus.purchased) {  
        // Almacena la información en Firestore  
        await FirebaseFirestore.instance.collection('memberships').doc(purchaseDetails.purchaseID).set({  
          'id_usuario': FirebaseAuth.instance.currentUser?.uid, // Almacena el ID del usuario  
          'tipo_membresia': purchaseDetails.productID,  
          'fecha_compra': Timestamp.now(),  
          'fecha_vencimiento': Timestamp.fromDate(DateTime.now().add(Duration(days: 30))), // Cambia según el tipo de membresía  
        });  
      } else if (purchaseDetails.status == PurchaseStatus.error) {  
        // Maneja el error  
        print('Error en la compra: ${purchaseDetails.error}');  
      }  
    }  
  }  

  Future<bool> checkMembershipStatus() async {  
    final user = FirebaseAuth.instance.currentUser; 
    if (user == null) return false;  

    // Obtiene el documento de la membresía del usuario  
    DocumentSnapshot snapshot = await FirebaseFirestore.instance  
        .collection('memberships')  
        .doc(user.uid) // Asegúrate de que el ID del documento sea el correcto  
        .get();  

    if (snapshot.exists) {  
      Timestamp expiryDate = snapshot['fecha_vencimiento'];  
      return expiryDate.toDate().isAfter(DateTime.now());  
    }  
    return false;  
  }  

  Future<void> _purchaseProduct(ProductDetails product) async {  
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);  
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text('Membresía')),  
      body: FutureBuilder<bool>(  
        future: checkMembershipStatus(),  
        builder: (context, snapshot) {  
          if (snapshot.connectionState == ConnectionState.waiting) {  
            return Center(child: CircularProgressIndicator());  
          }  

          final isMember = snapshot.data ?? false;  

          return Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
              if (isMember) ...[  
                Text('¡Eres un miembro activo!', style: TextStyle(fontSize: 24)),  
                Text('¡Disfruta de tu aplicación sin anuncios!'),  
              ] else ...[  
                Text('No eres miembro', style: TextStyle(fontSize: 24)),  
                Text('Compra una membresía para eliminar anuncios.'),  
                Expanded(  
                  child: ListView.builder(  
                    itemCount: products.length,  
                    itemBuilder: (context, index) {  
                      final product = products[index];  
                      return ListTile(  
                        title: Text(product.title),  
                        subtitle: Text(product.description),  
                        trailing: TextButton(  
                          child: Text('Comprar'),  
                          onPressed: () => _purchaseProduct(product),  
                        ),  
                      );  
                    },  
                  ),  
                ),  
              ],  
            ],  
          );  
        },  
      ),  
    );  
  }  
}  