import 'package:flutter/material.dart';
import '../../data/models/peptide_model.dart';
import 'widgets/library_widgets.dart';

class PeptideLibraryScreen extends StatefulWidget {
  const PeptideLibraryScreen({super.key});

  @override
  State<PeptideLibraryScreen> createState() => _PeptideLibraryScreenState();
}

class _PeptideLibraryScreenState extends State<PeptideLibraryScreen> {
  String selectedCategory = 'All';

  final List<Peptide> peptides = const [
    Peptide(
      name: 'BPC-157',
      category: 'Recovery',
      categoryTag: 'RESTORATIVE',
      casNumber: 'CAS 137525-51-0',
      description: 'Stable Gastric Pentadecapeptide. Optimized for tendon, ligament, and gastric mucosal repair through angiogenic pathways.',
      tagColor: Color(0xFF0058BC),
      tagBgColor: Color(0xFFEFF6FF),
      attributes: [
        PeptideAttribute(label: 'Standard Purity', value: '>99.2%'),
        PeptideAttribute(label: 'Molecular Weight', value: '1419.5 g/mol'),
        PeptideAttribute(label: 'Administration', value: 'Usage Method'),
      ],
    ),
    Peptide(
      name: 'CJC-1295',
      category: 'Performance',
      categoryTag: 'GH SECRETAGOGUE',
      casNumber: 'CAS 863288-34-0',
      description: 'GHRH Analog (DAC-modified). Enhances sustained plasma energy support levels for recovery and balance.',
      tagColor: Color(0xFF006687),
      tagBgColor: Color(0xFFECFEFF),
      attributes: [
        PeptideAttribute(label: 'Wellness', value: '6-8 Days (w/ DAC)'),
        PeptideAttribute(label: 'Purity Check', value: '>98.8%'),
        PeptideAttribute(label: 'Sequence', value: '29 Amino Acids'),
      ],
    ),
    Peptide(
      name: 'Ipamorelin',
      category: 'Wellness',
      categoryTag: 'GHRELIN MIMETIC',
      casNumber: 'CAS 170851-70-4',
      description: 'Selective GHSR Agonist. Stimulates natural GH pulses without elevating cortisol, prolactin, or appetite hormones.',
      tagColor: Color(0xFF9E3D00),
      tagBgColor: Color(0xFFFAF5FF),
      attributes: [
        PeptideAttribute(label: 'Selectivity', value: 'Highly Selective'),
        PeptideAttribute(label: 'Amount Form', value: 'Lyophilized Powder'),
        PeptideAttribute(label: 'Application', value: 'Vitality'),
      ],
    ),
    Peptide(
      name: 'GHK-Cu',
      category: 'Wellness',
      categoryTag: 'DERMAL REPAIR',
      casNumber: 'CAS 89030-95-5',
      description: 'Copper tripeptide-1. Promotes extracellular matrix remodeling, collagen synthesis, and stem cell protection.',
      tagColor: Color(0xFFEA580C),
      tagBgColor: Color(0xFFFFF7ED),
      attributes: [
        PeptideAttribute(label: 'Function', value: 'Epigenetic reset'),
        PeptideAttribute(label: 'Personal Focus', value: 'Wellness / Scalp'),
        PeptideAttribute(label: 'Solubility', value: 'Water Soluble'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPeptides = selectedCategory == 'All'
        ? peptides
        : peptides.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FE),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchFormulationBar(),
                  const SizedBox(height: 32),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        CategoryPill(
                          label: 'All',
                          isSelected: selectedCategory == 'All',
                          onTap: () => setState(() => selectedCategory = 'All'),
                        ),
                        const SizedBox(width: 12),
                        CategoryPill(
                          label: 'Recovery',
                          isSelected: selectedCategory == 'Recovery',
                          onTap: () => setState(() => selectedCategory = 'Recovery'),
                        ),
                        const SizedBox(width: 12),
                        CategoryPill(
                          label: 'Performance',
                          isSelected: selectedCategory == 'Performance',
                          onTap: () => setState(() => selectedCategory = 'Performance'),
                        ),
                        const SizedBox(width: 12),
                        CategoryPill(
                          label: 'Wellness',
                          isSelected: selectedCategory == 'Wellness',
                          onTap: () => setState(() => selectedCategory = 'Wellness'),
                        ),
                        const SizedBox(width: 12),
                        CategoryPill(
                          label: 'Cognitive',
                          isSelected: selectedCategory == 'Cognitive',
                          onTap: () => setState(() => selectedCategory = 'Cognitive'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...filteredPeptides.map((p) => PeptideDetailCard(peptide: p)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: PeptideLibraryHeader(
                onBack: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
