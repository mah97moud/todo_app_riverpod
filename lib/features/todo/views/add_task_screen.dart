import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/filled_text_field.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/round_button.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/white_space.dart';
import 'package:todo_app_riverpod/core/utils/core_utils.dart';
import 'package:todo_app_riverpod/features/todo/app/task_date_provider.dart';

import '../../../core/resources/colours.dart';
import '../app/task_provider.dart';
import '../models/task_model.dart';

class AddOrEditTaskScreen extends StatefulHookConsumerWidget {
  const AddOrEditTaskScreen({
    Key? key,
    this.task,
  }) : super(key: key);

  final TaskModel? task;

  @override
  ConsumerState<AddOrEditTaskScreen> createState() =>
      _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends ConsumerState<AddOrEditTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.task != null) {
        ref.read(taskDateProvider.notifier).changeDate(widget.task!.date!);
        ref
            .read(taskStartDateProvider.notifier)
            .changeTime(widget.task!.startTime!);
        ref
            .read(taskEndDateProvider.notifier)
            .changeTime(widget.task!.endTime!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: widget.task?.title);
    final descriptionController = useTextEditingController(
      text: widget.task?.description,
    );

    final hintStyle = GoogleFonts.poppins(
      fontSize: 16.0,
      color: ColorsRes.lightGrey,
      fontWeight: FontWeight.w600,
    );
    final dateProvider = ref.watch(taskDateProvider);

    final taskDateNotifier = ref.read(taskDateProvider.notifier);
    final startTimeProvider = ref.watch(taskStartDateProvider);

    final taskStartDateNotifier = ref.read(taskStartDateProvider.notifier);
    final endTimeProvider = ref.watch(taskEndDateProvider);
    final taskEndDateNotifier = ref.read(taskEndDateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorsRes.light,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          shrinkWrap: true,
          children: [
            const WhiteSpace(height: 20.0),
            FilledTextField(
              controller: titleController,
              hintText: 'Add Title',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20.0),
            FilledTextField(
              controller: descriptionController,
              hintText: 'Add Description',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20.0),
            RoundButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime.now(),
                  maxTime: DateTime(DateTime.now().year + 1),
                  theme: DatePickerTheme(
                    doneStyle: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: ColorsRes.green,
                    ),
                  ),
                  onConfirm: (date) {
                    taskDateNotifier.changeDate(date);
                  },
                );
              },
              title:
                  dateProvider == null ? 'Set Date' : taskDateNotifier.date(),
              backgroundColor: ColorsRes.lightGrey,
              borderColor: ColorsRes.light,
            ),
            const WhiteSpace(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: 'Please select date',
                        );
                        return;
                      }
                      DatePicker.showTimePicker(
                        context,
                        showSecondsColumn: false,
                        theme: DatePickerTheme(
                          doneStyle: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: ColorsRes.green,
                          ),
                        ),
                        onConfirm: (date) {
                          taskStartDateNotifier.changeTime(date);
                        },
                      );
                    },
                    title: startTimeProvider == null
                        ? 'Start Time'
                        : taskStartDateNotifier.time(),
                    backgroundColor: ColorsRes.lightGrey,
                    borderColor: ColorsRes.light,
                  ),
                ),
                const WhiteSpace(width: 10.0),
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (startTimeProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: 'Please select start time first ',
                        );
                        return;
                      }
                      DatePicker.showTimePicker(
                        context,
                        showSecondsColumn: false,
                        theme: DatePickerTheme(
                          doneStyle: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: ColorsRes.green,
                          ),
                        ),
                        onConfirm: (date) {
                          taskEndDateNotifier.changeTime(date);
                        },
                      );
                    },
                    title: endTimeProvider == null
                        ? 'End Time'
                        : taskEndDateNotifier.time(),
                    backgroundColor: ColorsRes.darkGrey,
                    borderColor: ColorsRes.light,
                  ),
                ),
              ],
            ),
            const WhiteSpace(height: 20.0),
            RoundButton(
              onPressed: () async {
                if (titleController.text.trim().isNotEmpty &&
                    descriptionController.text.trim().isNotEmpty &&
                    startTimeProvider != null &&
                    endTimeProvider != null &&
                    dateProvider != null) {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();
                  final date = dateProvider;
                  final startTime = startTimeProvider;
                  final endTime = endTimeProvider;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context: context);
                  var taskModel = TaskModel(
                    id: widget.task?.id,
                    title: title,
                    description: description,
                    date: date,
                    startTime: startTime,
                    endTime: endTime,
                    repeat: widget.task != null ? widget.task!.repeat : true,
                    remind: widget.task != null ? widget.task!.remind : true,
                  );
                  if (widget.task == null) {
                    await ref.read(taskProvider.notifier).addTask(
                          taskModel,
                        );
                  } else {
                    await ref.read(taskProvider.notifier).updateTask(
                          taskModel,
                        );
                  }
                  navigator
                    ..pop()
                    ..pop();
                } else {
                  CoreUtils.showSnackBar(
                    context: context,
                    message: 'Please fill all fields',
                  );
                }
              },
              title: 'Submit',
              backgroundColor: ColorsRes.green,
              borderColor: ColorsRes.light,
            ),
          ],
        ),
      ),
    );
  }
}
