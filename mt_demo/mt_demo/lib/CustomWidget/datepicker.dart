import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'datepicker.g.dart';
@jsonWidget
abstract class _DatePickerBuilder extends JsonWidgetBuilder {
  const _DatePickerBuilder({
    required super.args,
  });

  @override
  DatePicker buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}