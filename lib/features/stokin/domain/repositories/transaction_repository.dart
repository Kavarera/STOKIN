abstract class TransactionRepository {
  Future<void> insertTransaction(Map<String, dynamic> transaction);
  Future<void> deleteTransaction(int id);
  Future<void> updateTransaction(Map<String, dynamic> transaction);
  Future<List<Map<String, dynamic>>> getTransactions();
  Future<List<Map<String, dynamic>>> getTransactionsByDate(String date);
  Future<List<Map<String, dynamic>>> getTransactionsByCategory(int categoryId);
  Future<List<Map<String, dynamic>>> getTransactionsByProduct(int productId);
}
