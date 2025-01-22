package task9to12

import java.time.LocalDate
//Base class
open class Transaction11(val id: Int, val description: String, val amount: Double, val date: LocalDate) {
    override fun toString(): String {
        return "Transaction11(id=$id, description='$description', amount=$amount, date=$date)"
    }
}

// IncomeEx class inheriting from Transaction
class IncomeEx(id: Int, description: String, amount: Double, date: LocalDate, val source: String):Transaction11(id, description, amount, date){
    override fun toString(): String {
        return "IncomeEx(id=$id, description='$description', amount=$amount, date=$date, source='$source')"
    }
}

// Expense class inheriting from Transaction
class ExpenseEx(id: Int, description: String, amount: Double, date: LocalDate, val category: String) : Transaction11(id, description, amount, date) {
    override fun toString(): String {
        return "ExpenseEx(id=$id, description='$description', amount=$amount, date=$date, category='$category')"
    }
}

// Function to print any collection of transactions
fun <T : Transaction11> printTransactions(transactions: Collection<T>) {
    println("Transactions:")
    transactions.forEach { println(it) }
}

// Function to calculate the total amount in any collection of transactions
fun <T : Transaction11> calculateTotalAmount(transactions: Collection<T>): Double {
    return transactions.sumOf { it.amount }
}

// Function to filter transactions in a map by a predicate
fun <K, V : Transaction11> filterTransactionsInMap(transactionMap: Map<K, V>, predicate: (V) -> Boolean): Map<K, V> {
    return transactionMap.filterValues(predicate)
}

fun main() {
    val transactionsList = listOf(
        IncomeEx(1, "Salary", 3000.0, LocalDate.of(2025, 1, 10), "Company A"),
        ExpenseEx(2, "Groceries", 150.0, LocalDate.of(2025, 1, 12), "Food"),
        ExpenseEx(3, "Electricity Bill", 75.5, LocalDate.of(2025, 1, 15), "Utilities")
    )

    val transactionsSet = setOf(
        IncomeEx(4, "Freelancing", 500.0, LocalDate.of(2025, 1, 20), "Client B"),
        ExpenseEx(5, "Fuel", 60.0, LocalDate.of(2025, 1, 18), "Transport")
    )

    val transactionsMap = mapOf(
        1 to IncomeEx(6, "Bonus", 1000.0, LocalDate.of(2025, 1, 25), "Company A"),
        2 to ExpenseEx(7, "Rent", 1200.0, LocalDate.of(2025, 1, 1), "Housing")
    )

    // Using generic functions
    println("Handling List:")
    printTransactions(transactionsList)
    println("Total Amount (List): ${calculateTotalAmount(transactionsList)}")

    println("\nHandling Set:")
    printTransactions(transactionsSet)
    println("Total Amount (Set): ${calculateTotalAmount(transactionsSet)}")

    println("\nHandling Map:")
    val filteredMap = filterTransactionsInMap(transactionsMap) { it.amount > 500 }
    filteredMap.forEach { (key, value) ->
        println("Key: $key, Value: $value")
    }
}