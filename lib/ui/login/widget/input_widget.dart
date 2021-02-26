import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SberTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String placeholder;
  final bool isPassword;

  const SberTextField({Key key, this.onChanged, this.placeholder, this.isPassword = false}) : super(key: key);

  @override
  _SearchFieldWidget createState() => _SearchFieldWidget();
}

class _SearchFieldWidget extends State<SberTextField> {
  bool _showPassword = false;

  final _textStyle = TextStyle(color: Color(0xBF000000), fontSize: 14.0);
  final _placeHolderStyle = TextStyle(color: Color(0x40060607), fontSize: 14.0);
  final _border = OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(4.0), gapPadding: 0.0);

  //BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Color(0x75E9E9E9)), width: 300.0, height: 40.0)
  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: widget.isPassword,
      onChanged: widget.onChanged,
      style: _textStyle,
      cupertino: (_, __) => CupertinoTextFieldData(
          style: TextStyle(color: Colors.black),
          placeholder: widget.placeholder),
      material: (_, __) => MaterialTextFieldData(
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: _placeHolderStyle,
          fillColor: Color(0x75E9E9E9),
          filled: true,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
                widget.isPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white),
            onPressed: () {
              setState(() {
                this._showPassword = !this._showPassword;
              });
            },
          ): null
        ),
      ),
    );
  }
}