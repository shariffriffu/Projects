// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_tab_bar.dart';

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

class TabBarBuilder extends _TabBarBuilder {
  const TabBarBuilder({required super.args});

  static const kType = 'tab_bar';

  /// Constant that can be referenced for the builder's type.
  @override
  String get type => kType;

  /// Static function that is capable of decoding the widget from a dynamic JSON
  /// or YAML set of values.
  static TabBarBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) =>
      TabBarBuilder(
        args: map,
      );

  @override
  TabBarBuilderModel createModel({
    ChildWidgetBuilder? childBuilder,
    required JsonWidgetData data,
  }) {
    final model = TabBarBuilderModel.fromDynamic(
      args,
      registry: data.jsonWidgetRegistry,
    );

    return model;
  }

  @override
  TabBar buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    final model = createModel(
      childBuilder: childBuilder,
      data: data,
    );

    return TabBar(
      automaticIndicatorColorAdjustment:
          model.automaticIndicatorColorAdjustment,
      controller: model.controller,
      dividerColor: model.dividerColor,
      dividerHeight: model.dividerHeight,
      dragStartBehavior: model.dragStartBehavior,
      enableFeedback: model.enableFeedback,
      indicator: model.indicator,
      indicatorColor: model.indicatorColor,
      indicatorPadding: model.indicatorPadding,
      indicatorSize: model.indicatorSize,
      indicatorWeight: model.indicatorWeight,
      isScrollable: model.isScrollable,
      key: key,
      labelColor: model.labelColor,
      labelPadding: model.labelPadding,
      labelStyle: model.labelStyle,
      mouseCursor: model.mouseCursor,
      onTap: model.onTap,
      overlayColor: model.overlayColor,
      padding: model.padding,
      physics: model.physics,
      splashBorderRadius: model.splashBorderRadius,
      splashFactory: model.splashFactory,
      tabAlignment: model.tabAlignment,
      tabs: [
        for (var d in model.tabs)
          d.build(
            childBuilder: childBuilder,
            context: context,
          ),
      ],
      unselectedLabelColor: model.unselectedLabelColor,
      unselectedLabelStyle: model.unselectedLabelStyle,
    );
  }
}

class JsonTabBar extends JsonWidgetData {
  JsonTabBar({
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
    this.automaticIndicatorColorAdjustment = true,
    this.controller,
    this.dividerColor,
    this.dividerHeight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableFeedback,
    this.indicator,
    this.indicatorColor,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorSize,
    this.indicatorWeight = 2.0,
    this.isScrollable = false,
    this.labelColor,
    this.labelPadding,
    this.labelStyle,
    this.mouseCursor,
    this.onTap,
    this.overlayColor,
    this.padding,
    this.physics,
    this.splashBorderRadius,
    this.splashFactory,
    this.tabAlignment,
    required this.tabs,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  }) : super(
          jsonWidgetArgs: TabBarBuilderModel.fromDynamic(
            {
              'automaticIndicatorColorAdjustment':
                  automaticIndicatorColorAdjustment,
              'controller': controller,
              'dividerColor': dividerColor,
              'dividerHeight': dividerHeight,
              'dragStartBehavior': dragStartBehavior,
              'enableFeedback': enableFeedback,
              'indicator': indicator,
              'indicatorColor': indicatorColor,
              'indicatorPadding': indicatorPadding,
              'indicatorSize': indicatorSize,
              'indicatorWeight': indicatorWeight,
              'isScrollable': isScrollable,
              'labelColor': labelColor,
              'labelPadding': labelPadding,
              'labelStyle': labelStyle,
              'mouseCursor': mouseCursor,
              'onTap': onTap,
              'overlayColor': overlayColor,
              'padding': padding,
              'physics': physics,
              'splashBorderRadius': splashBorderRadius,
              'splashFactory': splashFactory,
              'tabAlignment': tabAlignment,
              'tabs': tabs,
              'unselectedLabelColor': unselectedLabelColor,
              'unselectedLabelStyle': unselectedLabelStyle,
              ...args,
            },
            args: args,
            registry: registry,
          ),
          jsonWidgetBuilder: () => TabBarBuilder(
            args: TabBarBuilderModel.fromDynamic(
              {
                'automaticIndicatorColorAdjustment':
                    automaticIndicatorColorAdjustment,
                'controller': controller,
                'dividerColor': dividerColor,
                'dividerHeight': dividerHeight,
                'dragStartBehavior': dragStartBehavior,
                'enableFeedback': enableFeedback,
                'indicator': indicator,
                'indicatorColor': indicatorColor,
                'indicatorPadding': indicatorPadding,
                'indicatorSize': indicatorSize,
                'indicatorWeight': indicatorWeight,
                'isScrollable': isScrollable,
                'labelColor': labelColor,
                'labelPadding': labelPadding,
                'labelStyle': labelStyle,
                'mouseCursor': mouseCursor,
                'onTap': onTap,
                'overlayColor': overlayColor,
                'padding': padding,
                'physics': physics,
                'splashBorderRadius': splashBorderRadius,
                'splashFactory': splashFactory,
                'tabAlignment': tabAlignment,
                'tabs': tabs,
                'unselectedLabelColor': unselectedLabelColor,
                'unselectedLabelStyle': unselectedLabelStyle,
                ...args,
              },
              args: args,
              registry: registry,
            ),
          ),
          jsonWidgetType: TabBarBuilder.kType,
        );

