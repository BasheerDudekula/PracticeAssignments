package task9to12

import java.time.LocalDate

// Base Transaction class implementing Exportable
open class Transaction( val id: Int, val description: String, val amount: Double, val date: LocalDate):Exportable {
    override fun exportToCSV(): String {
        return "$id,$description,$amount,$date"
    }

    open fun details(): String {
        return "Transaction(id=$id, description='$description', amount=$amount, date=$date)"
    }
}

// Income class inheriting from Transaction
class Income(id: Int, description: String, amount: Double, date: LocalDate, val source: String): Transaction(id, description, amount, date){
    override fun exportToCSV(): String {
        return "${super.exportToCSV()},Income,$source"
    }

    override fun details(): String {
        return "Income(id=$id, description='$description', amount=$amount, date=$date, source='$source')"
    }
}

// Expense class inheriting from Transaction
class Expense(id: Int, description: String, amount: Double, date: LocalDate, val category: String) : Transaction(id, description, amount, date) {
    override fun exportToCSV(): String {
        return "${super.exportToCSV()},Expense,$category"
    }

    override fun details(): String {
        return "Expense(id=$id, description='$description', amount=$amount, date=$date, category='$category')"
    }
}

fun main() {
    val transactions = listOf(
        Income(1, "Salary", 3000.0, LocalDate.of(2025, 1, 10), "Company A"),
        Expense(2, "Groceries", 150.0, LocalDate.of(2025, 1, 12), "Food"),
        Expense(3, "Electricity Bill", 75.5, LocalDate.of(2025, 1, 15), "Utilities"),
        Income(4, "Freelancing", 500.0, LocalDate.of(2025, 1, 20), "Client B")
    )

    println("CSV Export:")
    transactions.forEach { println(it.exportToCSV()) }
}
