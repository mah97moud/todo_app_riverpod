import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/fading_text.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/white_space.dart';
import 'package:todo_app_riverpod/core/extensions/date_extensions.dart';
import 'package:todo_app_riverpod/core/resources/colours.dart';
import 'package:todo_app_riverpod/features/todo/models/task_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.task,
    this.onEdit,
    this.onDelete,
    required this.endIcon,
    this.bottomMargin,
  }) : super(key: key);

  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget endIcon;
  final double? bottomMargin;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final color = ColorsRes.randomColor();
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: bottomMargin == null
          ? null
          : EdgeInsets.only(bottom: bottomMargin!.h),
      decoration: BoxDecoration(
        color: ColorsRes.lightGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80.0.h,
                width: 5.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: color,
                ),
              ),
              const WhiteSpace(width: 15.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadingText(
                      task.title ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const WhiteSpace(height: 3.0),
                    FadingText(
                      task.description ?? '',
                      fontSize: 12.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const WhiteSpace(height: 10.0),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.h,
                            horizontal: 15.0.w,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsRes.darkBackground,
                            border: Border.all(
                              width: 0.3,
                              color: ColorsRes.darkGrey,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text(
                              '${task.startTime.timeOnly} |'
                              ' ${task.endTime.timeOnly}',
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                color: ColorsRes.light,
                              ),
                            ),
                          ),
                        ),
                        if (!task.isCompleted)
                          IconButton(
                            onPressed: onEdit,
                            icon: const Icon(
                              MaterialCommunityIcons.circle_edit_outline,
                              color: ColorsRes.light,
                            ),
                          ),
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            MaterialCommunityIcons.delete_circle,
                            color: ColorsRes.light,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          endIcon,
        ],
      ),
    );
  }
}
