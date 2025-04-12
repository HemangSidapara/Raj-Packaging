import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/production_report_models/get_production_report_model.dart' as get_report;
import 'package:raj_packaging/Network/services/production_services/production_services.dart';

part 'production_report_event.dart';
part 'production_report_state.dart';

class ProductionReportBloc extends Bloc<ProductionReportEvent, ProductionReportState> {
  List<get_report.Data> productionList = [];

  ProductionReportBloc() : super(ProductionReportInitial()) {
    on<ProductionReportStartedEvent>((event, emit) {
      add(const ProductionReportGetProductionEvent());
    });

    on<ProductionReportGetProductionEvent>((event, emit) async {
      await getProductionDataApiCall(event, emit);
    });

    on<ProductionReportGetProductionLoadingEvent>((event, emit) async {
      emit(ProductionReportGetProductionLoadingState(isLoading: event.isLoading));
    });

    on<ProductionReportGetProductionSuccessEvent>((event, emit) async {
      emit(ProductionReportGetProductionSuccessState(productionList: event.productionList, successMessage: event.successMessage));
    });

    on<ProductionReportGetProductionFailedEvent>((event, emit) async {
      emit(ProductionReportGetProductionFailedState());
    });
  }

  Future<void> getProductionDataApiCall(ProductionReportGetProductionEvent event, Emitter<ProductionReportState> emit) async {
    try {
      add(ProductionReportGetProductionLoadingEvent(isLoading: event.isLoading));
      final response = await ProductionServices.getProductionService();

      if (response.isSuccess) {
        get_report.GetProductionReportModel reportModel = get_report.GetProductionReportModel.fromJson(response.response?.data);
        productionList.clear();
        productionList.addAll(reportModel.data ?? []);
        setData(AppConstance.localProductionReportStored, reportModel.toJson());
        add(ProductionReportGetProductionSuccessEvent(productionList: productionList, successMessage: response.message));
      } else {
        get_report.GetProductionReportModel reportModel = get_report.GetProductionReportModel.fromJson(getData(AppConstance.localProductionReportStored));
        productionList.clear();
        productionList.addAll(reportModel.data ?? []);
        add(ProductionReportGetProductionFailedEvent(productionList: productionList));
      }
    } finally {
      add(const ProductionReportGetProductionLoadingEvent(isLoading: false));
    }
  }
}
