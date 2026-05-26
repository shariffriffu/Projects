import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_drawer.g.dart';

@jsonWidget
abstract class _DrawerBuilder extends JsonWidgetBuilder {
  const _DrawerBuilder({
    required super.args,
  });
 
  @override
  Drawer buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}
 
 
 