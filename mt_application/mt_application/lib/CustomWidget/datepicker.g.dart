// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datepicker.dart';

// **************************************************************************
// Generator: JsonWidgetLibraryBuilder
// **************************************************************************

// ignore_for_file: avoid_init_to_null
// ignore_for_file: deprecated_member_use

// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: prefer_final_locals
// ignore_for_file: prefer_if_null_operators
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unused_local_variable

class DatePickerBuilder extends _DatePickerBuilder {
  const DatePickerBuilder({required super.args});

  static const kType = 'date_picker';

  /// Constant that can be referenced for the builder's type.
  @override
  String get type => kType;

  /// Static function that is capable of decoding the widget from a dynamic JSON
  /// or YAML set of values.
  static DatePickerBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) =>
      DatePickerBuilder(
        args: map,
      );

  @override
  DatePickerBuilderModel createModel({
    ChildWidgetBuilder? childBuilder,
    required JsonWidgetData data,
  }) {
    final model = DatePickerBuilderModel.fromDynamic(
      args,
      registry: data.jsonWidgetRegistry,
    );

    return model;
  }

  @override
  DatePicker buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    final model = createModel(
      childBuilder: childBuilder,
      data: data,
    );

    return DatePicker(
      centerLeadingDate: model.centerLeadingDate,
      currentDate: model.currentDate,
      currentDateDecoration: model.currentDateDecoration,
      currentDateTextStyle: model.currentDateTextStyle,
      daysOfTheWeekTextStyle: model.daysOfTheWeekTextStyle,
      disabledCellsDecoration: model.disabledCellsDecoration,
      disabledCellsTextStyle: model.disabledCellsTextStyle,
      disabledDayPredicate: model.disabledDayPredicate,
      enabledCellsDecoration: model.enabledCellsDecoration,
      enabledCellsTextStyle: model.enabledCellsTextStyle,
      highlightColor: model.highlightColor,
      initialDate: model.initialDate,
      initialPickerType: model.initialPickerType,
      key: key,
      leadingDateTextStyle: model.leadingDateTextStyle,
      maxDate: model.maxDate,
      minDate: model.minDate,
      nextPageSemanticLabel: model.nextPageSemanticLabel,
      onDateSelected: model.onDateSelected,
      padding: model.padding,
      previousPageSemanticLabel: model.previousPageSemanticLabel,
      selectedCellDecoration: model.selectedCellDecoration,
      selectedCellTextStyle: model.selectedCellTextStyle,
      selectedDate: model.selectedDate,
      slidersColor: model.slidersColor,
      slidersSize: model.slidersSize,
      splashColor: model.splashColor,
      splashRadius: model.splashRadius,
    );
  }
}

