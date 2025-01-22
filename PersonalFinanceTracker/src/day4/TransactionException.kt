package day4

// Base exception for transaction errors
open class TransactionException(message: String) : Exception(message)

// Custom exception for insufficient balance
class InsufficientBalanceException(
    message: String = "Insufficient balance for the transaction"
) : TransactionException(message)

// Custom exception for invalid transaction ID
class InvalidTransactionIdException(
    message: String = "Invalid transaction ID provided"
) : TransactionException(message)

// Custom exception for transaction amount errors
class InvalidTransactionAmountException(
    message: String = "Transaction amount must be greater than zero"
) : TransactionException(message)
