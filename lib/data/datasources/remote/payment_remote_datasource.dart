import 'package:flutter/foundation.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../domain/entities/payment_result_entity.dart';

abstract class PaymentRemoteDatasource {
  Future<({double balance, double amount})> topup(double amount);
  Future<TransferResultEntity> transfer({
    required double amount,
    required String toEmail,
    required String description,
    required String otpCode,
    required String otpType,
  });
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final ApiClient _client;
  PaymentRemoteDatasourceImpl(this._client);

  @override
  Future<({double balance, double amount})> topup(double amount) async {
    final response = await _client.post(ApiEndpoints.topup, data: {'amount': amount});
    final data = response['data'] as Map<String, dynamic>;
    return (
      balance: (data['balance'] as num).toDouble(),
      amount: (data['amount'] as num).toDouble(),
    );
  }

  @override
  Future<TransferResultEntity> transfer({
    required double amount,
    required String toEmail,
    required String description,
    required String otpCode,
    required String otpType,
  }) async {
    final response = await _client.post(ApiEndpoints.transfer, data: {
      'to_email': toEmail,
      'amount': amount,
      'description': description,
      'otp_code': otpCode,
      'otp_type': otpType,
    });
    final data = response['data'] as Map<String, dynamic>? ?? response;
    debugPrint('[Datasource] transfer response data: $data');
    return TransferResultEntity(
      transactionId: (data['transaction_id'] as num?)?.toInt() ?? 0,
      amount: (data['amount'] as num?)?.toDouble() ?? 0,
      description: data['description'] as String? ?? '',
      balanceBefore: (data['balance_before'] as num?)?.toDouble() ?? 0,
      balanceAfter: (data['balance_after'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.tryParse(data['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