class JsonDatePicker extends JsonWidgetData {
  JsonDatePicker({
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
    this.centerLeadingDate = false,
    this.currentDate,
    this.currentDateDecoration,
    this.currentDateTextStyle,
    this.daysOfTheWeekTextStyle,
    this.disabledCellsDecoration = const BoxDecoration(),
    this.disabledCellsTextStyle,
    this.disabledDayPredicate,
    this.enabledCellsDecoration = const BoxDecoration(),
    this.enabledCellsTextStyle,
    this.highlightColor,
    this.initialDate,
    this.initialPickerType = PickerType.days,
    this.leadingDateTextStyle,
    required this.maxDate,
    required this.minDate,
    this.nextPageSemanticLabel,
    this.onDateSelected,
    this.padding = const EdgeInsets.all(16),
    this.previousPageSemanticLabel,
    this.selectedCellDecoration,
    this.selectedCellTextStyle,
    this.selectedDate,
    this.slidersColor,
    this.slidersSize,
    this.splashColor,
    this.splashRadius,
  }) : super(
          jsonWidgetArgs: DatePickerBuilderModel.fromDynamic(
            {
              'centerLeadingDate': centerLeadingDate,
              'currentDate': currentDate,
              'currentDateDecoration': currentDateDecoration,
              'currentDateTextStyle': currentDateTextStyle,
              'daysOfTheWeekTextStyle': daysOfTheWeekTextStyle,
              'disabledCellsDecoration': disabledCellsDecoration,
              'disabledCellsTextStyle': disabledCellsTextStyle,
              'disabledDayPredicate': disabledDayPredicate,
              'enabledCellsDecoration': enabledCellsDecoration,
              'enabledCellsTextStyle': enabledCellsTextStyle,
              'highlightColor': highlightColor,
              'initialDate': initialDate,
              'initialPickerType': initialPickerType,
              'leadingDateTextStyle': leadingDateTextStyle,
              'maxDate': maxDate,
              'minDate': minDate,
              'nextPageSemanticLabel': nextPageSemanticLabel,
              'onDateSelected': onDateSelected,
              'padding': padding,
              'previousPageSemanticLabel': previousPageSemanticLabel,
              'selectedCellDecoration': selectedCellDecoration,
              'selectedCellTextStyle': selectedCellTextStyle,
              'selectedDate': selectedDate,
              'slidersColor': slidersColor,
              'slidersSize': slidersSize,
              'splashColor': splashColor,
              'splashRadius': splashRadius,
              ...args,
            },
            args: args,
            registry: registry,
          ),
          jsonWidgetBuilder: () => DatePickerBuilder(
            args: DatePickerBuilderModel.fromDynamic(
              {
                'centerLeadingDate': centerLeadingDate,
                'currentDate': currentDate,
                'currentDateDecoration': currentDateDecoration,
                'currentDateTextStyle': currentDateTextStyle,
                'daysOfTheWeekTextStyle': daysOfTheWeekTextStyle,
                'disabledCellsDecoration': disabledCellsDecoration,
                'disabledCellsTextStyle': disabledCellsTextStyle,
                'disabledDayPredicate': disabledDayPredicate,
                'enabledCellsDecoration': enabledCellsDecoration,
                'enabledCellsTextStyle': enabledCellsTextStyle,
                'highlightColor': highlightColor,
                'initialDate': initialDate,
                'initialPickerType': initialPickerType,
                'leadingDateTextStyle': leadingDateTextStyle,
                'maxDate': maxDate,
                'minDate': minDate,
                'nextPageSemanticLabel': nextPageSemanticLabel,
                'onDateSelected': onDateSelected,
                'padding': padding,
                'previousPageSemanticLabel': previousPageSemanticLabel,
                'selectedCellDecoration': selectedCellDecoration,
                'selectedCellTextStyle': selectedCellTextStyle,
                'selectedDate': selectedDate,
                'slidersColor': slidersColor,
                'slidersSize': slidersSize,
                'splashColor': splashColor,
                'splashRadius': splashRadius,
                ...args,
              },
              args: args,
              registry: registry,
            ),
          ),
          jsonWidgetType: DatePickerBuilder.kType,
        );

  /* AUTOGENERATED FROM [DatePicker.centerLeadingDate]*/
  /// Centring the leading date. e.g:
  ///
  /// <       December 2023      >
  ///
  final bool centerLeadingDate;

  /* AUTOGENERATED FROM [DatePicker.currentDate]*/
  /// The date to which the picker will consider as current date. e.g (today).
  /// If not specified, the picker will default to `DateTime.now()` date.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? currentDate;

  /* AUTOGENERATED FROM [DatePicker.currentDateDecoration]*/
  /// The cell decoration of the current date.
  ///
  /// defaults to circle stroke border with [ColorScheme.primary] color.
  final BoxDecoration? currentDateDecoration;

  /* AUTOGENERATED FROM [DatePicker.currentDateTextStyle]*/
  /// The text style of the current date.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.primary] color.
  final TextStyle? currentDateTextStyle;

  /* AUTOGENERATED FROM [DatePicker.daysOfTheWeekTextStyle]*/
  /// The text style of the days of the week in the header.
  ///
  /// defaults to [TextTheme.titleSmall] with a [FontWeight.bold],
  /// a `14` font size, and a [ColorScheme.onSurface] with 30% opacity.
  final TextStyle? daysOfTheWeekTextStyle;

  /* AUTOGENERATED FROM [DatePicker.disabledCellsDecoration]*/
  /// The cell decoration of cells which are not selectable.
  ///
  /// defaults to empty [BoxDecoration].
  final BoxDecoration disabledCellsDecoration;

  /* AUTOGENERATED FROM [DatePicker.disabledCellsTextStyle]*/
  /// The text style of cells which are not selectable.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onSurface] color with 30% opacity.
  final TextStyle? disabledCellsTextStyle;

  /* AUTOGENERATED FROM [DatePicker.disabledDayPredicate]*/
  /// A predicate function used to determine if a given day should be disabled.
  final bool Function(DateTime)? disabledDayPredicate;

