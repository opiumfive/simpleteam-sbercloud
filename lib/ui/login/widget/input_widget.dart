import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SberTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String placeholder;
  final String text;
  final bool isPassword;

  const SberTextField(
      {Key key,
      this.onChanged,
      this.placeholder,
      this.text = "",
      this.isPassword = false})
      : super(key: key);

  @override
  _SberTextField createState() => _SberTextField();
}

class _SberTextField extends State<SberTextField> {
  final _controller = TextEditingController();
  bool _isObscure = false;

  final _textStyle = TextStyle(color: Color(0xBF000000), fontSize: 14.0);
  final _placeHolderStyle = TextStyle(color: Color(0x40060607), fontSize: 14.0);
  final _border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(4.0),
      gapPadding: 0.0);

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: PlatformTextField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.text,
        autocorrect: false,
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        style: _textStyle,
        cupertino: (_, __) => CupertinoTextFieldData(
            controller: _controller,
            style: TextStyle(color: Colors.black),
            placeholder: widget.placeholder),
        material: (_, __) => MaterialTextFieldData(
          controller: _controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
              hintText: widget.placeholder,
              hintStyle: _placeHolderStyle,
              fillColor: Color(0x75E9E9E9),
              filled: true,
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xFFdD2D2D2)),
                      onPressed: () {
                        setState(() {
                          this._isObscure = !this._isObscure;
                        });
                      },
                    )
                  : null),
        ),
      ),
    );
  }
}
