package day4

data class Transaction2(
    val id: String,
    val amount: Double
)

fun processTransaction(transaction: Transaction2?, balance: Double) {
    // Check for null transaction
    if (transaction == null) {
        throw InvalidTransactionIdException("Transaction object is null")
    }

    // Validate transaction ID
    if (transaction.id.isBlank()) {
        throw InvalidTransactionIdException("Transaction ID cannot be blank")
    }

    // Validate transaction amount
    if (transaction.amount <= 0) {
        throw InvalidTransactionAmountException("Amount must be greater than zero")
    }

    // Check for sufficient balance
    if (balance < transaction.amount) {
        throw InsufficientBalanceException("Available balance: $balance, required: ${transaction.amount}")
    }

    // Process the transaction
    println("Transaction processed successfully: $transaction")
}

fun main() {
    try {
        val balance = 50.0
        val transaction = Transaction2("12345", 100.0)

        processTransaction(transaction, balance)
    } catch (e: TransactionException) {
        println("Error: ${e.message}")
    }

    try {
        val invalidTransaction = Transaction2("", -10.0)
        processTransaction(invalidTransaction, 200.0)
    } catch (e: TransactionException) {
        println("Error: ${e.message}")
    }
}
