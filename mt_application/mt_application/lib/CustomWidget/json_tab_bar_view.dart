import 'package:flutter/gestures.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_tab_bar_view.g.dart';

@jsonWidget
abstract class _TabBarViewBuilder extends JsonWidgetBuilder {
  const _TabBarViewBuilder({
    required super.args,
  });

  @override
  TabBarView buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}