  /* AUTOGENERATED FROM [TabBar.automaticIndicatorColorAdjustment]*/
  /// Whether this tab bar should automatically adjust the [indicatorColor].
  ///
  /// The default value of this property is true.
  ///
  /// If [automaticIndicatorColorAdjustment] is true,
  /// then the [indicatorColor] will be automatically adjusted to [Colors.white]
  /// when the [indicatorColor] is same as [Material.color] of the [Material]
  /// parent widget.
  final bool automaticIndicatorColorAdjustment;

  /* AUTOGENERATED FROM [TabBar.controller]*/
  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /* AUTOGENERATED FROM [TabBar.dividerColor]*/
  /// The color of the divider.
  ///
  /// If null and [ThemeData.useMaterial3] is true, [TabBarTheme.dividerColor]
  /// color is used. If that is null and [ThemeData.useMaterial3] is true,
  /// [ColorScheme.surfaceVariant] will be used, otherwise divider will not be drawn.
  final Color? dividerColor;

  /* AUTOGENERATED FROM [TabBar.dividerHeight]*/
  /// The height of the divider.
  ///
  /// If null and [ThemeData.useMaterial3] is true, [TabBarTheme.dividerHeight] is used.
  /// If that is also null and [ThemeData.useMaterial3] is true, 1.0 will be used.
  /// Otherwise divider will not be drawn.
  final double? dividerHeight;

  /* AUTOGENERATED FROM [TabBar.dragStartBehavior]*/
  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /* AUTOGENERATED FROM [TabBar.enableFeedback]*/
  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a long-press
  /// will produce a short vibration, when feedback is enabled.
  ///
  /// Defaults to true.
  final bool? enableFeedback;

  /* AUTOGENERATED FROM [TabBar.indicator]*/
  /// Defines the appearance of the selected tab indicator.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// the [indicatorColor] and [indicatorWeight] properties are ignored.
  ///
  /// The default, underline-style, selected tab indicator can be defined with
  /// [UnderlineTabIndicator].
  ///
  /// The indicator's size is based on the tab's bounds. If [indicatorSize]
  /// is [TabBarIndicatorSize.tab] the tab's bounds are as wide as the space
  /// occupied by the tab in the tab bar. If [indicatorSize] is
  /// [TabBarIndicatorSize.label], then the tab's bounds are only as wide as
  /// the tab widget itself.
  ///
  /// See also:
  ///
  ///  * [splashBorderRadius], which defines the clipping radius of the splash
  ///    and is generally used with [BoxDecoration.borderRadius].
  final Decoration? indicator;

  /* AUTOGENERATED FROM [TabBar.indicatorColor]*/
  /// The color of the line that appears below the selected tab.
  ///
  /// If this parameter is null, then the value of the Theme's indicatorColor
  /// property is used.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// this property is ignored.
  final Color? indicatorColor;

  /* AUTOGENERATED FROM [TabBar.indicatorPadding]*/
  /// The padding for the indicator.
  ///
  /// The default value of this property is [EdgeInsets.zero].
  ///
  /// For [isScrollable] tab bars, specifying [kTabLabelPadding] will align
  /// the indicator with the tab's text for [Tab] widgets and all but the
  /// shortest [Tab.text] values.
  final EdgeInsetsGeometry indicatorPadding;

  /* AUTOGENERATED FROM [TabBar.indicatorSize]*/
  /// Defines how the selected tab indicator's size is computed.
  ///
  /// The size of the selected tab indicator is defined relative to the
  /// tab's overall bounds if [indicatorSize] is [TabBarIndicatorSize.tab]
  /// (the default) or relative to the bounds of the tab's widget if
  /// [indicatorSize] is [TabBarIndicatorSize.label].
  ///
  /// The selected tab's location appearance can be refined further with
  /// the [indicatorColor], [indicatorWeight], [indicatorPadding], and
  /// [indicator] properties.
  final TabBarIndicatorSize? indicatorSize;

  /* AUTOGENERATED FROM [TabBar.indicatorWeight]*/
  /// The thickness of the line that appears below the selected tab.
  ///
  /// The value of this parameter must be greater than zero.
  ///
  /// If [ThemeData.useMaterial3] is true and [TabBar] is used to create a
  /// primary tab bar, the default value is 3.0. If the provided value is less
  /// than 3.0, the default value is used.
  ///
  /// If [ThemeData.useMaterial3] is true and [TabBar.secondary] is used to
  /// create a secondary tab bar, the default value is 2.0.
  ///
  /// If [ThemeData.useMaterial3] is false, the default value is 2.0.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// this property is ignored.
  final double indicatorWeight;

