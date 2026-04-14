import 'package:flutter/material.dart';

class PeptideAttribute {
  final String label;
  final String value;

  const PeptideAttribute({required this.label, required this.value});
}

class Peptide {
  final String name;
  final String category;
  final String categoryTag;
  final String casNumber;
  final String description;
  final Color tagColor;
  final Color tagBgColor;
  final List<PeptideAttribute> attributes;

  const Peptide({
    required this.name,
    required this.category,
    required this.categoryTag,
    required this.casNumber,
    required this.description,
    required this.tagColor,
    required this.tagBgColor,
    required this.attributes,
  });
}
