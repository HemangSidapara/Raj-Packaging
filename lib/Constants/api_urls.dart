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
}
