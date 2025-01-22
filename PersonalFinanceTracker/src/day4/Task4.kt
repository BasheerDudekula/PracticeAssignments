package day4
import kotlinx.coroutines.*

data class Transaction4(val id: String, val type: String, val amount: Double)

suspend fun exportTransactions(processedTransactions: List<Transaction4>) {
    delay(2000) // Simulate a delay for data export
    println("Exported processed transactions: ${processedTransactions.map { it.id }}")
}

// Function to process transactions
suspend fun processTransactions(
    transactions: List<Transaction4>,
    filterType: String,
    threshold: Double
): List<Transaction4> {
    delay(1000) // Simulate processing delay
    return transactions.filter { it.type != filterType && it.amount > threshold }
}

fun main() = runBlocking {
    println("Starting transaction processing...")

    // Create the transaction list in the main function
    val transactions = listOf(
        Transaction4("1", "debit", 150.0),
        Transaction4("2", "credit", 200.0),
        Transaction4("3", "debit", 100.0),
        Transaction4("4", "credit", 300.0),
        Transaction4("5", "credit", 120.0)
    )

    // Launch coroutine to handle processing and exporting
    val job = launch {
        val processedTransactions = async { processTransactions(transactions, filterType = "debit", threshold = 100.0) }

        val exportJob = async { exportTransactions(processedTransactions.await()) }
        exportJob.await()
    }

    job.join() // Wait for all tasks to complete
    println("Transaction processing completed.")
}