  /* AUTOGENERATED FROM [TabBar.isScrollable]*/
  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [isScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isScrollable;

  /* AUTOGENERATED FROM [TabBar.labelColor]*/
  /// The color of selected tab labels.
  ///
  /// If null, then [TabBarTheme.labelColor] is used. If that is also null and
  /// [ThemeData.useMaterial3] is true, [ColorScheme.primary] will be used,
  /// otherwise the color of the [ThemeData.primaryTextTheme]'s
  /// [TextTheme.bodyLarge] text color is used.
  ///
  /// If [labelColor] (or, if null, [TabBarTheme.labelColor]) is a
  /// [MaterialStateColor], then the effective tab color will depend on the
  /// [MaterialState.selected] state, i.e. if the [Tab] is selected or not,
  /// ignoring [unselectedLabelColor] even if it's non-null.
  ///
  /// When this color or the [TabBarTheme.labelColor] is specified, it overrides
  /// the [TextStyle.color] specified for the [labelStyle] or the
  /// [TabBarTheme.labelStyle].
  ///
  /// See also:
  ///
  ///   * [unselectedLabelColor], for color of unselected tab labels.
  final Color? labelColor;

  /* AUTOGENERATED FROM [TabBar.labelPadding]*/
  /// The padding added to each of the tab labels.
  ///
  /// If there are few tabs with both icon and text and few
  /// tabs with only icon or text, this padding is vertically
  /// adjusted to provide uniform padding to all tabs.
  ///
  /// If this property is null, then [kTabLabelPadding] is used.
  final EdgeInsetsGeometry? labelPadding;

  /* AUTOGENERATED FROM [TabBar.labelStyle]*/
  /// The text style of the selected tab labels.
  ///
  /// The color specified in [labelStyle] and [TabBarTheme.labelStyle] is used
  /// to style the label when [labelColor] or [TabBarTheme.labelColor] are not
  /// specified.
  ///
  /// If [unselectedLabelStyle] is null, then this text style will be used for
  /// both selected and unselected label styles.
  ///
  /// If this property is null, then [TabBarTheme.labelStyle] will be used.
  ///
  /// If that is also null and [ThemeData.useMaterial3] is true, [TextTheme.titleSmall]
  /// will be used, otherwise the text style of the [ThemeData.primaryTextTheme]'s
  /// [TextTheme.bodyLarge] definition is used.
  final TextStyle? labelStyle;

  /* AUTOGENERATED FROM [TabBar.mouseCursor]*/
  /// {@template flutter.material.tabs.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// individual tab widgets.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  /// {@endtemplate}
  ///
  /// If null, then the value of [TabBarTheme.mouseCursor] is used. If
  /// that is also null, then [MaterialStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialStateMouseCursor], which can be used to create a [MouseCursor]
  ///    that is also a [MaterialStateProperty<MouseCursor>].
  final MouseCursor? mouseCursor;

  /* AUTOGENERATED FROM [TabBar.onTap]*/
  /// An optional callback that's called when the [TabBar] is tapped.
  ///
  /// The callback is applied to the index of the tab where the tap occurred.
  ///
  /// This callback has no effect on the default handling of taps. It's for
  /// applications that want to do a little extra work when a tab is tapped,
  /// even if the tap doesn't change the TabController's index. TabBar [onTap]
  /// callbacks should not make changes to the TabController since that would
  /// interfere with the default tap handler.
  final void Function(int)? onTap;

  /* AUTOGENERATED FROM [TabBar.overlayColor]*/
  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// If non-null, it is resolved against one of [MaterialState.focused],
  /// [MaterialState.hovered], and [MaterialState.pressed].
  ///
  /// [MaterialState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec.
  ///
  /// If the overlay color is null or resolves to null, then the default values
  /// for [InkResponse.focusColor], [InkResponse.hoverColor], [InkResponse.splashColor],
  /// and [InkResponse.highlightColor] will be used instead.
  final MaterialStateProperty<Color?>? overlayColor;

  /* AUTOGENERATED FROM [TabBar.padding]*/
  /// The amount of space by which to inset the tab bar.
  ///
  /// When [isScrollable] is false, this will yield the same result as if [TabBar] was wrapped
  /// in a [Padding] widget. When [isScrollable] is true, the scrollable itself is inset,
  /// allowing the padding to scroll with the tab bar, rather than enclosing it.
  final EdgeInsetsGeometry? padding;

  /* AUTOGENERATED FROM [TabBar.physics]*/
  /// How the [TabBar]'s scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /* AUTOGENERATED FROM [TabBar.splashBorderRadius]*/
  /// Defines the clipping radius of splashes that extend outside the bounds of the tab.
  ///
  /// This can be useful to match the [BoxDecoration.borderRadius] provided as [indicator].
  ///
  /// ```dart
  /// TabBar(
  ///   indicator: BoxDecoration(
  ///     borderRadius: BorderRadius.circular(40),
  ///   ),
  ///   splashBorderRadius: BorderRadius.circular(40),
  ///   tabs: const <Widget>[
  ///     // ...
  ///   ],
  /// )
  /// ```
  ///
  /// If this property is null, it is interpreted as [BorderRadius.zero].
  final BorderRadius? splashBorderRadius;

  /* AUTOGENERATED FROM [TabBar.splashFactory]*/
  /// Creates the tab bar's [InkWell] splash factory, which defines
  /// the appearance of "ink" splashes that occur in response to taps.
  ///
  /// Use [NoSplash.splashFactory] to defeat ink splash rendering. For example
  /// to defeat both the splash and the hover/pressed overlay, but not the
  /// keyboard focused overlay:
  ///
  /// ```dart
  /// TabBar(
  ///   splashFactory: NoSplash.splashFactory,
  ///   overlayColor: MaterialStateProperty.resolveWith<Color?>(
  ///     (Set<MaterialState> states) {
  ///       return states.contains(MaterialState.focused) ? null : Colors.transparent;
  ///     },
  ///   ),
  ///   tabs: const <Widget>[
  ///     // ...
  ///   ],
  /// )
  /// ```
  final InteractiveInkFeatureFactory? splashFactory;

  /* AUTOGENERATED FROM [TabBar.tabAlignment]*/
  /// Specifies the horizontal alignment of the tabs within a [TabBar].
  ///
  /// If [TabBar.isScrollable] is false, only [TabAlignment.fill] and
  /// [TabAlignment.center] are supported. Otherwise an exception is thrown.
  ///
  /// If [TabBar.isScrollable] is true, only [TabAlignment.start], [TabAlignment.startOffset],
  /// and [TabAlignment.center] are supported. Otherwise an exception is thrown.
  ///
  /// If this is null, then the value of [TabBarTheme.tabAlignment] is used.
  ///
  /// If [TabBarTheme.tabAlignment] is null and [ThemeData.useMaterial3] is true,
  /// then [TabAlignment.startOffset] is used if [isScrollable] is true,
  /// otherwise [TabAlignment.fill] is used.
  ///
  /// If [TabBarTheme.tabAlignment] is null and [ThemeData.useMaterial3] is false,
  /// then [TabAlignment.center] is used if [isScrollable] is true,
  /// otherwise [TabAlignment.fill] is used.
  final TabAlignment? tabAlignment;

  /* AUTOGENERATED FROM [TabBar.tabs]*/
  /// Typically a list of two or more [Tab] widgets.
  ///
  /// The length of this list must match the [controller]'s [TabController.length]
  /// and the length of the [TabBarView.children] list.
  final List<JsonWidgetData> tabs;

  /* AUTOGENERATED FROM [TabBar.unselectedLabelColor]*/
  /// The color of unselected tab labels.
  ///
  /// If [labelColor] (or, if null, [TabBarTheme.labelColor]) is a
  /// [MaterialStateColor], then the unselected tabs are rendered with
  /// that [MaterialStateColor]'s resolved color for unselected state, even if
  /// [unselectedLabelColor] is non-null.
  ///
  /// If null, then [TabBarTheme.unselectedLabelColor] is used. If that is also
  /// null and [ThemeData.useMaterial3] is true, [ColorScheme.onSurfaceVariant]
  /// will be used, otherwise unselected tab labels are rendered with
  /// [labelColor] at 70% opacity.
  ///
  /// When this color or the [TabBarTheme.unselectedLabelColor] is specified, it
  /// overrides the [TextStyle.color] specified for the [unselectedLabelStyle]
  /// or the [TabBarTheme.unselectedLabelStyle].
  ///
  /// See also:
  ///
  ///  * [labelColor], for color of selected tab labels.
  final Color? unselectedLabelColor;

  /* AUTOGENERATED FROM [TabBar.unselectedLabelStyle]*/
  /// The text style of the unselected tab labels.
  ///
  /// The color specified in [unselectedLabelStyle] and [TabBarTheme.unselectedLabelStyle]
  /// is used to style the label when [unselectedLabelColor] or [TabBarTheme.unselectedLabelColor]
  /// are not specified.
  ///
  /// If this property is null, then [TabBarTheme.unselectedLabelStyle] will be used.
  ///
  /// If that is also null and [ThemeData.useMaterial3] is true, [TextTheme.titleSmall]
  /// will be used, otherwise then the [labelStyle] value is used. If [labelStyle] is null,
  /// the text style of the [ThemeData.primaryTextTheme]'s [TextTheme.bodyLarge]
  /// definition is used.
  final TextStyle? unselectedLabelStyle;
}

/* AUTOGENERATED FROM [TabBar]*/
/// Creates a Material Design primary tab bar.
///
/// The length of the [tabs] argument must match the [controller]'s
/// [TabController.length].
///
/// If a [TabController] is not provided, then there must be a
/// [DefaultTabController] ancestor.
///
/// The [indicatorWeight] parameter defaults to 2.
///
/// The [indicatorPadding] parameter defaults to [EdgeInsets.zero].
///
/// If [indicator] is not null or provided from [TabBarTheme],
/// then [indicatorWeight] and [indicatorColor] are ignored.
class TabBarBuilderModel extends JsonWidgetBuilderModel {
  const TabBarBuilderModel(
    super.args, {
    this.automaticIndicatorColorAdjustment = true,
    this.controller,
    this.dividerColor,
    this.dividerHeight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableFeedback,
    this.indicator,
    this.indicatorColor,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorSize,
    this.indicatorWeight = 2.0,
    this.isScrollable = false,
    this.labelColor,
    this.labelPadding,
    this.labelStyle,
    this.mouseCursor,
    this.onTap,
    this.overlayColor,
    this.padding,
    this.physics,
    this.splashBorderRadius,
    this.splashFactory,
    this.tabAlignment,
    required this.tabs,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  });

