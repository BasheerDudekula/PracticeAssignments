package task5to8

import java.time.LocalDate

open class TransactionIncome(val id: Int, val description: String, val amount: Double, val date: LocalDate){
    open fun details(): String {
        return "TransactionIncome(id=$id, description='$description', amount=$amount, date=$date)"
    }
}

// Income class inheriting from Transaction
class Income(id: Int, description: String, amount: Double, date: LocalDate, val source: String):TransactionIncome(id, description, amount, date){
    override fun details(): String {
        return "Income(id=$id, description='$description', amount=$amount, date=$date, source='$source')"
    }
}

// Expense class inheriting from Transaction
class Expenses(id: Int, description: String, amount: Double, date: LocalDate, val category: String) : TransactionIncome(id, description, amount, date) {
    override fun details(): String {
        return "Expense(id=$id, description='$description', amount=$amount, date=$date, category='$category')"
    }
}

fun main() {
    val transactions = listOf(
        Income(1, "Salary", 3000.0, LocalDate.of(2025, 1, 10), "Company A"),
        Income(2, "Freelancing", 500.0, LocalDate.of(2025, 1, 20), "Client B"),
        Expenses(3, "Groceries", 150.0, LocalDate.of(2025, 1, 12), "Food"),
        Expenses(4, "Electricity Bill", 75.5, LocalDate.of(2025, 1, 15), "Utilities")
    )

    println("Transaction Details:")
    transactions.forEach { println(it.details()) }
}