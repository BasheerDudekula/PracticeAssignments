package day4

data class Transaction3(val id: String, val amount: Double)

fun List<Transaction3>.totalIncomes(): Double {
    return this.filter { it.amount > 0 }
        .sumOf { it.amount }
}

fun List<Transaction3>.totalExpenses(): Double {
    return this.filter { it.amount < 0 }
        .sumOf { it.amount }
        .let { it * -1 } // Convert the total to a positive number for readability
}

fun main() {
    val transactions = listOf(
        Transaction3("1", 100.0),  // Income
        Transaction3("2", -50.0),  // Expense
        Transaction3("3", 200.0),  // Income
        Transaction3("4", -30.0),  // Expense
        Transaction3("5", -20.0)   // Expense
    )

    val totalIncomes = transactions.totalIncomes()
    val totalExpenses = transactions.totalExpenses()

    println("Total Incomes: $totalIncomes")
    println("Total Expenses: $totalExpenses")
}