  /* AUTOGENERATED FROM [TabBar.automaticIndicatorColorAdjustment]*/
  /// Whether this tab bar should automatically adjust the [indicatorColor].
  ///
  /// The default value of this property is true.
  ///
  /// If [automaticIndicatorColorAdjustment] is true,
  /// then the [indicatorColor] will be automatically adjusted to [Colors.white]
  /// when the [indicatorColor] is same as [Material.color] of the [Material]
  /// parent widget.
  final bool automaticIndicatorColorAdjustment;

  /* AUTOGENERATED FROM [TabBar.controller]*/
  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /* AUTOGENERATED FROM [TabBar.dividerColor]*/
  /// The color of the divider.
  ///
  /// If null and [ThemeData.useMaterial3] is true, [TabBarTheme.dividerColor]
  /// color is used. If that is null and [ThemeData.useMaterial3] is true,
  /// [ColorScheme.surfaceVariant] will be used, otherwise divider will not be drawn.
  final Color? dividerColor;

  /* AUTOGENERATED FROM [TabBar.dividerHeight]*/
  /// The height of the divider.
  ///
  /// If null and [ThemeData.useMaterial3] is true, [TabBarTheme.dividerHeight] is used.
  /// If that is also null and [ThemeData.useMaterial3] is true, 1.0 will be used.
  /// Otherwise divider will not be drawn.
  final double? dividerHeight;

