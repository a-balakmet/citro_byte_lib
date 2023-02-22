import 'package:flutter/material.dart';

import 'enum_type.dart';

typedef ItemTextBuilder = Widget Function(BuildContext context, int itemIndex);
typedef SelectedItemBuilder = Widget Function(BuildContext context, int itemIndex);
typedef UnSelectedItemBuilder = Widget Function(BuildContext context, int itemIndex);

class FilterBuilder<T> extends StatelessWidget {
  final LAYOUT layoutType;
  final bool isSingleSelection;
  final List<T> filterItems;
  final List<T> selectedItems;
  final Widget? title;
  final Color? dividerColor;
  final bool? isExpanded;
  final Color? expansionIconColor;
  final SelectedItemBuilder selectedItemWidget;
  final UnSelectedItemBuilder nonSelectedItemWidget;
  final ItemTextBuilder itemText;
  final double space;
  final Function(List<T>) onSelection;
  const FilterBuilder({
    Key? key,
    required this.layoutType,
    required this.isSingleSelection,
    required this.filterItems,
    required this.selectedItems,
    this.title,
    this.dividerColor,
    this.isExpanded,
    this.expansionIconColor,
    required this.selectedItemWidget,
    required this.nonSelectedItemWidget,
    required this.itemText,
    required this.space,
    required this.onSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = List.generate(filterItems.length, (index) {
      final model = filterItems[index];
      return GestureDetector(
        onTap: () {
          if (isSingleSelection) {
            if (model != selectedItems[0]) {
              selectedItems.add(model);
              selectedItems.removeAt(0);
            }
          } else {
            if (selectedItems.contains(model)) {
              selectedItems.remove(model);
            } else {
              selectedItems.add(model);
            }
          }
          onSelection(selectedItems);
        },
        child: Container(
          color: Colors.transparent,
          child: <LAYOUT, Widget Function()>{
            LAYOUT.vertical: () => Padding(
                  padding: EdgeInsets.only(bottom: index - 1 != filterItems.length ? space : 0),
                  child: Row(
                    children: [selectorBuilder(model, context, index), SizedBox(width: space), Expanded(child: itemText(context, index))],
                  ),
                ),
            LAYOUT.horizontal: () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [selectorBuilder(model, context, index), SizedBox(height: space), itemText(context, index)],
                ),
            LAYOUT.scrollable: () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: space),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [selectorBuilder(model, context, index), SizedBox(height: space), itemText(context, index)],
                  ),
                ),
          }[layoutType]!(),
        ),
      );
    });

    return <LAYOUT, Widget Function()>{
      LAYOUT.horizontal: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title ?? const SizedBox(),
              SizedBox(height: space),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
            ],
          ),
      LAYOUT.scrollable: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title ?? const SizedBox(),
              SizedBox(height: space),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: space),
                  shrinkWrap: true,
                  children: list,
                ),
              ),
            ],
          ),
      LAYOUT.vertical: () => title != null
          ? Theme(
              data: ThemeData().copyWith(
                dividerColor: dividerColor ?? Colors.transparent,
                iconTheme: const IconThemeData(size: 30),
              ),
              child: ExpansionTile(
                title: title!,
                initiallyExpanded: isExpanded ?? true,
                iconColor: expansionIconColor,
                collapsedIconColor: expansionIconColor,
                tilePadding: EdgeInsets.zero,
                children: list,
              ))
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    }[layoutType]!();
  }

  Widget selectorBuilder(T model, BuildContext context, int index) {
    return selectedItems.contains(model) ? selectedItemWidget(context, index) : nonSelectedItemWidget(context, index);
  }
}
