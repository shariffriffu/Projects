import 'package:flutter/gestures.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_tab_bar.g.dart';

@jsonWidget
abstract class _TabBarBuilder extends JsonWidgetBuilder {
  const _TabBarBuilder({
    required super.args,
  });

  @override
  TabBar buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}
