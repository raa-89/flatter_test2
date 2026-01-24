// screens/tolerances_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:test2/core/const.dart';
import 'package:test2/database/holeTolerances.dart';
import 'package:test2/database/shaftTolerances.dart';

class TolerancesPage extends StatefulWidget {
  const TolerancesPage({super.key});

  @override
  State<TolerancesPage> createState() => _TolerancesPageState();
}

class _TolerancesPageState extends State<TolerancesPage> {
  String _selectedSystem = 'system_shaft'; // 'system_shaft' или 'system_hole'
  String _selectedToleranceGroup = 'a'; // Группа допусков (a, b, c, и т.д.)
  String _selectedTolerance = 'a9'; // Конкретный допуск (a9, a10, и т.д.)
  double _selectedDiameter = 10.0;
  // ignore: non_constant_identifier_names
  final TextEditingController _Controller = TextEditingController();
  // Добавляем контроллеры для колес прокрутки
  late FixedExtentScrollController _groupScrollController;
  FixedExtentScrollController? _toleranceScrollController;

  // Получение доступных групп допусков (a, b, c, ...)
  List<String> get _availableToleranceGroups {
    return _selectedSystem == 'system_shaft'
        ? shaftTolerances.keys.toList()
        : holeTolerances.keys.toList();
  }

  // Получение доступных конкретных допусков внутри выбранной группы (a9, a10, ...)
  List<String>? get _availableTolerances {
    if (_selectedSystem == 'system_shaft') {
      return shaftTolerances[_selectedToleranceGroup]?.keys.toList();
    } else {
      return holeTolerances[_selectedToleranceGroup]?.keys.toList();
    }
  }