  /* AUTOGENERATED FROM [TabBar.dragStartBehavior]*/
  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /* AUTOGENERATED FROM [TabBar.enableFeedback]*/
  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a long-press
  /// will produce a short vibration, when feedback is enabled.
  ///
  /// Defaults to true.
  final bool? enableFeedback;

  /* AUTOGENERATED FROM [TabBar.indicator]*/
  /// Defines the appearance of the selected tab indicator.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// the [indicatorColor] and [indicatorWeight] properties are ignored.
  ///
  /// The default, underline-style, selected tab indicator can be defined with
  /// [UnderlineTabIndicator].
  ///
  /// The indicator's size is based on the tab's bounds. If [indicatorSize]
  /// is [TabBarIndicatorSize.tab] the tab's bounds are as wide as the space
  /// occupied by the tab in the tab bar. If [indicatorSize] is
  /// [TabBarIndicatorSize.label], then the tab's bounds are only as wide as
  /// the tab widget itself.
  ///
  /// See also:
  ///
  ///  * [splashBorderRadius], which defines the clipping radius of the splash
  ///    and is generally used with [BoxDecoration.borderRadius].
  final Decoration? indicator;

  /* AUTOGENERATED FROM [TabBar.indicatorColor]*/
  /// The color of the line that appears below the selected tab.
  ///
  /// If this parameter is null, then the value of the Theme's indicatorColor
  /// property is used.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// this property is ignored.
  final Color? indicatorColor;

  /* AUTOGENERATED FROM [TabBar.indicatorPadding]*/
  /// The padding for the indicator.
  ///
  /// The default value of this property is [EdgeInsets.zero].
  ///
  /// For [isScrollable] tab bars, specifying [kTabLabelPadding] will align
  /// the indicator with the tab's text for [Tab] widgets and all but the
  /// shortest [Tab.text] values.
  final EdgeInsetsGeometry indicatorPadding;

  /* AUTOGENERATED FROM [TabBar.indicatorSize]*/
  /// Defines how the selected tab indicator's size is computed.
  ///
  /// The size of the selected tab indicator is defined relative to the
  /// tab's overall bounds if [indicatorSize] is [TabBarIndicatorSize.tab]
  /// (the default) or relative to the bounds of the tab's widget if
  /// [indicatorSize] is [TabBarIndicatorSize.label].
  ///
  /// The selected tab's location appearance can be refined further with
  /// the [indicatorColor], [indicatorWeight], [indicatorPadding], and
  /// [indicator] properties.
  final TabBarIndicatorSize? indicatorSize;

  /* AUTOGENERATED FROM [TabBar.indicatorWeight]*/
  /// The thickness of the line that appears below the selected tab.
  ///
  /// The value of this parameter must be greater than zero.
  ///
  /// If [ThemeData.useMaterial3] is true and [TabBar] is used to create a
  /// primary tab bar, the default value is 3.0. If the provided value is less
  /// than 3.0, the default value is used.
  ///
  /// If [ThemeData.useMaterial3] is true and [TabBar.secondary] is used to
  /// create a secondary tab bar, the default value is 2.0.
  ///
  /// If [ThemeData.useMaterial3] is false, the default value is 2.0.
  ///
  /// If [indicator] is specified or provided from [TabBarTheme],
  /// this property is ignored.
  final double indicatorWeight;

