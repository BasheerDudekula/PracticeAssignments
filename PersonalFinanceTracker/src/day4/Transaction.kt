package day4

data class Transaction(val id: String, val amount: Double?, val description: String?)

fun handleTransaction(transaction: Transaction?) {
    val transactionId = transaction?.id ?: "No ID"
    val transactionAmount = transaction?.amount ?: 0.0
    val transactionDescription = transaction?.description ?: "No description"

    println("Transaction Details:")
    println("ID: $transactionId")
    println("Amount: $transactionAmount")
    println("Description: $transactionDescription")

    transaction?.let {
        println("Processing transaction with ID: ${it.id}")
    } ?: run {
        println("Transaction data is not available.")
    }
}

fun main() {
    val validTransaction = Transaction("12", 300.50, "Payment for services")
    val nullTransaction: Transaction? = null

    println("Valid Transaction:")
    handleTransaction(validTransaction)

    println("\nNull Transaction:")
    handleTransaction(nullTransaction)
}