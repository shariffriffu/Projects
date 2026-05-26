import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_prefersized_widjet.g.dart';
@jsonWidget
abstract class _preferred_sizeBuilder extends JsonWidgetBuilder {
  const _preferred_sizeBuilder({
    required super.args,
  });

  @override
  PreferredSize buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}