import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../utils/color/custom_color.dart';

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  State<ContactMeScreen> createState() => _ContactMeScreenState();
}

class _ContactMeScreenState extends State<ContactMeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();

  final _email = TextEditingController();

  final _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Name",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "name tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: _username,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: nicepink),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        hintText: "Your name",
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        fillColor: softdarkpurple,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Email",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: nicepink),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        hintText: "Your email",
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        fillColor: softdarkpurple,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.screenHeight * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Message",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      maxLength: 200,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Message tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: _message,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: nicepink),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        // hintText: "Username",
                        hintText: "Your Message",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: Theme.of(context).textTheme.labelSmall,

                        fillColor: softdarkpurple,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.screenHeight * 0.04,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _email.clear();
                          _message.clear();
                          _username.clear();

                          QuickAlert.show(
                            title: "Terkirim",
                            confirmBtnColor: nicepurple,
                            context: context,
                            type: QuickAlertType.success,
                            text:
                                'Pesan berhasil terkirim, terimakasih atas feedback anda 😄',
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: nicepurple,
                          foregroundColor: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Send Message"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
