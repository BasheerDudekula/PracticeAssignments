package task5to8

import java.time.LocalDate

data class Transactions(val id: Int, val description: String, val amount: Double, val date: LocalDate)

class TransactionsList {
    private val transactions = mutableListOf<Transactions>()

    // Add a transaction
    fun addTransaction(transaction: Transactions) {
        transactions.add(transaction)
        println("Transaction added: $transaction")
    }

    // Filter transactions by a predicate
    fun filterTransactions(predicate: (Transactions) -> Boolean): List<Transactions> {
        return transactions.filter(predicate)
    }

    // Sort transactions by a comparator
    fun sortTransactions(comparator: Comparator<Transactions>): List<Transactions> {
        return transactions.sortedWith(comparator)
    }
}

fun main() {
    val transactionList = TransactionsList()

    transactionList.addTransaction(Transactions(1, "Entertainment", 200.0, LocalDate.of(2025, 1, 5)))
    transactionList.addTransaction(Transactions(2, "Shopping", 100.0, LocalDate.of(2025, 1, 3)))
    transactionList.addTransaction(Transactions(3, "Fuel", 50.0, LocalDate.of(2025, 1, 1)))

    // Filter transactions by amount greater than 100
    val highValueTransactions = transactionList.filterTransactions { it.amount > 100 }
    println("Filtered Transactions (Amount > 100): $highValueTransactions")

    // Sort transactions by date
    val sortedByDate = transactionList.sortTransactions(compareBy { it.date })
    println("Transactions Sorted by Date: $sortedByDate")

    // Sort transactions by amount in descending order
    val sortedByAmountDescending = transactionList.sortTransactions(compareByDescending { it.amount })
    println("Transactions Sorted by Amount (Descending): $sortedByAmountDescending")
}