  /* AUTOGENERATED FROM [DatePicker.enabledCellsDecoration]*/
  /// The cell decoration of cells which are selectable.
  ///
  /// defaults to empty [BoxDecoration].
  final BoxDecoration enabledCellsDecoration;

  /* AUTOGENERATED FROM [DatePicker.enabledCellsTextStyle]*/
  /// The text style of cells which are selectable.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onSurface] color.
  final TextStyle? enabledCellsTextStyle;

  /* AUTOGENERATED FROM [DatePicker.highlightColor]*/
  /// The highlight color of the ink response when pressed.
  ///
  /// defaults to the color of [selectedCellDecoration] with 30% opacity,
  /// if [selectedCellDecoration] is null will fall back to
  /// [ColorScheme.onPrimary] with 30% opacity.
  final Color? highlightColor;

  /* AUTOGENERATED FROM [DatePicker.initialDate]*/
  /// The date which will be displayed on first opening. If not specified, the picker
  /// will default to `DateTime.now()`. If `DateTime.now()` does not fall within the
  /// valid range of [minDate] and [maxDate], it will automatically adjust to the nearest
  /// valid date, selecting [maxDate] if `DateTime.now()` is after the valid range, or
  /// [minDate] if it is before.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? initialDate;

  /* AUTOGENERATED FROM [DatePicker.initialPickerType]*/
  /// The initial display of the calendar picker.
  final PickerType initialPickerType;

  /* AUTOGENERATED FROM [DatePicker.leadingDateTextStyle]*/
  /// The text style of leading date showing in the header.
  ///
  /// defaults to `18px` with a [FontWeight.bold]
  /// and [ColorScheme.primary] color.
  final TextStyle? leadingDateTextStyle;

  /* AUTOGENERATED FROM [DatePicker.maxDate]*/
  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [minDate].
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime maxDate;

  /* AUTOGENERATED FROM [DatePicker.minDate]*/
  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [maxDate].
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime minDate;

  /* AUTOGENERATED FROM [DatePicker.nextPageSemanticLabel]*/
  /// Semantic label for button to go to the next page.
  ///
  /// defaults to `Next Day/Month/Year` according to picker type.
  final String? nextPageSemanticLabel;

  /* AUTOGENERATED FROM [DatePicker.onDateSelected]*/
  /// Called when the user picks a date.
  final void Function(DateTime)? onDateSelected;

  /* AUTOGENERATED FROM [DatePicker.padding]*/
  /// The amount of padding to be added around the [DatePicker].
  final EdgeInsets padding;

  /* AUTOGENERATED FROM [DatePicker.previousPageSemanticLabel]*/
  /// Semantic label for button to go to the previous page.
  ///
  /// defaults to `Previous Day/Month/Year` according to picker type.
  final String? previousPageSemanticLabel;

  /* AUTOGENERATED FROM [DatePicker.selectedCellDecoration]*/
  /// The cell decoration of selected cell.
  ///
  /// defaults to circle with [ColorScheme.primary] color.
  final BoxDecoration? selectedCellDecoration;

  /* AUTOGENERATED FROM [DatePicker.selectedCellTextStyle]*/
  /// The text style of selected cell.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onPrimary] color.
  final TextStyle? selectedCellTextStyle;

  /* AUTOGENERATED FROM [DatePicker.selectedDate]*/
  /// The initially selected date when the picker is first opened.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? selectedDate;

  /* AUTOGENERATED FROM [DatePicker.slidersColor]*/
  /// The color of the page sliders.
  ///
  /// defaults to [ColorScheme.primary] color.
  final Color? slidersColor;

  /* AUTOGENERATED FROM [DatePicker.slidersSize]*/
  /// The size of the page sliders.
  ///
  /// defaults to `20px`.
  final double? slidersSize;

  /* AUTOGENERATED FROM [DatePicker.splashColor]*/
  /// The splash color of the ink response.
  ///
  /// defaults to the color of [selectedCellDecoration] with 30% opacity,
  /// if [selectedCellDecoration] is null will fall back to
  /// [ColorScheme.onPrimary] with 30% opacity.
  final Color? splashColor;

  /* AUTOGENERATED FROM [DatePicker.splashRadius]*/
  /// The radius of the ink splash.
  final double? splashRadius;
}

