import 'package:flutter/material.dart';
import 'package:flutter_application_1/serivces/provider/NightMode.dart';
import 'package:provider/provider.dart';

class CostumTextField extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final TextEditingController? controller;

  const CostumTextField({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isvisible = ValueNotifier<bool>(false);

    // final visibilityProvider =
    //     Provider.of<PassVisibilityProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ValueListenableBuilder(
        valueListenable: _isvisible,
        builder: (context, value, child) {
          return TextFormField(
            obscureText: !_isvisible.value,
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    _isvisible.value = !_isvisible.value;
                  },
                  child: _isvisible.value == false
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                prefixIcon: Icon(icon),
                hintText: text,
                // filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          );
        },
      ),
    );
  }
}

class TestFieldNoProvider extends StatelessWidget {
  final String? text;
  final IconData? icon;

  final TextEditingController? controller;
  const TestFieldNoProvider({
    super.key,
    required this.icon,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: text,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String? text;
  final VoidCallback? ontap;

  const RoundButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final providder = Provider.of<LoadingProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: ontap,
        child: Consumer<LoadingProvider>(
          builder: (context, value, child) {
            return Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: providder.isloading == true
                    ? Container(
                        child: const CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Text(
                        text!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
