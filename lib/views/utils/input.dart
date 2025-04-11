import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final String? tipoInput;
  const Input({
    required this.controller,
    required this.hintText,
    this.tipoInput,
    required this.obscure,
    super.key,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 3,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          child: TextField(
            obscureText: obscure,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding: EdgeInsets.only(left: 5),
              border: InputBorder.none,
            ),
          ),
        ),
        widget.tipoInput == "password"
            ? Positioned(
                right: 15,
                top: 15,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