/* AUTOGENERATED FROM [DatePicker]*/
/// Creates a calendar date picker.
///
/// It will display a grid of days for the [initialDate]'s month. If [initialDate]
/// is null, `DateTime.now()` will be used. If `DateTime.now()` does not fall within
/// the valid range of [minDate] and [maxDate], it will fall back to the nearest
/// valid date from `DateTime.now()`, selecting the [maxDate] if `DateTime.now()` is
/// after the valid range, or [minDate] if before.
///
/// The day indicated by [selectedDate] will be selected if provided.
///
/// The optional [onDateSelected] callback will be called if provided when a date
/// is selected.
///
/// The user interface provides a way to change the year and the month being
/// displayed. By default it will show the day grid, but this can be changed
/// with [initialPickerType].
///
/// The [minDate] is the earliest allowable date. The [maxDate] is the latest
/// allowable date. [initialDate] and [selectedDate] must either fall between
/// these dates, or be equal to one of them.
///
/// The [currentDate] represents the current day (i.e. today). This
/// date will be highlighted in the day grid. If null, the date of
/// `DateTime.now()` will be used.
///
/// For each of these [DateTime] parameters, only
/// their dates are considered. Their time fields are ignored.
class DatePickerBuilderModel extends JsonWidgetBuilderModel {
  const DatePickerBuilderModel(
    super.args, {
    this.centerLeadingDate = false,
    this.currentDate,
    this.currentDateDecoration,
    this.currentDateTextStyle,
    this.daysOfTheWeekTextStyle,
    this.disabledCellsDecoration = const BoxDecoration(),
    this.disabledCellsTextStyle,
    this.disabledDayPredicate,
    this.enabledCellsDecoration = const BoxDecoration(),
    this.enabledCellsTextStyle,
    this.highlightColor,
    this.initialDate,
    this.initialPickerType = PickerType.days,
    this.leadingDateTextStyle,
    required this.maxDate,
    required this.minDate,
    this.nextPageSemanticLabel,
    this.onDateSelected,
    this.padding = const EdgeInsets.all(16),
    this.previousPageSemanticLabel,
    this.selectedCellDecoration,
    this.selectedCellTextStyle,
    this.selectedDate,
    this.slidersColor,
    this.slidersSize,
    this.splashColor,
    this.splashRadius,
  });

  /* AUTOGENERATED FROM [DatePicker.centerLeadingDate]*/
  /// Centring the leading date. e.g:
  ///
  /// <       December 2023      >
  ///
  final bool centerLeadingDate;

  /* AUTOGENERATED FROM [DatePicker.currentDate]*/
  /// The date to which the picker will consider as current date. e.g (today).
  /// If not specified, the picker will default to `DateTime.now()` date.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? currentDate;

  /* AUTOGENERATED FROM [DatePicker.currentDateDecoration]*/
  /// The cell decoration of the current date.
  ///
  /// defaults to circle stroke border with [ColorScheme.primary] color.
  final BoxDecoration? currentDateDecoration;

  /* AUTOGENERATED FROM [DatePicker.currentDateTextStyle]*/
  /// The text style of the current date.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.primary] color.
  final TextStyle? currentDateTextStyle;

  /* AUTOGENERATED FROM [DatePicker.daysOfTheWeekTextStyle]*/
  /// The text style of the days of the week in the header.
  ///
  /// defaults to [TextTheme.titleSmall] with a [FontWeight.bold],
  /// a `14` font size, and a [ColorScheme.onSurface] with 30% opacity.
  final TextStyle? daysOfTheWeekTextStyle;

  /* AUTOGENERATED FROM [DatePicker.disabledCellsDecoration]*/
  /// The cell decoration of cells which are not selectable.
  ///
  /// defaults to empty [BoxDecoration].
  final BoxDecoration disabledCellsDecoration;

  /* AUTOGENERATED FROM [DatePicker.disabledCellsTextStyle]*/
  /// The text style of cells which are not selectable.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onSurface] color with 30% opacity.
  final TextStyle? disabledCellsTextStyle;

  /* AUTOGENERATED FROM [DatePicker.disabledDayPredicate]*/
  /// A predicate function used to determine if a given day should be disabled.
  final bool Function(DateTime)? disabledDayPredicate;

  /* AUTOGENERATED FROM [DatePicker.enabledCellsDecoration]*/
  /// The cell decoration of cells which are selectable.
  ///
  /// defaults to empty [BoxDecoration].
  final BoxDecoration enabledCellsDecoration;