  /* AUTOGENERATED FROM [TabBar.isScrollable]*/
  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [isScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isScrollable;

  /* AUTOGENERATED FROM [TabBar.labelColor]*/
  /// The color of selected tab labels.
  ///
  /// If null, then [TabBarTheme.labelColor] is used. If that is also null and
  /// [ThemeData.useMaterial3] is true, [ColorScheme.primary] will be used,
  /// otherwise the color of the [ThemeData.primaryTextTheme]'s
  /// [TextTheme.bodyLarge] text color is used.
  ///
  /// If [labelColor] (or, if null, [TabBarTheme.labelColor]) is a
  /// [MaterialStateColor], then the effective tab color will depend on the
  /// [MaterialState.selected] state, i.e. if the [Tab] is selected or not,
  /// ignoring [unselectedLabelColor] even if it's non-null.
  ///
  /// When this color or the [TabBarTheme.labelColor] is specified, it overrides
  /// the [TextStyle.color] specified for the [labelStyle] or the
  /// [TabBarTheme.labelStyle].
  ///
  /// See also:
  ///
  ///   * [unselectedLabelColor], for color of unselected tab labels.
  final Color? labelColor;

  /* AUTOGENERATED FROM [TabBar.labelPadding]*/
  /// The padding added to each of the tab labels.
  ///
  /// If there are few tabs with both icon and text and few
  /// tabs with only icon or text, this padding is vertically
  /// adjusted to provide uniform padding to all tabs.
  ///
  /// If this property is null, then [kTabLabelPadding] is used.
  final EdgeInsetsGeometry? labelPadding;

  /* AUTOGENERATED FROM [TabBar.labelStyle]*/
  /// The text style of the selected tab labels.
  ///
  /// The color specified in [labelStyle] and [TabBarTheme.labelStyle] is used
  /// to style the label when [labelColor] or [TabBarTheme.labelColor] are not
  /// specified.
  ///
  /// If [unselectedLabelStyle] is null, then this text style will be used for
  /// both selected and unselected label styles.
  ///
  /// If this property is null, then [TabBarTheme.labelStyle] will be used.
  ///
  /// If that is also null and [ThemeData.useMaterial3] is true, [TextTheme.titleSmall]
  /// will be used, otherwise the text style of the [ThemeData.primaryTextTheme]'s
  /// [TextTheme.bodyLarge] definition is used.
  final TextStyle? labelStyle;

  /* AUTOGENERATED FROM [TabBar.mouseCursor]*/
  /// {@template flutter.material.tabs.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// individual tab widgets.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  /// {@endtemplate}
  ///
  /// If null, then the value of [TabBarTheme.mouseCursor] is used. If
  /// that is also null, then [MaterialStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///
  ///  * [MaterialStateMouseCursor], which can be used to create a [MouseCursor]
  ///    that is also a [MaterialStateProperty<MouseCursor>].
  final MouseCursor? mouseCursor;

  /* AUTOGENERATED FROM [TabBar.onTap]*/
  /// An optional callback that's called when the [TabBar] is tapped.
  ///
  /// The callback is applied to the index of the tab where the tap occurred.
  ///
  /// This callback has no effect on the default handling of taps. It's for
  /// applications that want to do a little extra work when a tab is tapped,
  /// even if the tap doesn't change the TabController's index. TabBar [onTap]
  /// callbacks should not make changes to the TabController since that would
  /// interfere with the default tap handler.
  final void Function(int)? onTap;

  /* AUTOGENERATED FROM [TabBar.overlayColor]*/
  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// If non-null, it is resolved against one of [MaterialState.focused],
  /// [MaterialState.hovered], and [MaterialState.pressed].
  ///
  /// [MaterialState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec.
  ///
  /// If the overlay color is null or resolves to null, then the default values
  /// for [InkResponse.focusColor], [InkResponse.hoverColor], [InkResponse.splashColor],
  /// and [InkResponse.highlightColor] will be used instead.
  final MaterialStateProperty<Color?>? overlayColor;

  /* AUTOGENERATED FROM [TabBar.padding]*/
  /// The amount of space by which to inset the tab bar.
  ///
  /// When [isScrollable] is false, this will yield the same result as if [TabBar] was wrapped
  /// in a [Padding] widget. When [isScrollable] is true, the scrollable itself is inset,
  /// allowing the padding to scroll with the tab bar, rather than enclosing it.
  final EdgeInsetsGeometry? padding;

  /* AUTOGENERATED FROM [TabBar.physics]*/
  /// How the [TabBar]'s scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /* AUTOGENERATED FROM [TabBar.splashBorderRadius]*/
  /// Defines the clipping radius of splashes that extend outside the bounds of the tab.
  ///
  /// This can be useful to match the [BoxDecoration.borderRadius] provided as [indicator].
  ///
  /// ```dart
  /// TabBar(
  ///   indicator: BoxDecoration(
  ///     borderRadius: BorderRadius.circular(40),
  ///   ),
  ///   splashBorderRadius: BorderRadius.circular(40),
  ///   tabs: const <Widget>[
  ///     // ...
  ///   ],
  /// )
  /// ```
  ///
  /// If this property is null, it is interpreted as [BorderRadius.zero].
  final BorderRadius? splashBorderRadius;

  /* AUTOGENERATED FROM [TabBar.splashFactory]*/
  /// Creates the tab bar's [InkWell] splash factory, which defines
  /// the appearance of "ink" splashes that occur in response to taps.
  ///
  /// Use [NoSplash.splashFactory] to defeat ink splash rendering. For example
  /// to defeat both the splash and the hover/pressed overlay, but not the
  /// keyboard focused overlay:
  ///
  /// ```dart
  /// TabBar(
  ///   splashFactory: NoSplash.splashFactory,
  ///   overlayColor: MaterialStateProperty.resolveWith<Color?>(
  ///     (Set<MaterialState> states) {
  ///       return states.contains(MaterialState.focused) ? null : Colors.transparent;
  ///     },
  ///   ),
  ///   tabs: const <Widget>[
  ///     // ...
  ///   ],
  /// )
  /// ```
  final InteractiveInkFeatureFactory? splashFactory;

  /* AUTOGENERATED FROM [TabBar.tabAlignment]*/
  /// Specifies the horizontal alignment of the tabs within a [TabBar].
  ///
  /// If [TabBar.isScrollable] is false, only [TabAlignment.fill] and
  /// [TabAlignment.center] are supported. Otherwise an exception is thrown.
  ///
  /// If [TabBar.isScrollable] is true, only [TabAlignment.start], [TabAlignment.startOffset],
  /// and [TabAlignment.center] are supported. Otherwise an exception is thrown.
  ///
  /// If this is null, then the value of [TabBarTheme.tabAlignment] is used.
  ///
  /// If [TabBarTheme.tabAlignment] is null and [ThemeData.useMaterial3] is true,
  /// then [TabAlignment.startOffset] is used if [isScrollable] is true,
  /// otherwise [TabAlignment.fill] is used.
  ///
  /// If [TabBarTheme.tabAlignment] is null and [ThemeData.useMaterial3] is false,
  /// then [TabAlignment.center] is used if [isScrollable] is true,
  /// otherwise [TabAlignment.fill] is used.
  final TabAlignment? tabAlignment;

  /* AUTOGENERATED FROM [TabBar.tabs]*/
  /// Typically a list of two or more [Tab] widgets.
  ///
  /// The length of this list must match the [controller]'s [TabController.length]
  /// and the length of the [TabBarView.children] list.
  final List<JsonWidgetData> tabs;

  /* AUTOGENERATED FROM [TabBar.unselectedLabelColor]*/
  /// The color of unselected tab labels.
  ///
  /// If [labelColor] (or, if null, [TabBarTheme.labelColor]) is a
  /// [MaterialStateColor], then the unselected tabs are rendered with
  /// that [MaterialStateColor]'s resolved color for unselected state, even if
  /// [unselectedLabelColor] is non-null.
  ///
  /// If null, then [TabBarTheme.unselectedLabelColor] is used. If that is also
  /// null and [ThemeData.useMaterial3] is true, [ColorScheme.onSurfaceVariant]
  /// will be used, otherwise unselected tab labels are rendered with
  /// [labelColor] at 70% opacity.
  ///
  /// When this color or the [TabBarTheme.unselectedLabelColor] is specified, it
  /// overrides the [TextStyle.color] specified for the [unselectedLabelStyle]
  /// or the [TabBarTheme.unselectedLabelStyle].
  ///
  /// See also:
  ///
  ///  * [labelColor], for color of selected tab labels.
  final Color? unselectedLabelColor;

  /* AUTOGENERATED FROM [TabBar.unselectedLabelStyle]*/
  /// The text style of the unselected tab labels.
  ///
  /// The color specified in [unselectedLabelStyle] and [TabBarTheme.unselectedLabelStyle]
  /// is used to style the label when [unselectedLabelColor] or [TabBarTheme.unselectedLabelColor]
  /// are not specified.
  ///
  /// If this property is null, then [TabBarTheme.unselectedLabelStyle] will be used.
  ///
  /// If that is also null and [ThemeData.useMaterial3] is true, [TextTheme.titleSmall]
  /// will be used, otherwise then the [labelStyle] value is used. If [labelStyle] is null,
  /// the text style of the [ThemeData.primaryTextTheme]'s [TextTheme.bodyLarge]
  /// definition is used.
  final TextStyle? unselectedLabelStyle;

  static TabBarBuilderModel fromDynamic(
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
        '[TabBarBuilder]: requested to parse from dynamic, but the input is null.',
      );
    }

