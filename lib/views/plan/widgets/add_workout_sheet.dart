import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/plan_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
class AddWorkoutSheet extends StatefulWidget {
  final DateTime date;

  const AddWorkoutSheet({
    super.key,
    required this.date,
  });

  @override
  State<AddWorkoutSheet> createState() => _AddWorkoutSheetState();
}

class _AddWorkoutSheetState extends State<AddWorkoutSheet> {
  final _titleController = TextEditingController();

  WorkoutType _selectedType = WorkoutType.arms;
  int _minDuration = 20;
  int _maxDuration = 30;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveWorkout() {
    final controller = context.read<PlanController>();

    controller.addWorkout(
      date: widget.date,
      title: _titleController.text,
      type: _selectedType,
      minDuration: _minDuration,
      maxDuration: _maxDuration,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PlanController>();
    final dateLabel = controller.formatSheetDate(widget.date);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surface3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'New Workout · $dateLabel',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            autofocus: true,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Workout name…',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.surface2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: WorkoutType.values.map((type) {
                final isSelected = _selectedType == type;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedType = type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? type.bgColor : AppColors.surface2,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? type.color.withOpacity(0.4)
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            type.icon,
                            size: 14,
                            color: isSelected
                                ? type.color
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? type.color
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Duration: ${_minDuration}m – ${_maxDuration}m',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          RangeSlider(
            values: RangeValues(
              _minDuration.toDouble(),
              _maxDuration.toDouble(),
            ),
            min: 5,
            max: 90,
            divisions: 17,
            activeColor: _selectedType.color,
            inactiveColor: AppColors.surface3,
            onChanged: (value) {
              setState(() {
                _minDuration = value.start.round();
                _maxDuration = value.end.round();
              });
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveWorkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.arms,
                foregroundColor: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add Workout',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}