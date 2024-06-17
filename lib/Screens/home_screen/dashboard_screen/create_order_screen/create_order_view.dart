import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/create_order_screen/bloc/create_order_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/textfield_widget.dart';
import 'package:raj_packaging/generated/l10n.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateOrderView extends StatefulWidget {
  const CreateOrderView({super.key});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  final GlobalKey<FormState> _createOrderFormKey = GlobalKey<FormState>();

  final TextEditingController _partyNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _orderSizeRollDeckleController = TextEditingController();
  final TextEditingController _orderSizeSheetDeckleController = TextEditingController();
  final TextEditingController _orderSizeSheetCuttingController = TextEditingController();
  final TextEditingController _orderSizeBoxRSCLController = TextEditingController();
  final TextEditingController _orderSizeBoxRSCBController = TextEditingController();
  final TextEditingController _orderSizeBoxRSCHController = TextEditingController();
  final TextEditingController _actualSheetSizeBoxRSCDeckleController = TextEditingController();
  final TextEditingController _actualSheetSizeBoxRSCCuttingController = TextEditingController();
  final TextEditingController _orderSizeBoxDiePunchDeckleController = TextEditingController();
  final TextEditingController _orderSizeBoxDiePunchCuttingController = TextEditingController();

  final TextEditingController _specificationRollPaperController = TextEditingController();
  final TextEditingController _specificationRollFluteController = TextEditingController();
  final TextEditingController _specificationSheetPlyController = TextEditingController(text: "2");
  final TextEditingController _specificationSheetTopPaperController = TextEditingController();
  final TextEditingController _specificationSheetPaperController = TextEditingController();
  final TextEditingController _specificationSheetFluteController = TextEditingController();
  final TextEditingController _specificationBoxRSCPlyController = TextEditingController(text: "3");
  final TextEditingController _specificationBoxRSCTopPaperController = TextEditingController();
  final TextEditingController _specificationBoxRSCPaperController = TextEditingController();
  final TextEditingController _specificationBoxRSCFluteController = TextEditingController();
  final TextEditingController _specificationBoxDiePunchPlyController = TextEditingController(text: "2");
  final TextEditingController _specificationBoxDiePunchTopPaperController = TextEditingController();
  final TextEditingController _specificationBoxDiePunchPaperController = TextEditingController();
  final TextEditingController _specificationBoxDiePunchFluteController = TextEditingController();

  final TextEditingController _orderQuantityController = TextEditingController();

  final TextEditingController _productionSizeRollDeckleController = TextEditingController();
  final TextEditingController _productionSizeSheetDeckleController = TextEditingController();
  final TextEditingController _productionSizeSheetCuttingController = TextEditingController();
  final TextEditingController _productionSheetSizeBoxRSCDeckleController = TextEditingController();
  final TextEditingController _productionSheetSizeBoxRSCCuttingController = TextEditingController();
  final TextEditingController _productionSheetSizeBoxDiePunchDeckleController = TextEditingController();
  final TextEditingController _productionSheetSizeBoxDiePunchCuttingController = TextEditingController();

  final TextEditingController _productionQuantityController = TextEditingController();

  final List<String> paperAndFluteTypesForRollList = [
    "100 gsm",
    "150 gsm",
    "180 gsm",
  ];

  final List<String> plyTypesForSheetAndBoxDiePunchList = [
    "2",
    "3",
    "5",
    "7",
    "9",
    "11",
  ];

  final List<String> plyTypesForBoxRSCList = [
    "3",
    "5",
    "7",
    "9",
    "11",
  ];

  final List<String> topPaperPaperAndFluteTypesForSheetAndBoxList = [
    "100 gsm",
    "150 gsm",
    "180 gsm",
    "230 gsm",
    "250 gsm",
    "Plastic",
  ];

  ///Get Production Quantity
  void _getProductionQuantity(CreateOrderBloc createOrderBloc) {
    if (createOrderBloc.orderTypeIndex == 0) {
      _productionQuantityController.text = createOrderBloc.productionQuantityCalculatorForRoll(
        productionQuantityController: _productionQuantityController,
        orderQuantity: _orderQuantityController.text,
        orderSizeDeckle: _orderSizeRollDeckleController.text,
        productionSizeDeckle: _productionSizeRollDeckleController.text,
      );
    } else if (createOrderBloc.orderTypeIndex == 1) {
      createOrderBloc.productionQuantityCalculatorForSheet(
        productionQuantityController: _productionQuantityController,
        orderQuantity: _orderQuantityController.text,
        orderSizeDeckle: _orderSizeSheetDeckleController.text,
        productionSizeDeckle: _productionSizeSheetDeckleController.text,
        orderSizeCutting: _orderSizeSheetCuttingController.text,
        productionSizeCutting: _productionSizeSheetCuttingController.text,
      );
    }
  }

  ///Get Actual Sheet Size for Box RSC
  void _getActualSheetSizeForBoxRSC(CreateOrderBloc createOrderBloc) {
    createOrderBloc.actualSheetSizeCalculatorForBoxRSC(
      actualSheetSizeBoxRSCDecalController: _actualSheetSizeBoxRSCDeckleController,
      actualSheetSizeBoxRSCCuttingController: _actualSheetSizeBoxRSCCuttingController,
      orderSizeL: _orderSizeBoxRSCLController.text,
      orderSizeB: _orderSizeBoxRSCBController.text,
      orderSizeH: _orderSizeBoxRSCHController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderBloc()..add(CreateOrderStartedEvent()),
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
            child: Column(
              children: [
                ///Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: CustomHeaderWidget(
                    title: S.current.createOrder,
                    titleIcon: AppAssets.createOrderImage,
                    onBackPressed: () {
                      context.pop();
                    },
                  ),
                ),
                SizedBox(height: 3.h),

                ///Fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Form(
                        key: _createOrderFormKey,
                        child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
                          builder: (context, state) {
                            final createOrderBloc = context.read<CreateOrderBloc>();
                            return Column(
                              children: [
                                ///Party Name
                                TextFieldWidget(
                                  controller: _partyNameController,
                                  title: S.current.partyName,
                                  hintText: S.current.selectParty,
                                  validator: createOrderBloc.validatePartyList,
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
                                    await showBottomSheetParty(context: context);
                                  },
                                ),
                                SizedBox(height: 1.h),

                                ///Phone Number
                                TextFieldWidget(
                                  controller: _phoneNumberController,
                                  title: S.current.phoneNumber,
                                  hintText: S.current.enterPhoneNumber,
                                  validator: createOrderBloc.validatePartyList,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 1.h),

                                ///Product Name
                                TextFieldWidget(
                                  controller: _productNameController,
                                  title: S.current.product,
                                  hintText: S.current.selectProduct,
                                  validator: createOrderBloc.validateProductList,
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
                                    await showBottomSheetProduct(context: context);
                                  },
                                ),
                                SizedBox(height: 1.h),

                                ///Order Type[Roll, Sheet, Box]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.current.orderType,
                                    style: TextStyle(
                                      color: AppColors.PRIMARY_COLOR,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.3.h),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.PRIMARY_COLOR,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ///Roll
                                        OrderTypeWidget(title: S.current.roll, index: 0),
                                        SizedBox(width: 2.w),

                                        ///Sheet
                                        OrderTypeWidget(title: S.current.sheet, index: 1),
                                        SizedBox(width: 2.w),

                                        ///Box
                                        OrderTypeWidget(title: S.current.box, index: 2),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                ///Box Type[RSC, Die Punch]
                                if (createOrderBloc.orderTypeIndex == 2) ...[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.current.boxType,
                                      style: TextStyle(
                                        color: AppColors.PRIMARY_COLOR,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.3.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ///Roll
                                      BoxTypeWidget(title: S.current.rsc, index: 0),
                                      SizedBox(width: 2.w),

                                      ///Sheet
                                      BoxTypeWidget(title: S.current.diePunch, index: 1),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                ],

                                ///Order size [Deckle x Cutting]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.current.orderSize,
                                    style: TextStyle(
                                      color: AppColors.PRIMARY_COLOR,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.6.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Deckle Or L
                                    Flexible(
                                      child: TextFieldWidget(
                                        controller: createOrderBloc.orderTypeIndex == 1
                                            ? _orderSizeSheetDeckleController
                                            : createOrderBloc.orderTypeIndex == 2
                                                ? createOrderBloc.boxTypeIndex == 1
                                                    ? _orderSizeBoxDiePunchDeckleController
                                                    : _orderSizeBoxRSCLController
                                                : _orderSizeRollDeckleController,
                                        title: "${createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? S.current.l : S.current.deckle} (${S.current.inch})",
                                        hintText: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? S.current.enterLSize : S.current.enterDeckleSize,
                                        validator: createOrderBloc.validateDeckleSize,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0) {
                                              _getActualSheetSizeForBoxRSC(createOrderBloc);
                                            } else if (createOrderBloc.orderTypeIndex != 2) {
                                              _getProductionQuantity(createOrderBloc);
                                            }
                                          }
                                        },
                                      ),
                                    ),

                                    ///Cross(x)
                                    if (createOrderBloc.orderTypeIndex != 0) ...[
                                      SizedBox(width: 1.5.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 3.3.h),
                                        child: SizedBox(
                                          height: 4.4.h,
                                          child: Center(
                                            child: Text(
                                              'x',
                                              style: TextStyle(
                                                color: AppColors.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1.5.w),
                                    ],

                                    ///Cutting or B
                                    if (createOrderBloc.orderTypeIndex != 0)
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: createOrderBloc.orderTypeIndex == 2
                                              ? createOrderBloc.boxTypeIndex == 1
                                                  ? _orderSizeBoxDiePunchCuttingController
                                                  : _orderSizeBoxRSCBController
                                              : _orderSizeSheetCuttingController,
                                          title: "${createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? S.current.b : S.current.cutting} (${S.current.inch})",
                                          hintText: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? S.current.enterBSize : S.current.enterCuttingSize,
                                          validator: createOrderBloc.validateCuttingSize,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0) {
                                                _getActualSheetSizeForBoxRSC(createOrderBloc);
                                              } else if (createOrderBloc.orderTypeIndex != 2) {
                                                _getProductionQuantity(createOrderBloc);
                                              }
                                            }
                                          },
                                        ),
                                      ),

                                    ///Cross(x) & H
                                    if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0) ...[
                                      SizedBox(width: 1.5.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 3.3.h),
                                        child: SizedBox(
                                          height: 4.4.h,
                                          child: Center(
                                            child: Text(
                                              'x',
                                              style: TextStyle(
                                                color: AppColors.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1.5.w),

                                      ///H
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: _orderSizeBoxRSCHController,
                                          title: "${S.current.h} (${S.current.inch})",
                                          hintText: S.current.enterHSize,
                                          validator: createOrderBloc.validateCuttingSize,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _getActualSheetSizeForBoxRSC(createOrderBloc);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Specification Type [Ply][Top Paper, Paper, Flute]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.current.specification,
                                    style: TextStyle(
                                      color: AppColors.PRIMARY_COLOR,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.7.h),
                                if (createOrderBloc.orderTypeIndex != 0) ...[
                                  ///Ply
                                  TextFieldWidget(
                                    controller: createOrderBloc.orderTypeIndex == 2
                                        ? createOrderBloc.boxTypeIndex == 1
                                            ? _specificationBoxDiePunchPlyController
                                            : _specificationBoxRSCPlyController
                                        : _specificationSheetPlyController,
                                    title: S.current.ply,
                                    hintText: S.current.selectPly,
                                    validator: createOrderBloc.validatePly,
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
                                      await showBottomSheetSpecificationType(
                                        context: context,
                                        typeList: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? plyTypesForBoxRSCList : plyTypesForSheetAndBoxDiePunchList,
                                        selectedType: createOrderBloc.orderTypeIndex == 2
                                            ? createOrderBloc.boxTypeIndex == 1
                                                ? _specificationBoxDiePunchPlyController.text
                                                : _specificationBoxRSCPlyController.text
                                            : _specificationSheetPlyController.text,
                                        onPressed: (index, typeName) {
                                          if (createOrderBloc.orderTypeIndex == 2) {
                                            if (createOrderBloc.boxTypeIndex == 1) {
                                              _specificationBoxDiePunchPlyController.text = plyTypesForSheetAndBoxDiePunchList[index];
                                              createOrderBloc.add(CreateOrderPlyBoxDiePunchTypeEvent(plyBoxDiePunchTypeIndex: index));
                                            } else {
                                              _specificationBoxRSCPlyController.text = plyTypesForBoxRSCList[index];
                                              createOrderBloc.add(CreateOrderPlyBoxRSCTypeEvent(plyBoxRSCTypeIndex: index));
                                            }
                                          } else {
                                            _specificationSheetPlyController.text = plyTypesForSheetAndBoxDiePunchList[index];
                                            createOrderBloc.add(CreateOrderPlySheetTypeEvent(plySheetTypeIndex: index));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Top Paper
                                    if (createOrderBloc.orderTypeIndex != 0 && (createOrderBloc.plySheetTypeIndex != 0 || createOrderBloc.boxTypeIndex == 0 || createOrderBloc.plyBoxDiePunchTypeIndex != 0)) ...[
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: createOrderBloc.orderTypeIndex == 2
                                              ? createOrderBloc.boxTypeIndex == 1
                                                  ? _specificationBoxDiePunchTopPaperController
                                                  : _specificationBoxRSCTopPaperController
                                              : _specificationSheetTopPaperController,
                                          title: S.current.topPaper,
                                          hintText: S.current.selectType,
                                          validator: createOrderBloc.validateSpecificationType,
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
                                            await showBottomSheetSpecificationType(
                                              context: context,
                                              typeList: topPaperPaperAndFluteTypesForSheetAndBoxList,
                                              selectedType: createOrderBloc.orderTypeIndex == 2
                                                  ? createOrderBloc.boxTypeIndex == 1
                                                      ? _specificationBoxDiePunchTopPaperController.text
                                                      : _specificationBoxRSCTopPaperController.text
                                                  : _specificationSheetTopPaperController.text,
                                              manualAddTypeEnable: createOrderBloc.orderTypeIndex != 0,
                                              onPressed: (index, typeName) {
                                                if (createOrderBloc.orderTypeIndex == 2) {
                                                  if (createOrderBloc.boxTypeIndex == 1) {
                                                    _specificationBoxDiePunchTopPaperController.text = typeName;
                                                  } else {
                                                    _specificationBoxRSCTopPaperController.text = typeName;
                                                  }
                                                } else {
                                                  _specificationSheetTopPaperController.text = typeName;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                    ],

                                    ///Paper
                                    Flexible(
                                      child: TextFieldWidget(
                                        controller: createOrderBloc.orderTypeIndex == 2
                                            ? createOrderBloc.boxTypeIndex == 1
                                                ? _specificationBoxDiePunchPaperController
                                                : _specificationBoxRSCPaperController
                                            : createOrderBloc.orderTypeIndex == 1
                                                ? _specificationSheetPaperController
                                                : _specificationRollPaperController,
                                        title: S.current.paper,
                                        hintText: S.current.selectType,
                                        validator: createOrderBloc.validateSpecificationType,
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
                                          await showBottomSheetSpecificationType(
                                            context: context,
                                            typeList: createOrderBloc.orderTypeIndex != 0 ? topPaperPaperAndFluteTypesForSheetAndBoxList : paperAndFluteTypesForRollList,
                                            selectedType: createOrderBloc.orderTypeIndex == 2
                                                ? createOrderBloc.boxTypeIndex == 1
                                                    ? _specificationBoxDiePunchPaperController.text
                                                    : _specificationBoxRSCPaperController.text
                                                : createOrderBloc.orderTypeIndex == 1
                                                    ? _specificationSheetPaperController.text
                                                    : _specificationRollPaperController.text,
                                            manualAddTypeEnable: createOrderBloc.orderTypeIndex != 0,
                                            onPressed: (index, typeName) {
                                              if (createOrderBloc.orderTypeIndex == 2) {
                                                if (createOrderBloc.boxTypeIndex == 1) {
                                                  _specificationBoxDiePunchPaperController.text = typeName;
                                                } else {
                                                  _specificationBoxRSCPaperController.text = typeName;
                                                }
                                              } else if (createOrderBloc.orderTypeIndex == 1) {
                                                _specificationSheetPaperController.text = typeName;
                                              } else {
                                                _specificationRollPaperController.text = typeName;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 2.w),

                                    ///Flute
                                    Flexible(
                                      child: TextFieldWidget(
                                        controller: createOrderBloc.orderTypeIndex == 2
                                            ? createOrderBloc.boxTypeIndex == 1
                                                ? _specificationBoxDiePunchFluteController
                                                : _specificationBoxRSCFluteController
                                            : createOrderBloc.orderTypeIndex == 1
                                                ? _specificationSheetFluteController
                                                : _specificationRollFluteController,
                                        title: S.current.flute,
                                        hintText: S.current.selectType,
                                        validator: createOrderBloc.validateSpecificationType,
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
                                          await showBottomSheetSpecificationType(
                                            context: context,
                                            typeList: createOrderBloc.orderTypeIndex != 0 ? topPaperPaperAndFluteTypesForSheetAndBoxList : paperAndFluteTypesForRollList,
                                            selectedType: createOrderBloc.orderTypeIndex == 2
                                                ? createOrderBloc.boxTypeIndex == 1
                                                    ? _specificationBoxDiePunchFluteController.text
                                                    : _specificationBoxRSCFluteController.text
                                                : createOrderBloc.orderTypeIndex == 1
                                                    ? _specificationSheetFluteController.text
                                                    : _specificationRollPaperController.text,
                                            manualAddTypeEnable: createOrderBloc.orderTypeIndex != 0,
                                            onPressed: (index, typeName) {
                                              if (createOrderBloc.orderTypeIndex == 2) {
                                                if (createOrderBloc.boxTypeIndex == 1) {
                                                  _specificationBoxDiePunchFluteController.text = typeName;
                                                } else {
                                                  _specificationBoxRSCFluteController.text = typeName;
                                                }
                                              } else if (createOrderBloc.orderTypeIndex == 1) {
                                                _specificationSheetFluteController.text = typeName;
                                              } else {
                                                _specificationRollFluteController.text = typeName;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Order Quantity [Rolls, Sheets, Boxes]
                                TextFieldWidget(
                                  controller: _orderQuantityController,
                                  title: "${S.current.orderQuantity} (${createOrderBloc.orderTypeIndex == 1 ? S.current.sheets : S.current.rolls})",
                                  hintText: S.current.enterQuantity,
                                  validator: createOrderBloc.validateQuantity,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      _getProductionQuantity(createOrderBloc);
                                    }
                                  },
                                ),
                                SizedBox(height: 1.h),

                                ///Production Size [Inch]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.current.productionSize,
                                    style: TextStyle(
                                      color: AppColors.PRIMARY_COLOR,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.7.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Deckle
                                    Flexible(
                                      child: TextFieldWidget(
                                        controller: createOrderBloc.orderTypeIndex == 1 ? _productionSizeSheetDeckleController : _productionSizeRollDeckleController,
                                        title: "${S.current.deckle} (${S.current.inch})",
                                        hintText: S.current.enterDeckleSize,
                                        validator: createOrderBloc.validateDeckleSize,
                                        textInputAction: TextInputAction.next,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            _getProductionQuantity(createOrderBloc);
                                          }
                                        },
                                      ),
                                    ),

                                    ///Cross(x)
                                    if (createOrderBloc.orderTypeIndex == 1) ...[
                                      SizedBox(width: 1.5.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 3.3.h),
                                        child: SizedBox(
                                          height: 4.4.h,
                                          child: Center(
                                            child: Text(
                                              'x',
                                              style: TextStyle(
                                                color: AppColors.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1.5.w),
                                    ],

                                    ///Cutting
                                    if (createOrderBloc.orderTypeIndex == 1)
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: _productionSizeSheetCuttingController,
                                          title: "${S.current.cutting} (${S.current.inch})",
                                          hintText: S.current.enterCuttingSize,
                                          validator: createOrderBloc.validateCuttingSize,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _getProductionQuantity(createOrderBloc);
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Production Quantity [Rolls]
                                TextFieldWidget(
                                  controller: _productionQuantityController,
                                  title: "${S.current.productionQuantity} (${createOrderBloc.orderTypeIndex == 1 ? S.current.sheets : S.current.rolls})",
                                  hintText: S.current.enterQuantity,
                                  validator: createOrderBloc.validateQuantity,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                ///Create Order Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  child: ButtonWidget(
                    onPressed: () async {},
                    isLoading: false,
                    buttonTitle: S.current.createOrder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Party Bottom Sheet
  Future<void> showBottomSheetParty({required BuildContext context}) async {
    final createOrderBloc = context.read<CreateOrderBloc>();

    GlobalKey<FormState> addPartyFormKey = GlobalKey<FormState>();
    TextEditingController addPartyController = TextEditingController();

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
        return GestureDetector(
          onTap: Utils.unfocus,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h).copyWith(bottom: keyboardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back & Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.selectParty,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
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
                    ],
                  ),
                  Divider(
                    color: AppColors.HINT_GREY_COLOR,
                    thickness: 1,
                  ),
                  // SizedBox(height: 2.h),

                  ///Add party
                  Form(
                    key: addPartyFormKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextFieldWidget(
                            controller: addPartyController,
                            title: S.current.add,
                            hintText: S.current.enterPartyName,
                            validator: createOrderBloc.validatePartyName,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: ElevatedButton(
                            onPressed: () {
                              if (addPartyFormKey.currentState?.validate() == true) {
                                _partyNameController.text = addPartyController.text;
                                context.pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.SECONDARY_COLOR,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              maximumSize: Size(12.w, 4.4.h),
                              minimumSize: Size(12.w, 4.4.h),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              size: 5.w,
                              color: AppColors.WHITE_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///Product Bottom Sheet
  Future<void> showBottomSheetProduct({required BuildContext context}) async {
    final createOrderBloc = context.read<CreateOrderBloc>();

    GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
    TextEditingController addProductController = TextEditingController();

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
        return GestureDetector(
          onTap: Utils.unfocus,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h).copyWith(bottom: keyboardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back & Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.selectProduct,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
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
                    ],
                  ),
                  Divider(
                    color: AppColors.HINT_GREY_COLOR,
                    thickness: 1,
                  ),
                  // SizedBox(height: 2.h),

                  ///Add product
                  Form(
                    key: addProductFormKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextFieldWidget(
                            controller: addProductController,
                            title: S.current.add,
                            hintText: S.current.enterProductName,
                            validator: createOrderBloc.validateProductName,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: ElevatedButton(
                            onPressed: () {
                              if (addProductFormKey.currentState?.validate() == true) {
                                _productNameController.text = addProductController.text;
                                context.pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.SECONDARY_COLOR,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              maximumSize: Size(12.w, 4.4.h),
                              minimumSize: Size(12.w, 4.4.h),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              size: 5.w,
                              color: AppColors.WHITE_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///Order Type
  Widget OrderTypeWidget({
    required String title,
    required int index,
  }) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      buildWhen: (previous, current) => current is CreateOrderTypeState,
      builder: (context, state) {
        final createOrderBloc = context.read<CreateOrderBloc>();
        return InkWell(
          onTap: () {
            _createOrderFormKey.currentState?.reset();
            createOrderBloc.add(CreateOrderTypeEvent(orderTypeIndex: index));
            if (index == 1) {
              createOrderBloc.add(CreateOrderPlySheetTypeEvent(plySheetTypeIndex: plyTypesForSheetAndBoxDiePunchList.indexOf(_specificationSheetPlyController.text)));
            } else if (index == 2) {
              createOrderBloc.add(CreateOrderBoxTypeEvent(boxTypeIndex: createOrderBloc.boxTypeIndex));
            }
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 15.w, minHeight: 2.5.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(0.5.w),
                  decoration: BoxDecoration(
                    color: createOrderBloc.orderTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: createOrderBloc.orderTypeIndex == index ? 1 : 0,
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

  ///Box Type
  Widget BoxTypeWidget({
    required String title,
    required int index,
  }) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      buildWhen: (previous, current) => current is CreateOrderTypeState,
      builder: (context, state) {
        final createOrderBloc = context.read<CreateOrderBloc>();
        return InkWell(
          onTap: () {
            createOrderBloc.add(CreateOrderBoxTypeEvent(boxTypeIndex: index));
            if (index == 1) {
              createOrderBloc.add(CreateOrderPlyBoxDiePunchTypeEvent(plyBoxDiePunchTypeIndex: plyTypesForSheetAndBoxDiePunchList.indexOf(_specificationBoxDiePunchPlyController.text)));
            } else {
              createOrderBloc.add(CreateOrderPlyBoxRSCTypeEvent(plyBoxRSCTypeIndex: plyTypesForBoxRSCList.indexOf(_specificationBoxRSCPlyController.text)));
            }
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 15.w, minHeight: 2.5.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(0.5.w),
                  decoration: BoxDecoration(
                    color: createOrderBloc.boxTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: createOrderBloc.boxTypeIndex == index ? 1 : 0,
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

  ///Specification Type
  Future<void> showBottomSheetSpecificationType({
    required BuildContext context,
    required List<String> typeList,
    required String selectedType,
    required void Function(int index, String typeName)? onPressed,
    bool manualAddTypeEnable = false,
  }) async {
    int selectedTypeIndex = typeList.indexWhere((element) => element == selectedType);
    TextEditingController addTypeController = TextEditingController(text: selectedTypeIndex == -1 ? selectedType : "");
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
        return StatefulBuilder(builder: (context, specificationTypeState) {
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
                          S.current.selectType,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            onPressed?.call(selectedTypeIndex, selectedTypeIndex == -1 ? addTypeController.text : typeList[selectedTypeIndex]);
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

                    ///Add Type
                    if (manualAddTypeEnable)
                      Padding(
                        padding: EdgeInsets.only(bottom: keyboardPadding != 0 ? 13.h : 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: TextFieldWidget(
                                controller: addTypeController,
                                title: S.current.add,
                                hintText: S.current.enterType,
                                primaryColor: AppColors.SECONDARY_COLOR,
                                secondaryColor: AppColors.PRIMARY_COLOR,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (addTypeController.text.isNotEmpty) {
                                    context.pop();
                                    onPressed?.call(-1, addTypeController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.SECONDARY_COLOR,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  maximumSize: Size(12.w, 4.4.h),
                                  minimumSize: Size(12.w, 4.4.h),
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 5.w,
                                  color: AppColors.WHITE_COLOR,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 2.h),

                    ///Types
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
                          itemCount: typeList.length,
                          itemBuilder: (context, index, realIndex) {
                            return ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  selectedTypeIndex == index
                                      ? AppColors.PRIMARY_COLOR
                                      : selectedTypeIndex >= index
                                          ? AppColors.DARK_BLACK_COLOR.withOpacity(0.5)
                                          : AppColors.PRIMARY_COLOR,
                                  selectedTypeIndex == index
                                      ? AppColors.PRIMARY_COLOR
                                      : selectedTypeIndex >= index
                                          ? AppColors.PRIMARY_COLOR
                                          : AppColors.DARK_BLACK_COLOR.withOpacity(0.5),
                                ],
                                transform: const GradientRotation(80),
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    typeList[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.DARK_BLACK_COLOR,
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
                            initialPage: selectedTypeIndex,
                            onPageChanged: (index, reason) {
                              specificationTypeState(() {
                                if (selectedTypeIndex != -1) {
                                  addTypeController.clear();
                                }
                                selectedTypeIndex = index;
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