    return result;
  }

  static TabBarBuilderModel? maybeFromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    TabBarBuilderModel? result;

    if (map != null) {
      if (map is String) {
        map = yaon.parse(
          map,
          normalize: true,
        );
      }

      if (map is TabBarBuilderModel) {
        result = map;
      } else {
        registry ??= JsonWidgetRegistry.instance;
        map = registry.processArgs(map, <String>{}).value;
        result = TabBarBuilderModel(
          args,
          automaticIndicatorColorAdjustment: JsonClass.parseBool(
            map['automaticIndicatorColorAdjustment'],
            whenNull: true,
          ),
          controller: map['controller'],
          dividerColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['dividerColor'],
              validate: false,
            );

            return parsed;
          }(),
          dividerHeight: () {
            dynamic parsed = JsonClass.maybeParseDouble(map['dividerHeight']);

            return parsed;
          }(),
          dragStartBehavior: () {
            dynamic parsed = ThemeDecoder.decodeDragStartBehavior(
              map['dragStartBehavior'],
              validate: false,
            );
            parsed ??= DragStartBehavior.start;

            return parsed;
          }(),
          enableFeedback: JsonClass.maybeParseBool(
            map['enableFeedback'],
          ),
          indicator: map['indicator'],
          indicatorColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['indicatorColor'],
              validate: false,
            );

