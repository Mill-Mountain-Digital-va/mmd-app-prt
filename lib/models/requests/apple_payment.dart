class ApplePaymentRequest {
  String? purchaseId;
  String? productId;
  String? purchaseStatus;
  String? serverData;
  String? source;
  String? transactionDate;

  ApplePaymentRequest();

  Map toRequest() {
    var map = new Map<String, dynamic>();
    map["in_app_purchase_id"] = purchaseId;
    map["in_app_product_id"] = productId;
    map["in_app_purchase_status"] = purchaseStatus;
    map["in_app_server_data"] = serverData;
    map["in_app_source"] = source;
    map["in_app_transaction_date"] = transactionDate;
    
    return map;
  }
}
