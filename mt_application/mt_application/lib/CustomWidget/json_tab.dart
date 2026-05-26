import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_tab.g.dart';

@jsonWidget
abstract class _TabBuilder extends JsonWidgetBuilder {
  const _TabBuilder({
    required super.args,
  });

  @override
  Tab buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}
