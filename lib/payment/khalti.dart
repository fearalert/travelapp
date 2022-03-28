import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/widgets/dialogbox.dart';
import 'package:travelapp/widgets/snackbar.dart';

class Payment extends StatefulWidget {
  static const String id = "/payment";
  final Map<String, dynamic>? args;
  const Payment({Key? key, this.args}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final phoneNumberController = TextEditingController();
  final transactionPinController = TextEditingController();
  final amountController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // amountController.text = widget.args!["amount"];
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    transactionPinController.dispose();
    amountController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 25.0,
            right: 25.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 45.0,
                ),
                Image.network(
                    "https://bolpatranepal.com/assets/khalti-logo.png"),
                const SizedBox(
                  height: 100.0,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            textController: phoneNumberController,
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            isNumber: true),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomTextField(
                            textController: amountController,
                            hintText: "Amount",
                            icon: Icons.payment_outlined,
                            isNumber: true),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomTextField(
                            textController: transactionPinController,
                            hintText: "Khalti Pin",
                            icon: Icons.password,
                            isNumber: false),
                        const SizedBox(
                          height: 70.0,
                        ),
                        CustomButton(
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const Center(
                                        child: DialogBox(
                                          title: "Processing",
                                        ),
                                      ));

                              await Khalti.init(
                                publicKey:
                                    "test_public_key_76063d06952d4cc48cee6fd516fe41b8",
                                enabledDebugging: false,
                              );
                              late PaymentInitiationResponseModel
                                  initiationModel;
                              try {
                                initiationModel =
                                    await Khalti.service.initiatePayment(
                                  request: PaymentInitiationRequestModel(
                                    // amount:
                                    //     int.parse(amountController.text * 100),
                                    amount:
                                        int.parse(amountController.text.trim()),
                                    mobile: phoneNumberController.text.trim(),
                                    transactionPin:
                                        transactionPinController.text.trim(),
                                    productIdentity: widget.args!["Travel"],
                                    productName: "travel",
                                  ),
                                );
                              } on FailureHttpResponse catch (ex) {
                                // navigatorKey.currentState!.pop();
                                Map<String, dynamic>? exceptionData =
                                    ex.data as Map<String, dynamic>;
                                return getSnackBar(
                                  message:
                                      exceptionData["tries_remaining"] == null
                                          ? exceptionData["detail"]
                                              .toString()
                                              .split(". ")[0]
                                          : exceptionData["detail"]
                                                  .toString()
                                                  .split(". ")[0] +
                                              " Tries Remaining: " +
                                              exceptionData["tries_remaining"],
                                  color: Colors.red,
                                );
                              }

                              // navigatorKey.currentState!.pop();
                              await showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Please enter the OTP you just received.",
                                          style: TextStyle(
                                            color: Color(0xff4C276C),
                                            // fontFamily: "Montserrat",
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        CustomTextField(
                                            textController: otpController,
                                            hintText: 'OTP',
                                            icon: Icons.lock,
                                            isNumber: true),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        CustomButton(
                                          width: double.infinity,
                                          color: const Color(0xff4C276C),
                                          height: 50.0,
                                          text: 'Confirm',
                                          ontap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  CircularProgressIndicator(
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                ],
                                              ),
                                            );
                                            try {
                                              final confirmationModel =
                                                  await Khalti.service
                                                      .confirmPayment(
                                                request:
                                                    PaymentConfirmationRequestModel(
                                                  confirmationCode: otpController
                                                      .text
                                                      .trim(), // the OTP code received through previous step
                                                  token: initiationModel.token,
                                                  transactionPin:
                                                      transactionPinController
                                                          .text
                                                          .trim(),
                                                ),
                                              );

                                              // ignore: todo
                                              //TODO: delete order;
                                              // await Database
                                              //     .orderCompleteTransaction(
                                              //   widget.args!["orderID"],
                                              //   widget.args!["car"],
                                              // );

                                              // navigatorKey.currentState!.pop();
                                              // navigatorKey.currentState!.pop();
                                              // navigatorKey.currentState!.pop();
                                              getSnackBar(
                                                message:
                                                    "Transaction Successful.",
                                                color: Colors.green,
                                              );
                                              print(confirmationModel.amount);
                                            } on FailureHttpResponse catch (ex) {
                                              // navigatorKey.currentState!.pop();
                                              print(ex.message);
                                              getSnackBar(
                                                message:
                                                    "OTP code doesnot match",
                                                color: Colors.red,
                                              );
                                            }
                                          },
                                          // width: double.infinity,
                                          // buttonColor: const Color(0xff4C276C),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          width: double.infinity,
                          color: const Color(0xff4C276C),
                          height: 50.0,
                          text: 'Confirm',
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
