import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorSection extends StatelessWidget {
  final TextEditingController priceOneTextController;
  final TextEditingController priceTwoTextController;
  final ConverterBloc converterBloc;
  final CalculatorBloc calculatorBloc;
  final TextFieldBloc textFieldBloc;
  const CalculatorSection(
      {Key key, this.converterBloc, this.calculatorBloc, this.textFieldBloc, this.priceOneTextController, this.priceTwoTextController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldBloc, TextFieldState>(
      cubit: textFieldBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('1', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '1';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                      } else {
                        priceTwoTextController.text += '1';
                      }
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('2', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '2';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '2';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text(
                    '3',
                    style: calcText,
                  ),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '3';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '3';
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('4', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '4';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '4';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('5', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '5';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '5';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('6', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '6';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '6';
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('7', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '7';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '7';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('8', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '8';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '8';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('9', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '9';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '9';
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('.', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text.contains('.') == true) {
                        priceOneTextController.text += '';
                      } else
                        priceOneTextController.text += '.';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text.contains('.') == true) {
                        priceTwoTextController.text += '';
                      } else
                        priceTwoTextController.text += '.';
                    }

                    print("$priceTwoTextController");
                    print("$priceOneTextController");
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  textTheme: ButtonTextTheme.normal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Text('0', style: calcText),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      if (priceOneTextController.text.length >= 16) {
                        priceOneTextController.text = 'null';
                      } else if (priceOneTextController.text == 'null') {
                        priceOneTextController.text = 'null';
                      } else
                        priceOneTextController.text += '0';
                    } else if (state is TextFieldTwoTapped) {
                      if (priceTwoTextController.text.length >= 16) {
                        priceTwoTextController.text = 'null';
                      } else if (priceTwoTextController.text == 'null') {
                        priceTwoTextController.text = 'null';
                      } else
                        priceTwoTextController.text += '0';
                    }
                  },
                ),
                MaterialButton(
                  minWidth: 127.h,
                  height: 127.h,
                  splashColor: Color(0xff6FA4FF),
                  highlightColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.backspace,
                    color: Color(0xffA1A7BB),
                  ),
                  onPressed: () {
                    if (state is TextFieldOneTapped) {
                      priceOneTextController.clear();
                    } else if (state is TextFieldTwoTapped) {
                      priceTwoTextController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
