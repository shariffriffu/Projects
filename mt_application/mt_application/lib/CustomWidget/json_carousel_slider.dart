import 'package:carousel_slider/carousel_slider.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
part 'json_carousel_slider.g.dart';
@jsonWidget
abstract class _CarouselSliderBuilder extends JsonWidgetBuilder {
  const _CarouselSliderBuilder({
    required super.args,
  });

  @override
  CarouselSlider buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}