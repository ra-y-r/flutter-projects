import 'package:flutter/material.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Products/components/cutom_input_field.dart';
import 'package:vend/screens/Raw%20Screen/raw_screen.dart';

class ProductEditingScreen extends StatelessWidget {
  const ProductEditingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScreen(
        Container: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInputFiled(
                hintText: "Product Name",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Price",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Description",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Image url",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Expire Date",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Quantity",
                onChanged: (value) {},
              ),
              CustomInputFiled(
                hintText: "Category Id",
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryLighterColor,
                      ),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryLighterColor,
                      ),
                    ),
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        AppBarTitle: "Product Editing");
  }
}
