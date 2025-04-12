import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_styles.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/inventory_screen/bloc/inventory_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> with TickerProviderStateMixin {
  late TabController tabController;

  List<String> tabList = [
    S.current.entry,
    S.current.stock,
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sizeController = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController bfController = TextEditingController();
  TextEditingController shadeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc()..add(InventoryStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                final inventoryBloc = context.read<InventoryBloc>();
                final inventoryList = inventoryBloc.inventoryList;
                return Column(
                  children: [
                    ///Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomHeaderWidget(
                        title: S.current.inventory,
                        titleIcon: AppAssets.inventoryIcon,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleIconSize: 9.w,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    ///Tabs
                    TabBar(
                      controller: tabController,
                      dividerColor: AppColors.TRANSPARENT,
                      labelPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.PRIMARY_COLOR.withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      tabs: [
                        for (int i = 0; i < tabList.length; i++)
                          Text(
                            tabList[i],
                            style: TextStyle(
                              color: AppColors.DARK_GREEN_COLOR.withValues(alpha: 0.8),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),

                    ///View
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ///Entry
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    ///Type
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.current.type,
                                        style: AppStyles.size16W600TextStyle,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        EntryTypeWidget(
                                          title: S.current.add,
                                          index: 0,
                                        ),
                                        EntryTypeWidget(
                                          title: S.current.consume,
                                          index: 1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.h),

                                    ///Items Type
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.current.items,
                                        style: AppStyles.size16W600TextStyle,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ItemsTypeWidget(
                                          title: S.current.reel,
                                          index: 0,
                                        ),
                                        ItemsTypeWidget(
                                          title: S.current.printingPlates,
                                          index: 1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ItemsTypeWidget(
                                          title: S.current.die,
                                          index: 2,
                                        ),
                                        ItemsTypeWidget(
                                          title: S.current.paper,
                                          index: 3,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.h),

                                    ///Size
                                    TextFieldWidget(
                                      controller: sizeController,
                                      title: S.current.size,
                                      hintText: S.current.selectSize,
                                      validator: inventoryBloc.validateSize,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 50,
                                      readOnly: true,
                                      suffixIconConstraints: BoxConstraints(maxWidth: 10.w, minWidth: 10.w),
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.HINT_GREY_COLOR,
                                        size: 5.w,
                                      ),
                                      onTap: () async {
                                        showBottomSheetSelection(
                                          context: context,
                                          itemList: inventoryBloc.sizeList,
                                          title: S.current.selectSize,
                                          selectedItem: sizeController.text,
                                          onPressed: (index, itemName) {
                                            sizeController.text = itemName;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),

                                    ///GSM
                                    TextFieldWidget(
                                      controller: gsmController,
                                      title: S.current.gsm,
                                      hintText: S.current.selectGSM,
                                      validator: inventoryBloc.validateGSM,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 50,
                                      readOnly: true,
                                      suffixIconConstraints: BoxConstraints(maxWidth: 10.w, minWidth: 10.w),
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.HINT_GREY_COLOR,
                                        size: 5.w,
                                      ),
                                      onTap: () async {
                                        showBottomSheetSelection(
                                          context: context,
                                          itemList: inventoryBloc.gsmList,
                                          title: S.current.selectGSM,
                                          selectedItem: gsmController.text,
                                          onPressed: (index, itemName) {
                                            gsmController.text = itemName;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),

                                    ///BF
                                    TextFieldWidget(
                                      controller: bfController,
                                      title: S.current.bf,
                                      hintText: S.current.selectBF,
                                      validator: inventoryBloc.validateBF,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 50,
                                      readOnly: true,
                                      suffixIconConstraints: BoxConstraints(maxWidth: 10.w, minWidth: 10.w),
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.HINT_GREY_COLOR,
                                        size: 5.w,
                                      ),
                                      onTap: () async {
                                        showBottomSheetSelection(
                                          context: context,
                                          itemList: inventoryBloc.bfList,
                                          title: S.current.selectBF,
                                          selectedItem: bfController.text,
                                          onPressed: (index, itemName) {
                                            bfController.text = itemName;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),

                                    ///Shade
                                    TextFieldWidget(
                                      controller: shadeController,
                                      title: S.current.shade,
                                      hintText: S.current.selectShade,
                                      validator: inventoryBloc.validateShade,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 50,
                                      readOnly: true,
                                      suffixIconConstraints: BoxConstraints(maxWidth: 10.w, minWidth: 10.w),
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.HINT_GREY_COLOR,
                                        size: 5.w,
                                      ),
                                      onTap: () async {
                                        showBottomSheetSelection(
                                          context: context,
                                          itemList: inventoryBloc.shadeList,
                                          title: S.current.selectShade,
                                          selectedItem: shadeController.text,
                                          onPressed: (index, itemName) {
                                            shadeController.text = itemName;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),

                                    ///Weight
                                    TextFieldWidget(
                                      controller: weightController,
                                      title: S.current.weight,
                                      hintText: S.current.enterWeight,
                                      validator: inventoryBloc.validateWeight,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 5,
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 2.h),

                                    ///Quantity
                                    TextFieldWidget(
                                      controller: quantityController,
                                      title: S.current.quantity,
                                      hintText: S.current.enterQuantity,
                                      validator: inventoryBloc.validateQuantity,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 5,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    SizedBox(height: 3.h),

                                    ///Button
                                    BlocConsumer<InventoryBloc, InventoryState>(
                                      listener: (context, state) {
                                        if (state is InventoryEntrySuccessState) {
                                          context.pop();
                                          inventoryBloc.add(InventoryEntryTypeEvent(entryTypeIndex: 0));
                                          inventoryBloc.add(InventoryItemsTypeEvent(itemsTypeIndex: 0));
                                          sizeController.clear();
                                          gsmController.clear();
                                          bfController.clear();
                                          shadeController.clear();
                                          weightController.clear();
                                          quantityController.clear();
                                          inventoryBloc.add(InventoryGetInventoryEvent(isLoading: true));
                                          Utils.handleMessage(message: state.successMessage);
                                        }
                                      },
                                      builder: (context, state) {
                                        final inventoryBloc = context.read<InventoryBloc>();
                                        return ButtonWidget(
                                          onPressed: () {
                                            if (formKey.currentState?.validate() == true) {
                                              inventoryBloc.add(
                                                InventoryEntryButtonClickEvent(
                                                  isValidate: formKey.currentState?.validate() == true,
                                                  entryType: inventoryBloc.entryList[inventoryBloc.entryTypeIndex],
                                                  itemType: inventoryBloc.itemList[inventoryBloc.itemsTypeIndex],
                                                  size: sizeController.text.trim(),
                                                  gsm: gsmController.text.trim(),
                                                  bf: bfController.text.trim(),
                                                  shade: shadeController.text.trim(),
                                                  weight: weightController.text.trim(),
                                                  quantity: quantityController.text.trim(),
                                                ),
                                              );
                                            }
                                          },
                                          isLoading: (state is InventoryEntryLoadingState) ? state.isLoading : false,
                                          buttonTitle: S.current.add,
                                        );
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///Stock
                          Column(
                            children: [
                              if (state is InventoryGetInventoryLoadingState && state.isLoading == true)
                                const Expanded(
                                  child: Center(
                                    child: LoadingWidget(),
                                  ),
                                )
                              else if (inventoryList.isEmpty)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      S.current.noDataFound,
                                      style: TextStyle(
                                        color: AppColors.PRIMARY_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: AnimationLimiter(
                                    child: ListView.separated(
                                      itemCount: inventoryList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                      itemBuilder: (context, index) {
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 400),
                                          child: SlideAnimation(
                                            verticalOffset: 50.0,
                                            child: FadeInAnimation(
                                              child: Card(
                                                color: AppColors.TRANSPARENT,
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: ExpansionTile(
                                                  title: SizedBox(
                                                    height: Device.screenType == ScreenType.tablet
                                                        ? Device.aspectRatio < 0.5
                                                            ? 4.h
                                                            : 6.h
                                                        : null,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${index + 1}. ',
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColors.SECONDARY_COLOR,
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        Flexible(
                                                          child: Text(
                                                            '',
                                                            style: TextStyle(
                                                              color: AppColors.SECONDARY_COLOR,
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  tilePadding: EdgeInsets.only(
                                                    left: 3.w,
                                                    right: Device.screenType == ScreenType.tablet ? 0.5.w : 2.w,
                                                  ),
                                                  trailing: const SizedBox(),
                                                  dense: true,
                                                  collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                  backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.7),
                                                  iconColor: AppColors.SECONDARY_COLOR,
                                                  collapsedShape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 2.h);
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ///Entry Type
  Widget EntryTypeWidget({
    required String title,
    required int index,
  }) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      buildWhen: (previous, current) => current is InventoryEntryTypeState,
      builder: (context, state) {
        final inventoryBloc = context.read<InventoryBloc>();
        return InkWell(
          onTap: () {
            inventoryBloc.add(InventoryEntryTypeEvent(entryTypeIndex: index));
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 15.w, minHeight: 2.5.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(0.5.w),
                  decoration: BoxDecoration(
                    color: inventoryBloc.entryTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: inventoryBloc.entryTypeIndex == index ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: AppColors.SECONDARY_COLOR,
                      size: 4.w,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///Items Type
  Widget ItemsTypeWidget({
    required String title,
    required int index,
  }) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      buildWhen: (previous, current) => current is InventoryItemsTypeState,
      builder: (context, state) {
        final inventoryBloc = context.read<InventoryBloc>();
        return InkWell(
          onTap: () {
            inventoryBloc.add(InventoryItemsTypeEvent(itemsTypeIndex: index));
          },
          child: SizedBox(
            width: 40.w,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(0.5.w),
                  decoration: BoxDecoration(
                    color: inventoryBloc.itemsTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: inventoryBloc.itemsTypeIndex == index ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: AppColors.SECONDARY_COLOR,
                      size: 4.w,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///Size & GSM
  Future<void> showBottomSheetSelection({
    required BuildContext context,
    required List<String> itemList,
    required String selectedItem,
    required void Function(int index, String itemName)? onPressed,
    required String title,
  }) async {
    int selectedIndex = itemList.indexWhere((element) => element == selectedItem);
    TextEditingController addItemController = TextEditingController(text: selectedIndex == -1 ? selectedItem : "");
    await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w, maxHeight: 90.h, minHeight: 0.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.WHITE_COLOR,
      builder: (context) {
        final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
        return StatefulBuilder(builder: (context, itemState) {
          return GestureDetector(
            onTap: Utils.unfocus,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Back, Title & Select
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.SECONDARY_COLOR,
                            size: 6.w,
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            onPressed?.call(selectedIndex, selectedIndex == -1 ? addItemController.text : itemList[selectedIndex]);
                          },
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            S.current.select,
                            style: TextStyle(
                              color: AppColors.DARK_GREEN_COLOR,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.HINT_GREY_COLOR,
                      thickness: 1,
                    ),

                    ///Add Size
                    Padding(
                      padding: EdgeInsets.only(bottom: keyboardPadding != 0 ? 13.h : 0),
                      child: TextFieldWidget(
                        controller: addItemController,
                        title: S.current.add,
                        hintText: S.current.enterSize,
                        primaryColor: AppColors.SECONDARY_COLOR,
                        secondaryColor: AppColors.PRIMARY_COLOR,
                        suffixIcon: InkWell(
                          onTap: () {
                            if (addItemController.text.isNotEmpty) {
                              context.pop();
                              onPressed?.call(-1, addItemController.text);
                            }
                          },
                          child: SizedBox(
                            width: 10.w,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  child: VerticalDivider(
                                    color: AppColors.PRIMARY_COLOR,
                                    width: 1,
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: Device.screenType == ScreenType.mobile
                                          ? 5.w
                                          : Device.aspectRatio > 5
                                              ? 3.w
                                              : 5.w,
                                      color: AppColors.WHITE_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    ///Sizes
                    Stack(
                      children: [
                        ///Background
                        Positioned(
                          top: 7.5.h,
                          right: 0,
                          left: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.SECONDARY_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(height: 5.h),
                          ),
                        ),

                        ///Type List
                        CarouselSlider.builder(
                          itemCount: itemList.length,
                          itemBuilder: (context, index, realIndex) {
                            return ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  selectedIndex == index
                                      ? AppColors.PRIMARY_COLOR
                                      : selectedIndex >= index
                                          ? AppColors.DARK_BLACK_COLOR.withValues(alpha: 0.5)
                                          : AppColors.PRIMARY_COLOR,
                                  selectedIndex == index
                                      ? AppColors.PRIMARY_COLOR
                                      : selectedIndex >= index
                                          ? AppColors.PRIMARY_COLOR
                                          : AppColors.DARK_BLACK_COLOR.withValues(alpha: 0.5),
                                ],
                                transform: const GradientRotation(80),
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    itemList[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedIndex == index ? AppColors.PRIMARY_COLOR : AppColors.DARK_BLACK_COLOR,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            scrollDirection: Axis.vertical,
                            viewportFraction: 0.2,
                            height: 20.h,
                            initialPage: selectedIndex,
                            onPageChanged: (index, reason) {
                              itemState(() {
                                if (selectedIndex != -1) {
                                  addItemController.clear();
                                }
                                selectedIndex = index;
                              });
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            enableInfiniteScroll: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
