import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/wiidgets/white_space.dart';
import '../../../core/resources/colours.dart';

class TaskExpansionTile extends StatefulWidget {
  const TaskExpansionTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.children,
    required this.color,
  });
  final String title;
  final String subTitle;
  final List<Widget> children;
  final Color color;

  @override
  State<TaskExpansionTile> createState() => _TaskExpansionTileState();
}

class _TaskExpansionTileState extends State<TaskExpansionTile> {
  final controller = ExpansionTileController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorsRes.lightBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (_) => setState(() {}),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80.0.h,
                  width: 5.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: widget.color,
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
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsRes.light,
                        ),
                      ),
                      Text(
                        widget.subTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          controller: controller,
          trailing: Builder(
            builder: (context) {
              final innerController = ExpansionTileController.of(context);
              return Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: innerController.isExpanded
                    ? const Icon(AntDesign.closecircleo)
                    : const Icon(
                        AntDesign.circledown,
                        color: Colors.white54,
                      ),
              );
            },
          ),
          children: widget.children,
        ),
      ),
    );
  }
}