  /* AUTOGENERATED FROM [DatePicker.enabledCellsTextStyle]*/
  /// The text style of cells which are selectable.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onSurface] color.
  final TextStyle? enabledCellsTextStyle;

  /* AUTOGENERATED FROM [DatePicker.highlightColor]*/
  /// The highlight color of the ink response when pressed.
  ///
  /// defaults to the color of [selectedCellDecoration] with 30% opacity,
  /// if [selectedCellDecoration] is null will fall back to
  /// [ColorScheme.onPrimary] with 30% opacity.
  final Color? highlightColor;

  /* AUTOGENERATED FROM [DatePicker.initialDate]*/
  /// The date which will be displayed on first opening. If not specified, the picker
  /// will default to `DateTime.now()`. If `DateTime.now()` does not fall within the
  /// valid range of [minDate] and [maxDate], it will automatically adjust to the nearest
  /// valid date, selecting [maxDate] if `DateTime.now()` is after the valid range, or
  /// [minDate] if it is before.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? initialDate;

  /* AUTOGENERATED FROM [DatePicker.initialPickerType]*/
  /// The initial display of the calendar picker.
  final PickerType initialPickerType;

  /* AUTOGENERATED FROM [DatePicker.leadingDateTextStyle]*/
  /// The text style of leading date showing in the header.
  ///
  /// defaults to `18px` with a [FontWeight.bold]
  /// and [ColorScheme.primary] color.
  final TextStyle? leadingDateTextStyle;

  /* AUTOGENERATED FROM [DatePicker.maxDate]*/
  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [minDate].
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime maxDate;

  /* AUTOGENERATED FROM [DatePicker.minDate]*/
  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [maxDate].
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime minDate;

  /* AUTOGENERATED FROM [DatePicker.nextPageSemanticLabel]*/
  /// Semantic label for button to go to the next page.
  ///
  /// defaults to `Next Day/Month/Year` according to picker type.
  final String? nextPageSemanticLabel;

  /* AUTOGENERATED FROM [DatePicker.onDateSelected]*/
  /// Called when the user picks a date.
  final void Function(DateTime)? onDateSelected;

  /* AUTOGENERATED FROM [DatePicker.padding]*/
  /// The amount of padding to be added around the [DatePicker].
  final EdgeInsets padding;

  /* AUTOGENERATED FROM [DatePicker.previousPageSemanticLabel]*/
  /// Semantic label for button to go to the previous page.
  ///
  /// defaults to `Previous Day/Month/Year` according to picker type.
  final String? previousPageSemanticLabel;

  /* AUTOGENERATED FROM [DatePicker.selectedCellDecoration]*/
  /// The cell decoration of selected cell.
  ///
  /// defaults to circle with [ColorScheme.primary] color.
  final BoxDecoration? selectedCellDecoration;

  /* AUTOGENERATED FROM [DatePicker.selectedCellTextStyle]*/
  /// The text style of selected cell.
  ///
  /// defaults to [TextTheme.titleLarge] with a [FontWeight.normal]
  /// and [ColorScheme.onPrimary] color.
  final TextStyle? selectedCellTextStyle;

  /* AUTOGENERATED FROM [DatePicker.selectedDate]*/
  /// The initially selected date when the picker is first opened.
  ///
  /// Note that only dates are considered. time fields are ignored.
  final DateTime? selectedDate;

  /* AUTOGENERATED FROM [DatePicker.slidersColor]*/
  /// The color of the page sliders.
  ///
  /// defaults to [ColorScheme.primary] color.
  final Color? slidersColor;

  /* AUTOGENERATED FROM [DatePicker.slidersSize]*/
  /// The size of the page sliders.
  ///
  /// defaults to `20px`.
  final double? slidersSize;

  /* AUTOGENERATED FROM [DatePicker.splashColor]*/
  /// The splash color of the ink response.
  ///
  /// defaults to the color of [selectedCellDecoration] with 30% opacity,
  /// if [selectedCellDecoration] is null will fall back to
  /// [ColorScheme.onPrimary] with 30% opacity.
  final Color? splashColor;

  /* AUTOGENERATED FROM [DatePicker.splashRadius]*/
  /// The radius of the ink splash.
  final double? splashRadius;

  static DatePickerBuilderModel fromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    final result = maybeFromDynamic(
      map,
      args: args,
      registry: registry,
    );

