import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_elevation.dart';

class Country {
  final String name;
  final String code;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.flag,
  });
}

class PhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String fullNumber)? onChanged;
  final String? errorText;

  const PhoneField({
    super.key,
    this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late TextEditingController _controller;
  bool _focused = false;

  Country _selectedCountry = const Country(
    name: "Cameroon",
    code: "+237",
    flag: "🇨🇲",
  );

  final List<Country> _countries = const [
    Country(name: "Cameroon", code: "+237", flag: "🇨🇲"),
    Country(name: "Nigeria", code: "+234", flag: "🇳🇬"),
    Country(name: "Senegal", code: "+221", flag: "🇸🇳"),
    Country(name: "Côte d'Ivoire", code: "+225", flag: "🇨🇮"),
    Country(name: "Ghana", code: "+233", flag: "🇬🇭"),
    Country(name: "Morocco", code: "+212", flag: "🇲🇦"),
    Country(name: "Algeria", code: "+213", flag: "🇩🇿"),
  ];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  void _emitValue() {
    final full = "${_selectedCountry.code}${_controller.text}";
    widget.onChanged?.call(full);
  }

  void _openCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          children: _countries.map((c) {
            return ListTile(
              leading: Text(c.flag, style: const TextStyle(fontSize: 22)),
              title: Text(c.name),
              trailing: Text(c.code),
              onTap: () {
                setState(() => _selectedCountry = c);
                Navigator.pop(context);
                _emitValue();
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryGreen,
        borderRadius: AppRadius.input,
        border: Border.all(
          color: widget.errorText != null
              ? AppColors.error
              : _focused
              ? AppColors.primaryGreen
              : AppColors.border,
          width: 1.2,
        ),
        boxShadow: _focused
            ? AppElevation.greenGlow
            : AppElevation.level1,
      ),
      child: Row(
        children: [
          // COUNTRY SELECTOR
          GestureDetector(
            onTap: _openCountryPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppElevation.level1,
              ),
              child: Row(
                children: [
                  Text(_selectedCountry.flag),
                  const SizedBox(width: 6),
                  Text(
                    _selectedCountry.code,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // NUMBER INPUT
          Expanded(
            child: Focus(
              onFocusChange: (f) => setState(() => _focused = f),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                onChanged: (_) => _emitValue(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: "Numéro de téléphone",
                  border: InputBorder.none,
                  errorText: widget.errorText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}