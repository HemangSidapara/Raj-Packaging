class ApiUrls {
  static const String baseUrl = 'https://mindwaveinfoway.com/';
  static const String _apiPath = 'RajPackaging/AdminPanel/WebApi/';

  static const String loginApi = '${_apiPath}Login.php';
  static const String createOrderApi = '${_apiPath}createOrder.php';
  static const String inAppUpdateApi = '${_apiPath}InAppUpdate.php';
  static const String getOrdersApi = '${_apiPath}getOrders.php';
  static const String editPartyApi = '${_apiPath}editParty.php';
  static const String deleteOrderApi = '${_apiPath}deleteOrder.php?orderId=';
  static const String createJobApi = '${_apiPath}createJob.php';
  static const String getJobApi = '${_apiPath}getJobs.php';
  static const String completeJobApi = '${_apiPath}completeJob.php?jobId=';
  static const String getJobDataApi = '${_apiPath}getJobData.php';
  static const String getPartiesApi = '${_apiPath}getParties.php';
  static const String archiveOrdersApi = '${_apiPath}archiveOrders.php?orderId=';
  static const String getCompletedOrdersApi = '${_apiPath}getCompletedOrders.php';
  static const String editOrderQuantityApi = '${_apiPath}editOrderQuantity.php';
  static const String editProductApi = '${_apiPath}editProduct.php';
  static const String getPaperFluteApi = '${_apiPath}getPaperFlute.php';
  static const String checkTokenApi = '${_apiPath}checkToken.php';
  static const String getArchivedOrdersApi = '${_apiPath}getArchivedOrders.php';
}
