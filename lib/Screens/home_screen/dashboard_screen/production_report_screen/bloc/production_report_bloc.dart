import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Network/services/production_services/production_services.dart';

part 'production_report_event.dart';
part 'production_report_state.dart';

class ProductionReportBloc extends Bloc<ProductionReportEvent, ProductionReportState> {
  List productionList = [];

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
        productionList.clear();
        productionList = (response.response?.data['Tabs'] as List<dynamic>).firstOrNull ?? {};
        add(ProductionReportGetProductionSuccessEvent(productionList: productionList, successMessage: response.message));
      }
    } finally {
      add(const ProductionReportGetProductionLoadingEvent(isLoading: false));
    }
  }
}