            return parsed;
          }(),
          indicatorPadding: () {
            dynamic parsed = ThemeDecoder.decodeEdgeInsetsGeometry(
              map['indicatorPadding'],
              validate: false,
            );
            parsed ??= EdgeInsets.zero;

            return parsed;
          }(),
          indicatorSize: () {
            dynamic parsed = ThemeDecoder.decodeTabBarIndicatorSize(
              map['indicatorSize'],
              validate: false,
            );

            return parsed;
          }(),
          indicatorWeight: () {
            dynamic parsed = JsonClass.maybeParseDouble(map['indicatorWeight']);

            parsed ??= 2.0;

            return parsed;
          }(),
          isScrollable: JsonClass.parseBool(
            map['isScrollable'],
            whenNull: false,
          ),
          labelColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['labelColor'],
              validate: false,
            );

            return parsed;
          }(),
          labelPadding: () {
            dynamic parsed = ThemeDecoder.decodeEdgeInsetsGeometry(
              map['labelPadding'],
              validate: false,
            );

            return parsed;
          }(),
          labelStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['labelStyle'],
              validate: false,
            );

            return parsed;
          }(),
          mouseCursor: () {
            dynamic parsed = ThemeDecoder.decodeMouseCursor(
              map['mouseCursor'],
              validate: false,
            );

            return parsed;
          }(),
          onTap: map['onTap'],
          overlayColor: () {
            dynamic parsed = ThemeDecoder.decodeMaterialStatePropertyColor(
              map['overlayColor'],
              validate: false,
            );

            return parsed;
          }(),
          padding: () {
            dynamic parsed = ThemeDecoder.decodeEdgeInsetsGeometry(
              map['padding'],
              validate: false,
            );

            return parsed;
          }(),
          physics: () {
            dynamic parsed = ThemeDecoder.decodeScrollPhysics(
              map['physics'],
              validate: false,
            );

            return parsed;
          }(),
          splashBorderRadius: () {
            dynamic parsed = ThemeDecoder.decodeBorderRadius(
              map['splashBorderRadius'],
              validate: false,
            );

            return parsed;
          }(),
          splashFactory: () {
            dynamic parsed = ThemeDecoder.decodeInteractiveInkFeatureFactory(
              map['splashFactory'],
              validate: false,
            );

            return parsed;
          }(),
          tabAlignment: () {
            dynamic parsed = ThemeDecoder.decodeTabAlignment(
              map['tabAlignment'],
              validate: false,
            );

            return parsed;
          }(),
          tabs: () {
            dynamic parsed = JsonWidgetData.fromDynamicList(
              map['tabs'],
              registry: registry,
            );

            if (parsed == null) {
              throw Exception(
                  'Null value encountered for required parameter: [tabs].');
            }
            return parsed;
          }(),
          unselectedLabelColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['unselectedLabelColor'],
              validate: false,
            );

            return parsed;
          }(),
          unselectedLabelStyle: () {
            dynamic parsed = ThemeDecoder.decodeTextStyle(
              map['unselectedLabelStyle'],
              validate: false,
            );

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
      'automaticIndicatorColorAdjustment':
          true == automaticIndicatorColorAdjustment
              ? null
              : automaticIndicatorColorAdjustment,
      'controller': controller,
      'dividerColor': ThemeEncoder.encodeColor(
        dividerColor,
      ),
      'dividerHeight': dividerHeight,
      'dragStartBehavior': DragStartBehavior.start == dragStartBehavior
          ? null
          : ThemeEncoder.encodeDragStartBehavior(
              dragStartBehavior,
            ),
      'enableFeedback': enableFeedback,
      'indicator': indicator,
      'indicatorColor': ThemeEncoder.encodeColor(
        indicatorColor,
      ),
      'indicatorPadding': EdgeInsets.zero == indicatorPadding
          ? null
          : ThemeEncoder.encodeEdgeInsetsGeometry(
              indicatorPadding,
            ),
      'indicatorSize': ThemeEncoder.encodeTabBarIndicatorSize(
        indicatorSize,
      ),
      'indicatorWeight': 2.0 == indicatorWeight ? null : indicatorWeight,
      'isScrollable': false == isScrollable ? null : isScrollable,
      'labelColor': ThemeEncoder.encodeColor(
        labelColor,
      ),
      'labelPadding': ThemeEncoder.encodeEdgeInsetsGeometry(
        labelPadding,
      ),
      'labelStyle': ThemeEncoder.encodeTextStyle(
        labelStyle,
      ),
      'mouseCursor': ThemeEncoder.encodeMouseCursor(
        mouseCursor,
      ),
      'onTap': onTap,
      'overlayColor': ThemeEncoder.encodeMaterialStatePropertyColor(
        overlayColor,
      ),
      'padding': ThemeEncoder.encodeEdgeInsetsGeometry(
        padding,
      ),
      'physics': ThemeEncoder.encodeScrollPhysics(
        physics,
      ),
      'splashBorderRadius': ThemeEncoder.encodeBorderRadius(
        splashBorderRadius,
      ),
      'splashFactory': ThemeEncoder.encodeInteractiveInkFeatureFactory(
        splashFactory,
      ),
      'tabAlignment': ThemeEncoder.encodeTabAlignment(
        tabAlignment,
      ),
      'tabs': JsonClass.toJsonList(tabs),
      'unselectedLabelColor': ThemeEncoder.encodeColor(
        unselectedLabelColor,
      ),
      'unselectedLabelStyle': ThemeEncoder.encodeTextStyle(
        unselectedLabelStyle,
      ),
      ...args,
    });
  }
}

class TabBarSchema {
  static const id =
      'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/convertdifffinger/tab_bar.json';

  static final schema = <String, Object>{
    r'$schema': 'http://json-schema.org/draft-07/schema#',
    r'$id': id,
    'title': 'TabBar',
    'type': 'object',
    'additionalProperties': false,
    'properties': {
      'automaticIndicatorColorAdjustment': SchemaHelper.boolSchema,
      'controller': SchemaHelper.anySchema,
      'dividerColor': SchemaHelper.objectSchema(ColorSchema.id),
      'dividerHeight': SchemaHelper.numberSchema,
      'dragStartBehavior':
          SchemaHelper.objectSchema(DragStartBehaviorSchema.id),
      'enableFeedback': SchemaHelper.boolSchema,
      'indicator': SchemaHelper.anySchema,
      'indicatorColor': SchemaHelper.objectSchema(ColorSchema.id),
      'indicatorPadding':
          SchemaHelper.objectSchema(EdgeInsetsGeometrySchema.id),
      'indicatorSize': SchemaHelper.objectSchema(TabBarIndicatorSizeSchema.id),
      'indicatorWeight': SchemaHelper.numberSchema,
      'isScrollable': SchemaHelper.boolSchema,
      'labelColor': SchemaHelper.objectSchema(ColorSchema.id),
      'labelPadding': SchemaHelper.objectSchema(EdgeInsetsGeometrySchema.id),
      'labelStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
      'mouseCursor': SchemaHelper.objectSchema(MouseCursorSchema.id),
      'onTap': SchemaHelper.anySchema,
      'overlayColor':
          SchemaHelper.objectSchema(MaterialStatePropertyColorSchema.id),
      'padding': SchemaHelper.objectSchema(EdgeInsetsGeometrySchema.id),
      'physics': SchemaHelper.objectSchema(ScrollPhysicsSchema.id),
      'splashBorderRadius': SchemaHelper.objectSchema(BorderRadiusSchema.id),
      'splashFactory':
          SchemaHelper.objectSchema(InteractiveInkFeatureFactorySchema.id),
      'tabAlignment': SchemaHelper.objectSchema(TabAlignmentSchema.id),
      'tabs': SchemaHelper.arraySchema(JsonWidgetDataSchema.id),
      'unselectedLabelColor': SchemaHelper.objectSchema(ColorSchema.id),
      'unselectedLabelStyle': SchemaHelper.objectSchema(TextStyleSchema.id),
    },
  };
}
