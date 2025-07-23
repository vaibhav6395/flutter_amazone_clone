import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/adresses/services/adress_service.dart';
import 'package:amazone_clonee/globals.dart/applepay_paymentconfig.dart';
import 'package:amazone_clonee/globals.dart/gpay_pament_config.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class Adressscreen extends StatefulWidget {
  static const String routename = '/addressScreen';
  final String amount;
  const Adressscreen({super.key, required this.amount});

  @override
  State<Adressscreen> createState() => _AdressscreenState();
}

class _AdressscreenState extends State<Adressscreen> {
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController PincodeController = TextEditingController();
  TextEditingController Areacontroller = TextEditingController();
  TextEditingController citynameController = TextEditingController();
  final AdressService adressService = AdressService();

  final _adressFormKey = GlobalKey<FormState>();
  String adresstouse = "";

  @override
  void initState() {
    super.initState();
    paymentitems.add(
      PaymentItem(
        amount: widget.amount,
        label: "Total amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  List<PaymentItem> paymentitems = [];
  @override
  void dispose() {
    super.dispose();
    address1.dispose();
    address2.dispose();
    PincodeController.dispose();
    Areacontroller.dispose();
    citynameController.dispose();
  }

  void paypressed(String adressfromProvider) {
    print("Address from provider in paypressed: $adressfromProvider");
    bool isForm =
        address1.text.isNotEmpty ||
        address2.text.isNotEmpty ||
        PincodeController.text.isNotEmpty ||
        Areacontroller.text.isNotEmpty ||
        citynameController.text.isNotEmpty;
    if (isForm) {
      if (_adressFormKey.currentState!.validate()) {
        setState(() {
          adresstouse =
              "${address1.text}, ${address2.text}, ${PincodeController.text}, ${Areacontroller.text}, ${citynameController.text}";
        });
      }
    } else if (adressfromProvider.isNotEmpty) {
      setState(() {
        adresstouse = adressfromProvider;
      });
    }
    print("Address to use: $adresstouse");
  }

  void ongpayresult(res) {
    if (Provider.of<User_Provider>(
      context,
      listen: false,
    ).user.address.isEmpty) {
      adressService.saveUseAdress(context: context, Address: adresstouse);
    }
    adressService.placeOrder(
      context: context,
      Address: adresstouse,
      totalsum: double.parse(widget.amount),
    );
  }

  void onApplePayResult(res) {
    if (Provider.of<User_Provider>(
      context,
      listen: false,
    ).user.address.isEmpty) {
      adressService.saveUseAdress(context: context, Address: adresstouse);
    }
    adressService.placeOrder(
      context: context,
      Address: adresstouse,
      totalsum: double.parse(widget.amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var address = context.watch<User_Provider>().user.address;
    // adresstouse = address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: Text("Delivery Address"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'OR',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

            Form(
              key: _adressFormKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: size.height / 2 - 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.6,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Details ";
                            }
                            return null;
                          },

                          controller: address1,
                          decoration: InputDecoration(
                            hintText: "Flat/Building/House no. and $address",
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter details";
                            }
                            return null;
                          },

                          keyboardType: TextInputType.streetAddress,
                          controller: address2,
                          decoration: InputDecoration(
                            hintText: "Area/Street",
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Pincode";
                            }
                            return null;
                          },

                          controller: PincodeController,
                          decoration: InputDecoration(
                            hintText: "Pincode",
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Town City name";
                            }
                            return null;
                          },
                          controller: citynameController,
                          decoration: InputDecoration(
                            hintText: "Town/City  ",
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ApplePayButton(
              onPressed: () => paypressed(address),
              width: double.infinity,
              height: 50,
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                defaultApplePay,
              ),
              paymentItems: paymentitems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onApplePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

            GooglePayButton(
              onPressed: () => paypressed(address),
              width: double.infinity,
              height: 50,
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                defaultGooglePay,
              ),
              paymentItems: paymentitems,
              type: GooglePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: ongpayresult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