    if (result == null) {
      throw Exception(
        '[DatePickerBuilder]: requested to parse from dynamic, but the input is null.',
      );
    }

    return result;
  }

  static DatePickerBuilderModel? maybeFromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    DatePickerBuilderModel? result;

    if (map != null) {
      if (map is String) {
        map = yaon.parse(
          map,
          normalize: true,
        );
      }

      if (map is DatePickerBuilderModel) {
        result = map;
      } else {
        registry ??= JsonWidgetRegistry.instance;
        map = registry.processArgs(map, <String>{}).value;
        result = DatePickerBuilderModel(
          args,
          centerLeadingDate: JsonClass.parseBool(
            map['centerLeadingDate'],
            whenNull: false,
          ),
          currentDate: () {
            dynamic parsed = JsonClass.maybeParseDateTime(map['currentDate']);

            return parsed;
          }(),
          currentDateDecoration: () {
            dynamic parsed = ThemeDecoder.decodeBoxDecoration(
              map['currentDateDecoration'],
              validate: false,
            );

            return parsed;
          }(),
          currentDateTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['currentDateTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          daysOfTheWeekTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['daysOfTheWeekTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          disabledCellsDecoration: () {
            dynamic parsed = ThemeDecoder.decodeBoxDecoration(
              map['disabledCellsDecoration'],
              validate: false,
            );
            parsed ??= const BoxDecoration();

            return parsed;
          }(),
          disabledCellsTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['disabledCellsTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          disabledDayPredicate: map['disabledDayPredicate'],
          enabledCellsDecoration: () {
            dynamic parsed = ThemeDecoder.decodeBoxDecoration(
              map['enabledCellsDecoration'],
              validate: false,
            );
            parsed ??= const BoxDecoration();

            return parsed;
          }(),
          enabledCellsTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['enabledCellsTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          highlightColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['highlightColor'],
              validate: false,
            );

            return parsed;
          }(),
          initialDate: () {
            dynamic parsed = JsonClass.maybeParseDateTime(map['initialDate']);

            return parsed;
          }(),
          initialPickerType: map['initialPickerType'] ?? PickerType.days,
          leadingDateTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['leadingDateTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          maxDate: () {
            dynamic parsed = JsonClass.parseDateTime(map['maxDate']);

            if (parsed == null) {
              throw Exception(
                'Null value encountered for required parameter: [maxDate].',
              );
            }
            return parsed;
          }(),
          minDate: () {
            dynamic parsed = JsonClass.parseDateTime(map['minDate']);

            if (parsed == null) {
              throw Exception(
                'Null value encountered for required parameter: [minDate].',
              );
            }
            return parsed;
          }(),
          nextPageSemanticLabel: map['nextPageSemanticLabel'],
          onDateSelected: map['onDateSelected'],
          padding: () {
            dynamic parsed = ThemeDecoder.decodeEdgeInsets(
              map['padding'],
              validate: false,
            );
            parsed ??= const EdgeInsets.all(16);

            return parsed;
          }(),
          previousPageSemanticLabel: map['previousPageSemanticLabel'],
          selectedCellDecoration: () {
            dynamic parsed = ThemeDecoder.decodeBoxDecoration(
              map['selectedCellDecoration'],
              validate: false,
            );

            return parsed;
          }(),
          selectedCellTextStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['selectedCellTextStyle'],
              validate: false,
            );

            return parsed;
          }(),
          selectedDate: () {
            dynamic parsed = JsonClass.maybeParseDateTime(map['selectedDate']);

            return parsed;
          }(),
          slidersColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['slidersColor'],
              validate: false,
            );

            return parsed;
          }(),
          slidersSize: () {
            dynamic parsed = JsonClass.maybeParseDouble(map['slidersSize']);

            return parsed;
          }(),
          splashColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['splashColor'],
              validate: false,
            );

            return parsed;
          }(),
          splashRadius: () {
            dynamic parsed = JsonClass.maybeParseDouble(map['splashRadius']);

            return parsed;
          }(),
        );
      }
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() {
    return JsonClass.removeNull({
      'centerLeadingDate':
          false == centerLeadingDate ? null : centerLeadingDate,
      'currentDate': currentDate?.millisecondsSinceEpoch,
      'currentDateDecoration': ThemeEncoder.encodeBoxDecoration(
        currentDateDecoration,
      ),
      'currentDateTextStyle': ThemeEncoder.encodeTextStyle(
        currentDateTextStyle,
      ),
      'daysOfTheWeekTextStyle': ThemeEncoder.encodeTextStyle(
        daysOfTheWeekTextStyle,
      ),
      'disabledCellsDecoration':
          const BoxDecoration() == disabledCellsDecoration
              ? null
              : ThemeEncoder.encodeBoxDecoration(
                  disabledCellsDecoration,
                ),
      'disabledCellsTextStyle': ThemeEncoder.encodeTextStyle(
        disabledCellsTextStyle,
      ),
      'disabledDayPredicate': disabledDayPredicate,
      'enabledCellsDecoration': const BoxDecoration() == enabledCellsDecoration
          ? null
          : ThemeEncoder.encodeBoxDecoration(
              enabledCellsDecoration,
            ),
      'enabledCellsTextStyle': ThemeEncoder.encodeTextStyle(
        enabledCellsTextStyle,
      ),
      'highlightColor': ThemeEncoder.encodeColor(
        highlightColor,
      ),
      'initialDate': initialDate?.millisecondsSinceEpoch,
      'initialPickerType':
          PickerType.days == initialPickerType ? null : initialPickerType,
      'leadingDateTextStyle': ThemeEncoder.encodeTextStyle(
        leadingDateTextStyle,
      ),
      'maxDate': maxDate.millisecondsSinceEpoch,
      'minDate': minDate.millisecondsSinceEpoch,
      'nextPageSemanticLabel': nextPageSemanticLabel,
      'onDateSelected': onDateSelected,
      'padding': const EdgeInsets.all(16) == padding
          ? null
          : ThemeEncoder.encodeEdgeInsets(
              padding,
            ),
      'previousPageSemanticLabel': previousPageSemanticLabel,
      'selectedCellDecoration': ThemeEncoder.encodeBoxDecoration(
        selectedCellDecoration,
      ),
      'selectedCellTextStyle': ThemeEncoder.encodeTextStyle(
        selectedCellTextStyle,
      ),
      'selectedDate': selectedDate?.millisecondsSinceEpoch,
      'slidersColor': ThemeEncoder.encodeColor(
        slidersColor,
      ),
      'slidersSize': slidersSize,
      'splashColor': ThemeEncoder.encodeColor(
        splashColor,
      ),
      'splashRadius': splashRadius,
      ...args,
    });
  }
}