  void _initializeToleranceController() {
    if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
      final initialIndex = _availableTolerances!.indexOf(_selectedTolerance);
      _toleranceScrollController = FixedExtentScrollController(
        initialItem: initialIndex != -1 ? initialIndex : 0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Инициализируем выбранный допуск после того как доступные допуски загружены
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
        setState(() {
          _selectedTolerance = _availableTolerances!.first;
        });
      }
    });

    // Инициализируем контроллер группы
    _groupScrollController = FixedExtentScrollController(
      initialItem: _availableToleranceGroups.indexOf(_selectedToleranceGroup),
    );

    // Инициализируем контроллер допусков
    _initializeToleranceController();

    // Устанавливаем начальное значение из _selectedDiameter
    _Controller.text = _selectedDiameter.toStringAsFixed(0);
  }

  void _updateToleranceScrollController() {
    // Диспозим старый контроллер
    _toleranceScrollController?.dispose();

    // Создаем новый контроллер
    if (_availableTolerances != null && _availableTolerances!.isNotEmpty) {
      final initialIndex = _availableTolerances!.indexOf(_selectedTolerance);
      _toleranceScrollController = FixedExtentScrollController(
        initialItem: initialIndex != -1 ? initialIndex : 0,
      );
    } else {
      _toleranceScrollController = null;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _Controller.dispose();
    _groupScrollController.dispose();
    _toleranceScrollController?.dispose();
    super.dispose();
  }

  String _getDiameterRangeForTolerance(
    double diameter,
    String system,
    String group,
    String tolerance,
  ) {
    // Получаем все доступные диапазоны для данного допуска
    Map<String, List<double>>? availableRanges;

    if (system == 'system_shaft') {
      availableRanges = shaftTolerances[group]?[tolerance];
    } else {
      availableRanges = holeTolerances[group]?[tolerance];
    }

    if (availableRanges == null) return '3-6'; // fallback

    // Ищем подходящий диапазон
    final rangeKeys = availableRanges.keys.toList();
    for (final rangeKey in rangeKeys) {
      final range = _parseRange(rangeKey);
      if (diameter > range[0] && diameter <= range[1]) {
        return rangeKey;
      }
    }

    return ''; // fallback
  }

  List<double> _parseRange(String range) {
    final parts = range.split('-');
    return [double.parse(parts[0]), double.parse(parts[1])];
  }

  // Получение значений допуска
  List<double>? _getToleranceValues() {
    // final range = _getDiameterRange(_selectedDiameter);
    final range = _getDiameterRangeForTolerance(
      _selectedDiameter,
      _selectedSystem,
      _selectedToleranceGroup,
      _selectedTolerance,
    );

    if (_selectedSystem == 'system_shaft') {
      // Для вала: shaftTolerances[группа][допуск][диапазон]
      return shaftTolerances[_selectedToleranceGroup]?[_selectedTolerance]?[range];
    } else {
      // Для отверстия: holeTolerances[группа][допуск][диапазон]
      return holeTolerances[_selectedToleranceGroup]?[_selectedTolerance]?[range];
    }
  }

  @override
  Widget build(BuildContext context) {
    final toleranceValues = _getToleranceValues();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const AutoSizeText(
          'Допуски и посадки ЕСДП',
          style: TextStyle(fontSize: 22), // начальный размер
          minFontSize: 10, // минимальный размер
          maxLines: 2, // максимальное количество строк
          overflow: TextOverflow.ellipsis, // что делать если не помещается),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Результаты
            if (toleranceValues != null && toleranceValues.length >= 2) ...[
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выбранный допуск, мм',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: DopuskConst.heightSizedBox * 2),
                        Row(
                          children: [
                            Text(
                              _selectedDiameter.toStringAsFixed(3),
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            toleranceValues[1] > toleranceValues[0]
                                ? Column(
                                    children: [
                                      Text(
                                        toleranceValues[1].toStringAsFixed(3),
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        toleranceValues[0].toStringAsFixed(3),
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        toleranceValues[0].toStringAsFixed(3),
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        toleranceValues[1].toStringAsFixed(3),
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        // _ToleranceResultCard(
                        //   title: 'Нижнее отклонение',
                        //   value: toleranceValues[0],
                        //   unit: 'мм',
                        //   color: colorScheme.primary,
                        // ),
                        // const SizedBox(height: 12),
                        // _ToleranceResultCard(
                        //   title: 'Верхнее отклонение',
                        //   value: toleranceValues[1],
                        //   unit: 'мм',
                        //   color: colorScheme.secondary,
                        // ),
                        // const SizedBox(height: DopuskConst.heightSizedBox),
                        // Container(
                        //   padding: const EdgeInsets.all(12),
                        //   decoration: BoxDecoration(
                        //     color: colorScheme.primary.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Text(
                        //     'Диапазон: ${_selectedTolerance.toUpperCase()} '
                        //     '(${_getDiameterRangeForTolerance(_selectedDiameter, _selectedSystem, _selectedToleranceGroup, _selectedTolerance)} мм)',
                        //     style: textTheme.bodyMedium?.copyWith(
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else if (toleranceValues == null) ...[
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: SizedBox(
                      height: 90,
                      child: Text(
                        'Данные для выбранных параметров не найдены',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            // Выбор системы
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  //################ Column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Система',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SystemChoiceCard(
                        title: 'вала (h)',
                        subtitle: '',
                        isSelected: _selectedSystem == 'system_shaft',
                        onTap: () {
                          setState(() {
                            _selectedSystem = 'system_shaft';
                            _selectedToleranceGroup =
                                _availableToleranceGroups.first;
                            // Обновляем выбранный допуск после смены системы
                            if (_availableTolerances != null &&
                                _availableTolerances!.isNotEmpty) {
                              _selectedTolerance = _availableTolerances!.first;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SystemChoiceCard(
                        title: 'отверстия (H)',
                        subtitle: '',
                        isSelected: _selectedSystem == 'system_hole',
                        onTap: () {
                          setState(() {
                            _selectedSystem = 'system_hole';
                            _selectedToleranceGroup =
                                _availableToleranceGroups.first;
                            // Обновляем выбранный допуск после смены системы
                            if (_availableTolerances != null &&
                                _availableTolerances!.isNotEmpty) {
                              _selectedTolerance = _availableTolerances!.first;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Выбор диаметра
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Номинальный размер ${_selectedDiameter.toStringAsFixed(3)} мм',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _Controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ], // Разрешаем цифры, точки и запятые],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Введите номинальный размер',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final String normalizedValue = value.replaceAll(
                            ',',
                            '.',
                          );
                          final double? numericValue = double.tryParse(
                            normalizedValue,
                          );
                          setState(() {
                            _selectedDiameter = numericValue ?? 3.0;
                          });
                        }
                      },
                    ),
                    // Slider(
                    //   value: _selectedDiameter,
                    //   min: 3,
                    //   max: 80,
                    //   divisions: 77,
                    //   label: _selectedDiameter.toStringAsFixed(2),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedDiameter = value;
                    //     });
                    //   },
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('3 мм', style: textTheme.bodySmall),
                    //     Text(
                    //       '${_selectedDiameter.toStringAsFixed(3)} мм',
                    //       style: textTheme.titleMedium?.copyWith(
                    //         color: colorScheme.primary,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     Text('80 мм', style: textTheme.bodySmall),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Выбор группы допусков
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(DopuskConst.heightSizedBox),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Группа допусков',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: DopuskConst.heightSizedBox),
                    SizedBox(
                      height: 90, // Фиксированная высота для колеса прокрутки
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: ListWheelScrollView.useDelegate(
                          controller: _groupScrollController,
                          itemExtent: 80,
                          diameterRatio: 1.5,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            final selectedGroup =
                                _availableToleranceGroups[index];
                            setState(() {
                              _selectedToleranceGroup = selectedGroup;
                              // Сбрасываем выбранный допуск при смене группы
                              if (_availableTolerances != null &&
                                  _availableTolerances!.isNotEmpty) {
                                _selectedTolerance =
                                    _availableTolerances!.first;
                              }
                              _updateToleranceScrollController();
                            });
                          },
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List.generate(
                              _availableToleranceGroups.length,
                              (index) {
                                final group = _availableToleranceGroups[index];
                                final isSelected =
                                    _selectedToleranceGroup == group;

                                return RotatedBox(
                                  quarterTurns: 1,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      // decoration: BoxDecoration(
                                      //   color: isSelected
                                      //       ? const Color(
                                      //           0xFF667eea,
                                      //         ).withOpacity(0.1)
                                      //       : Colors.transparent,
                                      //   borderRadius: BorderRadius.circular(20),
                                      //   border: Border.all(
                                      //     color: isSelected
                                      //         ? const Color(0xFF667eea)
                                      //         : Colors.grey[300]!,
                                      //     width: isSelected ? 2 : 1,
                                      //   ),
                                      // ),
                                      child: Text(
                                        group,
                                        style: TextStyle(
                                          fontSize: isSelected ? 22 : 16,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? const Color(0xFF667eea)
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Card(
            //   elevation: 4,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Группа допусков',
            //           style: textTheme.titleMedium?.copyWith(
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         const SizedBox(height: 12),

            //         Wrap(
            //           spacing: 8,
            //           runSpacing: 8,
            //           children: _availableToleranceGroups.map((group) {
            //             return FilterChip(
            //               label: Text(group),
            //               selected: _selectedToleranceGroup == group,
            //               onSelected: (selected) {
            //                 setState(() {
            //                   _selectedToleranceGroup = group;
            //                   // Сбрасываем выбранный допуск при смене группы
            //                   if (_availableTolerances != null &&
            //                       _availableTolerances!.isNotEmpty) {
            //                     _selectedTolerance =
            //                         _availableTolerances!.first;
            //                   }
            //                 });
            //               },
            //             );
            //           }).toList(),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: DopuskConst.heightSizedBox),

            // Выбор конкретного допуска
            if (_availableTolerances != null &&
                _availableTolerances!.isNotEmpty)
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Квалитет',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableTolerances!.map((tolerance) {
                          return FilterChip(
                            label: Text(tolerance),
                            selected: _selectedTolerance == tolerance,
                            onSelected: (selected) {
                              setState(() {
                                _selectedTolerance = tolerance;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            const SizedBox(height: 24),

            // Информация о системе
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'О системе ЕСЦП',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedSystem == 'system_shaft'
                          ? 'Система вала - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков отверстий с полем допуска основного вала.'
                          : 'Система отверстия - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков валов с полем допуска основного отверстия.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SystemChoiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _SystemChoiceCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
              // const SizedBox(height: 4),
              // Text(
              //   subtitle,
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: isSelected
              //         ? colorScheme.onPrimaryContainer.withOpacity(0.8)
              //         : colorScheme.onSurface.withOpacity(0.6),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _ToleranceResultCard extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final Color color;

  const _ToleranceResultCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: color.withOpacity(0.1),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              '${value.toStringAsFixed(3)} $unit',
              style: textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TolerancesPage extends StatefulWidget {
//   const TolerancesPage({super.key});

//   @override
//   State<TolerancesPage> createState() => _TolerancesPageState();
// }

// class _TolerancesPageState extends State<TolerancesPage> {
//   String _selectedSystem = 'system_shaft'; // 'system_shaft' или 'system_hole'
//   String _selectedToleranceGrup = 'a';
//   String _selectedTolerance = 'a9';
//   double _selectedDiameter = 10.0;

//   List<String>? get _availableTolerances {
//     return _selectedSystem == 'system_shaft'
//         ? shaftTolerances[_selectedToleranceGrup]?.keys.toList()
//         : holeTolerances[_selectedToleranceGrup]?.keys.toList();
//   }

//   List<String> get _availableTolerancesGrup {
//     return _selectedSystem == 'system_shaft'
//         ? shaftTolerances.keys.toList()
//         : holeTolerances.keys.toList();
//   }

//   String _getDiameterRange(double diameter) {
//     if (diameter <= 3) return '0-3';
//     if (diameter <= 6) return '3-6';
//     if (diameter <= 10) return '6-10';
//     if (diameter <= 14) return '10-14';
//     if (diameter <= 18) return '14-18';
//     if (diameter <= 24) return '18-24';
//     if (diameter <= 30) return '24-30';
//     if (diameter <= 40) return '30-40';
//     if (diameter <= 50) return '40-50';
//     if (diameter <= 65) return '50-65';
//     if (diameter <= 80) return '65-80';
//     if (diameter <= 100) return '80-100';
//     if (diameter <= 120) return '100-120';
//     if (diameter <= 140) return '120-140';
//     if (diameter <= 160) return '140-160';
//     if (diameter <= 180) return '160-180';
//     if (diameter <= 200) return '180-200';
//     if (diameter <= 225) return '200-225';
//     if (diameter <= 250) return '225-250';
//     if (diameter <= 280) return '250-280';
//     if (diameter <= 315) return '280-315';
//     if (diameter <= 355) return '315-355';
//     if (diameter <= 400) return '355-400';
//     if (diameter <= 450) return '400-450';
//     if (diameter <= 500) return '450-500';
//     if (diameter <= 560) return '500-560';
//     if (diameter <= 630) return '560-630';
//     if (diameter <= 710) return '630-710';
//     if (diameter <= 800) return '710-800';
//     if (diameter <= 900) return '800-900';
//     if (diameter <= 1000) return '900-1000';
//     if (diameter <= 1120) return '1000-1120';
//     if (diameter <= 1250) return '1120-1250';
//     if (diameter <= 1400) return '1250-1400';
//     if (diameter <= 1600) return '1400-1600';
//     if (diameter <= 1800) return '1600-1800';
//     if (diameter <= 2000) return '1800-2000';
//     if (diameter <= 2240) return '2000-2240';
//     if (diameter <= 2500) return '2240-2500';
//     if (diameter <= 2800) return '2500-2800';
//     if (diameter <= 3150) return '2800-3150';

//     return '3150+';
//   }

//   // Map<String, List<double>>? _availableTolerances() {
//   //   final tolerances = _selectedSystem == 'system_shaft'
//   //       ? shaftTolerances[_selectedToleranceGrup]
//   //       : holeTolerances[_selectedToleranceGrup];

//   //   return tolerances?[_selectedTolerance];
//   // }

//   List<double>? _getToleranceValues() {
//     final range = _getDiameterRange(_selectedDiameter);
//     final tolerances = _selectedSystem == 'system_shaft'
//         ? shaftTolerances[_selectedTolerance]
//         : holeTolerances[_selectedTolerance];

//     return tolerances?[_selectedToleranceGrup]?[range];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final toleranceValues = _getToleranceValues();
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Допуски посадок ЕСЦП'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [colorScheme.primary, colorScheme.primaryContainer],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Выбор системы
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Система посадки',
//                       style: textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _SystemChoiceCard(
//                             title: 'Система вала',
//                             subtitle: 'Основное отклонение h',
//                             isSelected: _selectedSystem == 'system_shaft',
//                             onTap: () {
//                               setState(() {
//                                 _selectedSystem = 'system_shaft';
//                                 _selectedTolerance =
//                                     _availableTolerancesGrup.first;
//                               });
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: _SystemChoiceCard(
//                             title: 'Система отверстия',
//                             subtitle: 'Основное отклонение H',
//                             isSelected: _selectedSystem == 'system_hole',
//                             onTap: () {
//                               setState(() {
//                                 _selectedSystem = 'system_hole';
//                                 _selectedTolerance =
//                                     _availableTolerancesGrup.first;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: DopuskConst.heightSizedBox),

//             // Выбор диаметра
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Диаметр, мм',
//                       style: textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Slider(
//                       value: _selectedDiameter,
//                       min: 3,
//                       max: 80,
//                       divisions: 77,
//                       label: _selectedDiameter.toStringAsFixed(1),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedDiameter = value;
//                         });
//                       },
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('3 мм', style: textTheme.bodySmall),
//                         Text(
//                           '${_selectedDiameter.toStringAsFixed(1)} мм',
//                           style: textTheme.titleMedium?.copyWith(
//                             color: colorScheme.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text('80 мм', style: textTheme.bodySmall),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: DopuskConst.heightSizedBox),

//             // Выбор квалитета
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Таблица предельных отклонений',
//                       style: textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: _availableTolerancesGrup.map((tolerance) {
//                         return FilterChip(
//                           label: Text(tolerance),
//                           selected: _selectedTolerance == tolerance,
//                           onSelected: (selected) {
//                             setState(() {
//                               _selectedTolerance = tolerance;
//                             });
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             // Выбор квалитета
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Квалитет',
//                       style: textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: _availableTolerances!.map((tolerance) {
//                         return FilterChip(
//                           label: Text(tolerance),
//                           selected: _selectedTolerance == tolerance,
//                           onSelected: (selected) {
//                             setState(() {
//                               _selectedTolerance = tolerance;
//                             });
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Результаты
//             if (toleranceValues != null) ...[
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Результаты расчета',
//                         style: textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: DopuskConst.heightSizedBox),
//                       _ToleranceResultCard(
//                         title: 'Нижнее отклонение',
//                         value: toleranceValues[0],
//                         unit: 'мм',
//                         color: colorScheme.primary,
//                       ),
//                       const SizedBox(height: 12),
//                       _ToleranceResultCard(
//                         title: 'Верхнее отклонение',
//                         value: toleranceValues[1],
//                         unit: 'мм',
//                         color: colorScheme.secondary,
//                       ),
//                       const SizedBox(height: DopuskConst.heightSizedBox),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: colorScheme.primary.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           'Диапазон: $_selectedTolerance '
//                           '(${_getDiameterRange(_selectedDiameter)} мм)',
//                           style: textTheme.bodyMedium?.copyWith(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],

//             const SizedBox(height: 24),

//             // Информация о системе
//             Card(
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'О системе ЕСЦП',
//                       style: textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       _selectedSystem == 'system_shaft'
//                           ? 'Система вала - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков отверстий с полем допуска основного вала.'
//                           : 'Система отверстия - система допусков, в которой различные зазоры и натяги получаются сочетанием различных полей допусков валов с полем допуска основного отверстия.',
//                       style: textTheme.bodyMedium?.copyWith(
//                         color: colorScheme.onSurface.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SystemChoiceCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const _SystemChoiceCard({
//     required this.title,
//     required this.subtitle,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Card(
//       elevation: isSelected ? 4 : 1,
//       color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: isSelected
//                       ? colorScheme.onPrimaryContainer
//                       : colorScheme.onSurface,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: isSelected
//                       ? colorScheme.onPrimaryContainer.withOpacity(0.8)
//                       : colorScheme.onSurface.withOpacity(0.6),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ToleranceResultCard extends StatelessWidget {
//   final String title;
//   final double value;
//   final String unit;
//   final Color color;

//   const _ToleranceResultCard({
//     required this.title,
//     required this.value,
//     required this.unit,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Card(
//       color: color.withOpacity(0.1),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
//             ),
//             Text(
//               '${value.toStringAsFixed(3)} $unit',
//               style: textTheme.titleLarge?.copyWith(
//                 color: color,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
