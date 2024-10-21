import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raj_packaging/Constants/app_assets.dart';
import 'package:raj_packaging/Constants/app_colors.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/Network/models/orders_models/get_orders_model.dart' as get_orders;
import 'package:raj_packaging/Network/models/orders_models/get_orders_model.dart';
import 'package:raj_packaging/Screens/home_screen/dashboard_screen/create_order_screen/bloc/create_order_bloc.dart';
import 'package:raj_packaging/Widgets/button_widget.dart';
import 'package:raj_packaging/Widgets/custom_header_widget.dart';
import 'package:raj_packaging/Widgets/loading_widget.dart';
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
  final TextEditingController _actualSheetSizeBoxDiePunchDeckleController = TextEditingController();
  final TextEditingController _actualSheetSizeBoxDiePunchCuttingController = TextEditingController();
  final TextEditingController _upsDiePunchController = TextEditingController();

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
  final TextEditingController _notesController = TextEditingController();

  final List<String> orderTypeList = [
    "Roll",
    "Sheet",
    "Box",
  ];

  final List<String> boxTypeList = [
    "RSC",
    "Die Punch",
  ];

  final List<String> jointTypeList = [
    "Pin Joint",
    "Glue Joint",
  ];

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

  // final List<String> topPaperPaperAndFluteTypesForSheetAndBoxList = [
  //   "100 gsm",
  //   "150 gsm",
  //   "180 gsm",
  //   "230 gsm",
  //   "250 gsm",
  //   "Plastic",
  // ];

  ///Get Production Quantity
  void _getProductionQuantity(CreateOrderBloc createOrderBloc) {
    if (createOrderBloc.orderTypeIndex == 0) {
      _productionQuantityController.text = createOrderBloc.productionQuantityCalculatorForRoll(
        productionQuantityController: _productionQuantityController,
        orderQuantity: _orderQuantityController.text.trim(),
        orderSizeDeckle: _orderSizeRollDeckleController.text.trim(),
        productionSizeDeckle: _productionSizeRollDeckleController.text.trim(),
      );
    } else if (createOrderBloc.orderTypeIndex == 1) {
      createOrderBloc.productionQuantityCalculatorForSheet(
        productionQuantityController: _productionQuantityController,
        orderQuantity: _orderQuantityController.text.trim(),
        orderSizeDeckle: _orderSizeSheetDeckleController.text.trim(),
        productionSizeDeckle: _productionSizeSheetDeckleController.text.trim(),
        orderSizeCutting: _orderSizeSheetCuttingController.text.trim(),
        productionSizeCutting: _productionSizeSheetCuttingController.text.trim(),
      );
    } else if (createOrderBloc.orderTypeIndex == 2) {
      createOrderBloc.productionQuantityCalculatorForBox(
        productionQuantityController: _productionQuantityController,
        orderQuantity: _orderQuantityController.text.trim(),
        actualSizeDeckle: createOrderBloc.boxTypeIndex == 1 ? _actualSheetSizeBoxDiePunchDeckleController.text.trim() : _actualSheetSizeBoxRSCDeckleController.text.trim(),
        productionSizeDeckle: createOrderBloc.boxTypeIndex == 1 ? _productionSheetSizeBoxDiePunchDeckleController.text.trim() : _productionSheetSizeBoxRSCDeckleController.text.trim(),
        actualSizeCutting: createOrderBloc.boxTypeIndex == 1 ? _actualSheetSizeBoxDiePunchCuttingController.text.trim() : _actualSheetSizeBoxRSCCuttingController.text.trim(),
        productionSizeCutting: createOrderBloc.boxTypeIndex == 1 ? _productionSheetSizeBoxDiePunchCuttingController.text.trim() : _productionSheetSizeBoxRSCCuttingController.text.trim(),
        upsForDiePunch: createOrderBloc.boxTypeIndex == 1 ? _upsDiePunchController.text.trim() : null,
      );
    }
  }

  ///Get Actual Sheet Size for Box RSC
  void _getActualSheetSizeForBoxRSC(CreateOrderBloc createOrderBloc) {
    createOrderBloc.actualSheetSizeCalculatorForBoxRSC(
      actualSheetSizeBoxRSCDecalController: _actualSheetSizeBoxRSCDeckleController,
      actualSheetSizeBoxRSCCuttingController: _actualSheetSizeBoxRSCCuttingController,
      orderSizeL: _orderSizeBoxRSCLController.text.trim(),
      orderSizeB: _orderSizeBoxRSCBController.text.trim(),
      orderSizeH: _orderSizeBoxRSCHController.text.trim(),
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
                        child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            final createOrderBloc = context.read<CreateOrderBloc>();
                            return Column(
                              children: [
                                ///Party Name
                                TextFieldWidget(
                                  controller: _partyNameController,
                                  title: S.current.partyName,
                                  titleChildren: [
                                    AnimatedOpacity(
                                      opacity: createOrderBloc.selectedPartyId != null ? 1 : 0,
                                      duration: const Duration(milliseconds: 300),
                                      child: IconButton(
                                        onPressed: () async {
                                          await showBottomSheetPartyEdit(context: context);
                                        },
                                        style: IconButton.styleFrom(
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.center,
                                          maximumSize: Size(5.w, 5.w),
                                          minimumSize: Size(5.w, 5.w),
                                          surfaceTintColor: AppColors.WHITE_COLOR,
                                          elevation: 4,
                                        ),
                                        icon: FaIcon(
                                          FontAwesomeIcons.penToSquare,
                                          color: AppColors.WARNING_COLOR,
                                          size: 5.w,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    await showBottomSheetParty(createOrderBloc: createOrderBloc);
                                    createOrderBloc.partyName = _partyNameController.text.trim();
                                    createOrderBloc.phoneNumber = _phoneNumberController.text.trim();
                                  },
                                ),
                                SizedBox(height: 1.h),

                                ///Phone Number
                                TextFieldWidget(
                                  controller: _phoneNumberController,
                                  title: S.current.phoneNumber,
                                  hintText: S.current.enterPhoneNumber,
                                  validator: createOrderBloc.validatePhoneNumber,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      createOrderBloc.phoneNumber = value.trim();
                                    }
                                  },
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
                                    createOrderBloc.productName = _productNameController.text.trim();
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
                                      ///RSC
                                      BoxTypeWidget(title: S.current.rsc, index: 0),
                                      SizedBox(width: 2.w),

                                      ///Die Punch
                                      BoxTypeWidget(title: S.current.diePunch, index: 1),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                ],

                                ///Joint Type[Pin Joint, Glue Joint]
                                if (createOrderBloc.orderTypeIndex == 2) ...[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.current.jointType,
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
                                      ///Pin Joint
                                      JointTypeWidget(title: S.current.pinJoint, index: 0),
                                      SizedBox(width: 2.w),

                                      ///Glue Joint
                                      JointTypeWidget(title: S.current.glueJoint, index: 1),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                ],

                                ///Order size or Die Size or Actual Sheet Size [Deckle x Cutting or L x B x H]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 1 ? S.current.dieSize : S.current.orderSize,
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
                                        controller: createOrderBloc.orderTypeIndex == 2
                                            ? createOrderBloc.boxTypeIndex == 1
                                                ? _actualSheetSizeBoxDiePunchDeckleController
                                                : _orderSizeBoxRSCLController
                                            : createOrderBloc.orderTypeIndex == 1
                                                ? _orderSizeSheetDeckleController
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
                                            }
                                            _getProductionQuantity(createOrderBloc);
                                          }
                                        },
                                        isCrossEnable: createOrderBloc.orderTypeIndex != 0,
                                      ),
                                    ),

                                    ///Cutting or B
                                    if (createOrderBloc.orderTypeIndex != 0)
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: createOrderBloc.orderTypeIndex == 2
                                              ? createOrderBloc.boxTypeIndex == 1
                                                  ? _actualSheetSizeBoxDiePunchCuttingController
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
                                              }
                                              _getProductionQuantity(createOrderBloc);
                                            }
                                          },
                                          isCrossEnable: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0,
                                        ),
                                      ),

                                    ///Cross(x) & H
                                    if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0) ...[
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
                                            _getProductionQuantity(createOrderBloc);
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Ups
                                if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 1) ...[
                                  TextFieldWidget(
                                    controller: _upsDiePunchController,
                                    title: S.current.ups,
                                    hintText: S.current.enterUps,
                                    validator: createOrderBloc.validateUps,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        _getProductionQuantity(createOrderBloc);
                                      }
                                    },
                                    isCrossEnable: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0,
                                  ),
                                  SizedBox(height: 1.h),
                                ],

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
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Top Paper
                                    if ((createOrderBloc.orderTypeIndex == 1 && createOrderBloc.plySheetTypeIndex != 0) || (createOrderBloc.orderTypeIndex == 2 && (createOrderBloc.boxTypeIndex == 0 || createOrderBloc.plyBoxDiePunchTypeIndex != 0))) ...[
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
                                              typeList: createOrderBloc.paperFluteList.topPaper ?? [],
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
                                            typeList: createOrderBloc.orderTypeIndex != 0 ? (createOrderBloc.paperFluteList.paper ?? []) : paperAndFluteTypesForRollList,
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
                                            typeList: createOrderBloc.orderTypeIndex != 0 ? (createOrderBloc.paperFluteList.flute ?? []) : paperAndFluteTypesForRollList,
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
                                  title: "${S.current.orderQuantity} (${createOrderBloc.orderTypeIndex == 2 ? S.current.boxes : createOrderBloc.orderTypeIndex == 1 ? S.current.sheets : S.current.rolls})",
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

                                ///Actual Sheet Size [Inch]
                                if (createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0) ...[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.current.actualSheetSize,
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
                                          controller: _actualSheetSizeBoxRSCDeckleController,
                                          title: "${S.current.deckle} (${S.current.inch})",
                                          hintText: S.current.enterDeckleSize,
                                          validator: createOrderBloc.validateDeckleSize,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          isCrossEnable: true,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _getProductionQuantity(createOrderBloc);
                                            }
                                          },
                                        ),
                                      ),

                                      ///Cutting
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: _actualSheetSizeBoxRSCCuttingController,
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
                                ],

                                ///Production Size [Inch] or Production Sheet Size [Inch]
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    createOrderBloc.orderTypeIndex == 2 ? S.current.productionSheetSize : S.current.productionSize,
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
                                        controller: createOrderBloc.orderTypeIndex == 2
                                            ? createOrderBloc.boxTypeIndex == 1
                                                ? _productionSheetSizeBoxDiePunchDeckleController
                                                : _productionSheetSizeBoxRSCDeckleController
                                            : createOrderBloc.orderTypeIndex == 1
                                                ? _productionSizeSheetDeckleController
                                                : _productionSizeRollDeckleController,
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
                                        isCrossEnable: createOrderBloc.orderTypeIndex != 0,
                                      ),
                                    ),

                                    ///Cutting
                                    if (createOrderBloc.orderTypeIndex != 0)
                                      Flexible(
                                        child: TextFieldWidget(
                                          controller: createOrderBloc.orderTypeIndex == 2
                                              ? createOrderBloc.boxTypeIndex == 1
                                                  ? _productionSheetSizeBoxDiePunchCuttingController
                                                  : _productionSheetSizeBoxRSCCuttingController
                                              : _productionSizeSheetCuttingController,
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

                                ///Production Quantity [Rolls, Sheets, Boxes]
                                TextFieldWidget(
                                  controller: _productionQuantityController,
                                  title: "${createOrderBloc.orderTypeIndex == 2 ? S.current.productionSheetQuantity : S.current.productionQuantity} (${createOrderBloc.orderTypeIndex == 2 ? S.current.boxes : createOrderBloc.orderTypeIndex == 1 ? S.current.sheets : S.current.rolls})",
                                  hintText: S.current.enterQuantity,
                                  validator: createOrderBloc.validateQuantity,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 1.h),

                                ///Notes
                                TextFieldWidget(
                                  controller: _notesController,
                                  title: S.current.notes,
                                  hintText: S.current.enterNotes,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 200,
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
                  child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
                    listener: (context, state) {
                      if (state is CreateOrderSuccessState) {
                        context.pop();
                        Utils.handleMessage(message: state.successMessage);
                      }
                    },
                    builder: (context, state) {
                      final createOrderBloc = context.read<CreateOrderBloc>();
                      return ButtonWidget(
                        onPressed: () async {
                          createOrderBloc.add(
                            CreateOrderButtonClickEvent(
                              isValidate: _createOrderFormKey.currentState?.validate() == true,
                              partyId: createOrderBloc.selectedPartyId,
                              productId: createOrderBloc.selectedProductId,
                              partyName: _partyNameController.text.trim(),
                              partyPhone: _phoneNumberController.text.trim(),
                              orderType: orderTypeList[createOrderBloc.orderTypeIndex],
                              boxType: createOrderBloc.orderTypeIndex == 2 ? boxTypeList[createOrderBloc.boxTypeIndex] : null,
                              productName: _productNameController.text.trim(),
                              orderQuantity: _orderQuantityController.text.trim(),
                              productionDeckle: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _productionSheetSizeBoxDiePunchDeckleController.text.trim()
                                      : _productionSheetSizeBoxRSCDeckleController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _productionSizeSheetDeckleController.text.trim()
                                      : _productionSizeRollDeckleController.text.trim(),
                              productionCutting: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _productionSheetSizeBoxDiePunchCuttingController.text.trim()
                                      : _productionSheetSizeBoxRSCCuttingController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _productionSizeSheetCuttingController.text.trim()
                                      : null,
                              productionQuantity: _productionQuantityController.text.trim(),
                              deckle: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _actualSheetSizeBoxDiePunchDeckleController.text.trim()
                                      : _actualSheetSizeBoxRSCDeckleController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _orderSizeSheetDeckleController.text.trim()
                                      : _orderSizeRollDeckleController.text.trim(),
                              cutting: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _actualSheetSizeBoxDiePunchCuttingController.text.trim()
                                      : _actualSheetSizeBoxRSCCuttingController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _orderSizeSheetCuttingController.text.trim()
                                      : null,
                              ply: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _specificationBoxDiePunchPlyController.text.trim()
                                      : _specificationBoxRSCPlyController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _specificationSheetPlyController.text.trim()
                                      : null,
                              topPaper: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1 && createOrderBloc.plyBoxDiePunchTypeIndex != 0
                                      ? _specificationBoxDiePunchTopPaperController.text.trim()
                                      : _specificationBoxRSCTopPaperController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1 && createOrderBloc.plySheetTypeIndex != 0
                                      ? _specificationSheetTopPaperController.text.trim()
                                      : null,
                              paper: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _specificationBoxDiePunchPaperController.text.trim()
                                      : _specificationBoxRSCPaperController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _specificationSheetPaperController.text.trim()
                                      : _specificationRollPaperController.text.trim(),
                              flute: createOrderBloc.orderTypeIndex == 2
                                  ? createOrderBloc.boxTypeIndex == 1
                                      ? _specificationBoxDiePunchFluteController.text.trim()
                                      : _specificationBoxRSCFluteController.text.trim()
                                  : createOrderBloc.orderTypeIndex == 1
                                      ? _specificationSheetFluteController.text.trim()
                                      : _specificationRollFluteController.text.trim(),
                              l: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? _orderSizeBoxRSCLController.text.trim() : null,
                              b: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? _orderSizeBoxRSCBController.text.trim() : null,
                              h: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 0 ? _orderSizeBoxRSCHController.text.trim() : null,
                              ups: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.boxTypeIndex == 1 ? _upsDiePunchController.text.trim() : null,
                              jointType: createOrderBloc.orderTypeIndex == 2 && createOrderBloc.jointTypeIndex != -1 ? jointTypeList[createOrderBloc.jointTypeIndex] : null,
                              notes: _notesController.text.trim(),
                            ),
                          );
                        },
                        isLoading: (state is CreateOrderLoadingState) ? state.isLoading : false,
                        buttonTitle: S.current.createOrder,
                      );
                    },
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
  Future<void> showBottomSheetParty({required CreateOrderBloc createOrderBloc}) async {
    GlobalKey<FormState> addPartyFormKey = GlobalKey<FormState>();
    TextEditingController addPartyController = TextEditingController();

    String? selectedPartyId = createOrderBloc.selectedPartyId;

    if (selectedPartyId == null) {
      addPartyController.text = createOrderBloc.partyName;
    }

    List<get_orders.Data> getSearchParty(String value) {
      List<get_orders.Data> partyList = [];
      if (value.isNotEmpty) {
        partyList.addAll(createOrderBloc.defaultPartyList.where((element) => element.partyName?.toLowerCase().contains(value.toLowerCase()) == true).toList());
      } else {
        partyList.addAll(createOrderBloc.defaultPartyList);
      }
      return partyList;
    }

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
        return BlocProvider.value(
          value: createOrderBloc,
          child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
            builder: (context, state) {
              final createOrderBloc = context.read<CreateOrderBloc>();
              return GestureDetector(
                onTap: Utils.unfocus,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h).copyWith(bottom: keyboardPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///Back, Title & Select
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
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
                                S.current.selectParty,
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final party = createOrderBloc.partyList.firstWhereOrNull((e) => e.partyId == selectedPartyId);
                                  _partyNameController.text = party?.partyName ?? "";
                                  _phoneNumberController.text = party?.partyPhone ?? "";
                                  createOrderBloc.add(CreateOrderSelectedPartyEvent(partyId: selectedPartyId));
                                  context.pop();
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Divider(
                            color: AppColors.HINT_GREY_COLOR,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(height: 1.h),

                        ///Search Party
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: TextFieldWidget(
                            hintText: S.current.searchParty,
                            primaryColor: AppColors.MAIN_BORDER_COLOR.withOpacity(0.2),
                            secondaryColor: AppColors.SECONDARY_COLOR,
                            onChanged: (value) {
                              createOrderBloc.add(SearchPartyEvent(partyList: getSearchParty(value)));
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),

                        ///Add party
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Form(
                            key: addPartyFormKey,
                            child: TextFieldWidget(
                              controller: addPartyController,
                              title: S.current.add,
                              hintText: S.current.enterPartyName,
                              validator: createOrderBloc.validatePartyName,
                              primaryColor: AppColors.SECONDARY_COLOR,
                              secondaryColor: AppColors.PRIMARY_COLOR,
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (addPartyFormKey.currentState?.validate() == true) {
                                    _partyNameController.text = addPartyController.text;
                                    _phoneNumberController.clear();
                                    createOrderBloc.add(const CreateOrderSelectedPartyEvent(partyId: null));
                                    context.pop();
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
                        ),
                        SizedBox(height: 2.h),

                        ///Parties
                        if (createOrderBloc.state is CreateOrderGetPartiesLoadingState && (createOrderBloc.state as CreateOrderGetPartiesLoadingState).isLoading)
                          SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: LoadingWidget(),
                            ),
                          )
                        else if (createOrderBloc.partyList.isEmpty)
                          SizedBox(
                            height: 20.h,
                            child: Center(
                              child: Text(
                                S.current.noDataFound,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        else
                          Flexible(
                            child: StatefulBuilder(builder: (context, partyState) {
                              return AnimationLimiter(
                                child: ListView.separated(
                                  itemCount: createOrderBloc.partyList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                                  itemBuilder: (context, index) {
                                    final party = createOrderBloc.partyList[index];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 400),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              partyState(() {
                                                selectedPartyId = party.partyId;
                                              });
                                            },
                                            borderRadius: BorderRadius.circular(10),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: AppColors.WHITE_COLOR,
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.GREY_COLOR.withOpacity(0.2),
                                                    blurRadius: 25,
                                                    offset: const Offset(-10, 5),
                                                    spreadRadius: 3,
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h).copyWith(left: 4.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        party.partyName ?? "",
                                                        style: TextStyle(
                                                          color: AppColors.BLACK_COLOR,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    AnimatedContainer(
                                                      duration: const Duration(milliseconds: 300),
                                                      decoration: BoxDecoration(
                                                        color: selectedPartyId == party.partyId ? AppColors.DARK_GREEN_COLOR : AppColors.WHITE_COLOR,
                                                        border: Border.all(
                                                          color: selectedPartyId == party.partyId ? AppColors.DARK_GREEN_COLOR : AppColors.GREY_COLOR,
                                                          width: 1,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding: EdgeInsets.all(1.w),
                                                      child: AnimatedOpacity(
                                                        opacity: selectedPartyId == party.partyId ? 1 : 0,
                                                        duration: const Duration(milliseconds: 300),
                                                        child: Icon(
                                                          Icons.check_rounded,
                                                          color: AppColors.WHITE_COLOR,
                                                          size: 3.w,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 1.5.h);
                                  },
                                ),
                              );
                            }),
                          ),

                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ).then((value) {
      createOrderBloc.partyList.clear();
      createOrderBloc.partyList.addAll(createOrderBloc.defaultPartyList);
    });
  }

  ///Party Edit Bottom Sheet
  Future<void> showBottomSheetPartyEdit({required BuildContext context}) async {
    final createOrderBloc = context.read<CreateOrderBloc>();

    GlobalKey<FormState> editPartyFormKey = GlobalKey<FormState>();
    TextEditingController editPartyController = TextEditingController(text: createOrderBloc.partyName);
    TextEditingController editPhoneNumberController = TextEditingController(text: createOrderBloc.phoneNumber);

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
              padding: EdgeInsets.only(top: 1.h, bottom: keyboardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back, Title & Save
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
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
                          S.current.editParty,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        BlocProvider.value(
                          value: createOrderBloc,
                          child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
                            listener: (context, state) {
                              if (state is CreateOrderEditPartySuccessState) {
                                context.pop();
                                Utils.handleMessage(message: state.successMessage);
                                createOrderBloc.add(CreateOrderGetPartiesEvent());
                              }
                              if (state is CreateOrderGetPartiesSuccessState) {
                                _partyNameController.text = editPartyController.text.trim();
                                createOrderBloc.partyName = _partyNameController.text;
                                _phoneNumberController.text = editPhoneNumberController.text.trim();
                                createOrderBloc.phoneNumber = _phoneNumberController.text;
                              }
                              if (state is CreateOrderEditPartyFailedState) {
                                Utils.handleMessage(message: state.failedMessage, isError: true);
                              }
                            },
                            builder: (context, state) {
                              final editPartyBloc = context.read<CreateOrderBloc>();
                              return TextButton(
                                onPressed: () async {
                                  if (createOrderBloc.selectedPartyId != null) {
                                    editPartyBloc.add(
                                      CreateOrderEditPartyClickEvent(
                                        isValidate: editPartyFormKey.currentState?.validate() == true,
                                        partyId: createOrderBloc.selectedPartyId!,
                                        partyName: editPartyController.text.trim(),
                                        partyPhone: editPhoneNumberController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: IconButton.styleFrom(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: state is CreateOrderEditPartyLoadingState && state.isLoading
                                    ? LoadingWidget(
                                        width: 8.w,
                                        height: 8.w,
                                      )
                                    : Text(
                                        S.current.save,
                                        style: TextStyle(
                                          color: AppColors.DARK_GREEN_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Divider(
                      color: AppColors.HINT_GREY_COLOR,
                      thickness: 1,
                    ),
                  ),

                  ///Edit party
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: editPartyFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Party Name
                          TextFieldWidget(
                            controller: editPartyController,
                            title: S.current.editPartyName,
                            hintText: S.current.enterPartyName,
                            validator: createOrderBloc.validatePartyName,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            maxLength: 30,
                            textInputAction: TextInputAction.next,
                          ),

                          ///Phone number
                          TextFieldWidget(
                            controller: editPhoneNumberController,
                            title: S.current.editPhoneNumber,
                            hintText: S.current.enterPhoneNumber,
                            validator: createOrderBloc.validatePhoneNumber,
                            primaryColor: AppColors.SECONDARY_COLOR,
                            secondaryColor: AppColors.PRIMARY_COLOR,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
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

    String? selectedProductId = createOrderBloc.selectedProductId;

    if (selectedProductId == null) {
      addProductController.text = createOrderBloc.productName;
    }

    List<get_orders.ProductData> getSearchProduct(String value) {
      List<get_orders.ProductData> productList = [];
      if (value.isNotEmpty) {
        productList.addAll(createOrderBloc.defaultProductList.where((element) => element.productName?.toLowerCase().contains(value.toLowerCase()) == true).toList());
      } else {
        productList.addAll(createOrderBloc.defaultProductList);
      }
      return productList;
    }

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
        return BlocProvider.value(
          value: createOrderBloc,
          child: GestureDetector(
            onTap: Utils.unfocus,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h).copyWith(bottom: keyboardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Back, Title & Select
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
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
                            S.current.selectProduct,
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final product = createOrderBloc.productList.firstWhereOrNull((e) => e.productId == selectedProductId);
                              _productNameController.text = product?.productName ?? "";
                              createOrderBloc.add(CreateOrderSelectedProductEvent(productId: selectedProductId));
                              createOrderBloc.add(CreateOrderTypeEvent(orderTypeIndex: product?.orderType != null ? orderTypeList.indexOf(product!.orderType!) : 0));

                              if (product?.orderType != null) {
                                if (product?.orderType == "Box") {
                                  boxVariableSetup(createOrderBloc: createOrderBloc, product: product);
                                } else if (product?.orderType == "Sheet") {
                                  sheetVariableSetup(createOrderBloc: createOrderBloc, product: product);
                                } else if (product?.orderType == "Roll") {
                                  rollVariableSetup(createOrderBloc: createOrderBloc, product: product);
                                }
                              }

                              context.pop();
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
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Divider(
                        color: AppColors.HINT_GREY_COLOR,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    ///Search Product
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TextFieldWidget(
                        hintText: S.current.searchProduct,
                        primaryColor: AppColors.MAIN_BORDER_COLOR.withOpacity(0.2),
                        secondaryColor: AppColors.SECONDARY_COLOR,
                        onChanged: (value) {
                          createOrderBloc.add(SearchProductEvent(productList: getSearchProduct(value)));
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),

                    ///Add product
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Form(
                        key: addProductFormKey,
                        child: TextFieldWidget(
                          controller: addProductController,
                          title: S.current.add,
                          hintText: S.current.enterProductName,
                          validator: createOrderBloc.validateProductName,
                          primaryColor: AppColors.SECONDARY_COLOR,
                          secondaryColor: AppColors.PRIMARY_COLOR,
                          suffixIcon: InkWell(
                            onTap: () {
                              if (addProductFormKey.currentState?.validate() == true) {
                                _productNameController.text = addProductController.text;
                                createOrderBloc.add(const CreateOrderSelectedProductEvent(productId: null));
                                context.pop();
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
                    ),
                    SizedBox(height: 2.h),

                    ///Products
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      bloc: createOrderBloc,
                      builder: (context, state) {
                        final createOrderBloc = context.read<CreateOrderBloc>();
                        if (createOrderBloc.state is CreateOrderGetPartiesLoadingState && (createOrderBloc.state as CreateOrderGetPartiesLoadingState).isLoading) {
                          return SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: LoadingWidget(),
                            ),
                          );
                        } else if (createOrderBloc.productList.isEmpty) {
                          return SizedBox(
                            height: 20.h,
                            child: Center(
                              child: Text(
                                S.current.noDataFound,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Flexible(
                            child: StatefulBuilder(builder: (context, productState) {
                              return AnimationLimiter(
                                child: ListView.separated(
                                  itemCount: createOrderBloc.productList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h).copyWith(bottom: 3.h),
                                  itemBuilder: (context, index) {
                                    final product = createOrderBloc.productList[index];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 400),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              productState(() {
                                                selectedProductId = product.productId;
                                              });
                                            },
                                            borderRadius: BorderRadius.circular(10),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: AppColors.WHITE_COLOR,
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.GREY_COLOR.withOpacity(0.2),
                                                    blurRadius: 25,
                                                    offset: const Offset(-10, 5),
                                                    spreadRadius: 3,
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h).copyWith(left: 4.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: 2.w),
                                                        child: Text(
                                                          product.productName ?? "",
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        ///Edit Product
                                                        InkWell(
                                                          onTap: () async {
                                                            context.pop();
                                                            await showBottomSheetProductEdit(context: context, productId: product.productId ?? "");
                                                          },
                                                          child: FaIcon(
                                                            FontAwesomeIcons.penToSquare,
                                                            color: AppColors.WARNING_COLOR,
                                                            size: 5.w,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        AnimatedContainer(
                                                          duration: const Duration(milliseconds: 300),
                                                          decoration: BoxDecoration(
                                                            color: selectedProductId == product.productId ? AppColors.DARK_GREEN_COLOR : AppColors.WHITE_COLOR,
                                                            border: Border.all(
                                                              color: selectedProductId == product.productId ? AppColors.DARK_GREEN_COLOR : AppColors.GREY_COLOR,
                                                              width: 1,
                                                            ),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          padding: EdgeInsets.all(1.w),
                                                          child: AnimatedOpacity(
                                                            opacity: selectedProductId == product.productId ? 1 : 0,
                                                            duration: const Duration(milliseconds: 300),
                                                            child: Icon(
                                                              Icons.check_rounded,
                                                              color: AppColors.WHITE_COLOR,
                                                              size: 3.w,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 1.5.h);
                                  },
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      createOrderBloc.productList.clear();
      createOrderBloc.productList.addAll(createOrderBloc.defaultProductList);
    });
  }

  ///Product Edit Bottom Sheet
  Future<void> showBottomSheetProductEdit({required BuildContext context, required String productId}) async {
    final createOrderBloc = context.read<CreateOrderBloc>();

    GlobalKey<FormState> editProductFormKey = GlobalKey<FormState>();
    TextEditingController editProductController = TextEditingController(text: createOrderBloc.productList.firstWhereOrNull((element) => element.productId == productId)?.productName ?? "");

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
              padding: EdgeInsets.only(top: 1.h, bottom: keyboardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back, Title & Save
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
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
                          S.current.editProduct,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        BlocProvider.value(
                          value: createOrderBloc,
                          child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
                            listener: (context, state) {
                              if (state is CreateOrderEditProductSuccessState) {
                                context.pop();
                                Utils.handleMessage(message: state.successMessage);
                                createOrderBloc.add(CreateOrderGetPartiesEvent());
                              }
                              if (state is CreateOrderGetPartiesSuccessState) {
                                createOrderBloc.defaultProductList.clear();
                                createOrderBloc.productList.clear();
                                createOrderBloc.defaultProductList.addAll(createOrderBloc.partyList.firstWhereOrNull((element) => element.partyId == createOrderBloc.selectedPartyId)?.productData ?? []);
                                createOrderBloc.productList.addAll(createOrderBloc.partyList.firstWhereOrNull((element) => element.partyId == createOrderBloc.selectedPartyId)?.productData ?? []);
                              }
                              if (state is CreateOrderEditProductFailedState) {
                                Utils.handleMessage(message: state.failedMessage, isError: true);
                              }
                            },
                            builder: (context, state) {
                              final editPartyBloc = context.read<CreateOrderBloc>();
                              return TextButton(
                                onPressed: () async {
                                  if (createOrderBloc.selectedPartyId != null) {
                                    editPartyBloc.add(
                                      CreateOrderEditProductClickEvent(
                                        isValidate: editProductFormKey.currentState?.validate() == true,
                                        productId: productId,
                                        productName: editProductController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: IconButton.styleFrom(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: state is CreateOrderEditProductLoadingState && state.isLoading
                                    ? LoadingWidget(
                                        width: 8.w,
                                        height: 8.w,
                                      )
                                    : Text(
                                        S.current.save,
                                        style: TextStyle(
                                          color: AppColors.DARK_GREEN_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Divider(
                      color: AppColors.HINT_GREY_COLOR,
                      thickness: 1,
                    ),
                  ),

                  ///Edit product
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: editProductFormKey,
                      child: TextFieldWidget(
                        controller: editProductController,
                        title: S.current.editProductName,
                        hintText: S.current.enterProductName,
                        validator: createOrderBloc.validateProductName,
                        primaryColor: AppColors.SECONDARY_COLOR,
                        secondaryColor: AppColors.PRIMARY_COLOR,
                        maxLength: 30,
                        textInputAction: TextInputAction.next,
                      ),
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

  ///Roll Setup
  void rollVariableSetup({
    required CreateOrderBloc createOrderBloc,
    ProductData? product,
  }) {
    _orderSizeRollDeckleController.text = product?.deckle ?? "";
    _specificationRollPaperController.text = product?.paper ?? "";
    _specificationRollFluteController.text = product?.flute ?? "";
    _productionSizeRollDeckleController.text = product?.productionDeckle ?? "";
  }

  ///Sheet Setup
  void sheetVariableSetup({
    required CreateOrderBloc createOrderBloc,
    ProductData? product,
  }) {
    _orderSizeSheetDeckleController.text = product?.deckle ?? "";
    _orderSizeSheetCuttingController.text = product?.cutting ?? "";
    createOrderBloc.add(CreateOrderPlySheetTypeEvent(plySheetTypeIndex: product?.ply != null ? plyTypesForSheetAndBoxDiePunchList.indexOf(product!.ply!) : 0));
    _specificationSheetPlyController.text = product?.ply ?? "";
    if (product?.ply != null && product?.ply?.isNotEmpty == true && product?.ply != "2") {
      _specificationSheetTopPaperController.text = product?.topPaper ?? "";
    }
    _specificationSheetPaperController.text = product?.paper ?? "";
    _specificationSheetFluteController.text = product?.flute ?? "";
    _productionSizeSheetDeckleController.text = product?.productionDeckle ?? "";
    _productionSizeSheetCuttingController.text = product?.productionCutting ?? "";
  }

  ///Box Setup
  void boxVariableSetup({
    required CreateOrderBloc createOrderBloc,
    ProductData? product,
  }) {
    createOrderBloc.add(CreateOrderBoxTypeEvent(boxTypeIndex: product?.boxType != null ? boxTypeList.indexOf(product!.boxType!) : 0));
    if (product?.boxType != null) {
      if (product?.boxType == "Die Punch") {
        _actualSheetSizeBoxDiePunchDeckleController.text = product?.deckle ?? "";
        _actualSheetSizeBoxDiePunchCuttingController.text = product?.cutting ?? "";
        createOrderBloc.add(CreateOrderPlyBoxDiePunchTypeEvent(plyBoxDiePunchTypeIndex: product?.ply != null ? plyTypesForSheetAndBoxDiePunchList.indexOf(product!.ply!) : 0));
        _specificationBoxDiePunchPlyController.text = product?.ply ?? "";
        if (product?.ply != null && product?.ply?.isNotEmpty == true && product?.ply != "2") {
          _specificationBoxDiePunchTopPaperController.text = product?.topPaper ?? "";
        }
        _specificationBoxDiePunchPaperController.text = product?.paper ?? "";
        _specificationBoxDiePunchFluteController.text = product?.flute ?? "";
        _productionSheetSizeBoxDiePunchDeckleController.text = product?.productionDeckle ?? "";
        _productionSheetSizeBoxDiePunchCuttingController.text = product?.productionCutting ?? "";
      } else {
        _orderSizeBoxRSCLController.text = product?.l ?? "";
        _orderSizeBoxRSCBController.text = product?.b ?? "";
        _orderSizeBoxRSCHController.text = product?.h ?? "";
        createOrderBloc.add(CreateOrderPlyBoxRSCTypeEvent(plyBoxRSCTypeIndex: product?.ply != null ? plyTypesForBoxRSCList.indexOf(product!.ply!) : 0));
        _specificationBoxRSCPlyController.text = product?.ply ?? "";
        _specificationBoxRSCTopPaperController.text = product?.topPaper ?? "";
        _specificationBoxRSCPaperController.text = product?.paper ?? "";
        _specificationBoxRSCFluteController.text = product?.flute ?? "";
        _actualSheetSizeBoxRSCDeckleController.text = product?.deckle ?? "";
        _actualSheetSizeBoxRSCCuttingController.text = product?.cutting ?? "";
        _productionSheetSizeBoxRSCDeckleController.text = product?.productionDeckle ?? "";
        _productionSheetSizeBoxRSCCuttingController.text = product?.productionCutting ?? "";
      }
    }
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
            _partyNameController.text = createOrderBloc.partyName;
            _phoneNumberController.text = createOrderBloc.phoneNumber;
            _productNameController.text = createOrderBloc.productName;
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
            _createOrderFormKey.currentState?.reset();
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

  ///Box Type
  Widget JointTypeWidget({
    required String title,
    required int index,
  }) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      buildWhen: (previous, current) => current is CreateOrderTypeState,
      builder: (context, state) {
        final createOrderBloc = context.read<CreateOrderBloc>();
        return InkWell(
          onTap: () {
            createOrderBloc.add(CreateOrderJointTypeEvent(jointTypeIndex: index));
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 15.w, minHeight: 2.5.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(0.5.w),
                  decoration: BoxDecoration(
                    color: createOrderBloc.jointTypeIndex == index ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: createOrderBloc.jointTypeIndex == index ? 1 : 0,
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
                        child: TextFieldWidget(
                          controller: addTypeController,
                          title: S.current.add,
                          hintText: S.current.enterType,
                          primaryColor: AppColors.SECONDARY_COLOR,
                          secondaryColor: AppColors.PRIMARY_COLOR,
                          suffixIcon: InkWell(
                            onTap: () {
                              if (addTypeController.text.isNotEmpty) {
                                context.pop();
                                onPressed?.call(-1, addTypeController.text);
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