class DatePickerSchema {
  static const id =
      'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/convertdifffinger/date_picker.json';

  static final schema = <String, Object>{
    r'$schema': 'http://json-schema.org/draft-07/schema#',
    r'$id': id,
    'title': 'DatePicker',
    'type': 'object',
    'additionalProperties': false,
    'properties': {
      'centerLeadingDate': SchemaHelper.boolSchema,
      'currentDate': SchemaHelper.anySchema,
      'currentDateDecoration':
          SchemaHelper.objectSchema(BoxDecorationSchema.id),
      'currentDateTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'daysOfTheWeekTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'disabledCellsDecoration':
          SchemaHelper.objectSchema(BoxDecorationSchema.id),
      'disabledCellsTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'disabledDayPredicate': SchemaHelper.anySchema,
      'enabledCellsDecoration':
          SchemaHelper.objectSchema(BoxDecorationSchema.id),
      'enabledCellsTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'highlightColor': SchemaHelper.objectSchema(ColorSchema.id),
      'initialDate': SchemaHelper.anySchema,
      'initialPickerType': SchemaHelper.anySchema,
      'leadingDateTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'maxDate': SchemaHelper.anySchema,
      'minDate': SchemaHelper.anySchema,
      'nextPageSemanticLabel': SchemaHelper.stringSchema,
      'onDateSelected': SchemaHelper.anySchema,
      'padding': SchemaHelper.objectSchema(EdgeInsetsSchema.id),
      'previousPageSemanticLabel': SchemaHelper.stringSchema,
      'selectedCellDecoration':
          SchemaHelper.objectSchema(BoxDecorationSchema.id),
      'selectedCellTextStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'selectedDate': SchemaHelper.anySchema,
      'slidersColor': SchemaHelper.objectSchema(ColorSchema.id),
      'slidersSize': SchemaHelper.numberSchema,
      'splashColor': SchemaHelper.objectSchema(ColorSchema.id),
      'splashRadius': SchemaHelper.numberSchema,
    },
  };
}
