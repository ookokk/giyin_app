import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/text_style.dart';

DropdownButtonHideUnderline StringDropdownButton(
    BuildContext context,
    String? selectedValue,
    List<String>? listOfClotheProperty,
    String whatKindOfItemWillYouSelect,
    void Function(String?) onChangedFunction) {
  return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
    isExpanded: true,
    hint: Row(
      children: [
        Expanded(
          child: Text(selectedValue ?? whatKindOfItemWillYouSelect,
              style: kMediumText, overflow: TextOverflow.ellipsis),
        )
      ],
    ),
    items: listOfClotheProperty!
        .map((String t) => DropdownMenuItem<String>(
            value: t,
            child:
                Text(t, style: kMediumText, overflow: TextOverflow.ellipsis)))
        .toList(),
    value: selectedValue,
    onChanged: onChangedFunction,
    buttonStyleData: ButtonStyleData(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black),
            color: CustomColors.kLightBlue),
        elevation: 2),
    iconStyleData: const IconStyleData(
      icon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      iconSize: 18,
      iconEnabledColor: Colors.yellow,
      iconDisabledColor: Colors.grey,
    ),
    dropdownStyleData: DropdownStyleData(
      maxHeight: 250,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: CustomColors.kKoyuBeyazBG,
      ),
      offset: const Offset(-20, 0),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(40),
        thickness: MaterialStateProperty.all<double>(6),
        thumbVisibility: MaterialStateProperty.all<bool>(true),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      height: 40,
      padding: EdgeInsets.only(left: 14, right: 14),
    ),
  ));
}
