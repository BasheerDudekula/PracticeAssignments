package task9to12

import java.time.LocalDate

open class Transaction10(id: Int, description: String, amount: Double, date: LocalDate) {
    private var _id: Int = id
    private var _description: String = description
    private var _amount: Double = amount
    private var _date: LocalDate = date

    // Public getters and setters
    var id: Int
        get() = _id
        private set(value) {
            if (value > 0) {
                _id = value
            } else {
                throw IllegalArgumentException("ID must be positive.")
            }
        }

    var description: String
        get() = _description
        set(value) {
            if (value.isNotBlank()) {
                _description = value
            } else {
                throw IllegalArgumentException("Description cannot be empty.")
            }
        }

    var amount: Double
        get() = _amount
        set(value) {
            if (value >= 0) {
                _amount = value
            } else {
                throw IllegalArgumentException("Amount cannot be negative.")
            }
        }

    var date: LocalDate
        get() = _date
        set(value) {
            if (!value.isAfter(LocalDate.now())) {
                _date = value
            } else {
                throw IllegalArgumentException("Date cannot be in the future.")
            }
        }

    open fun details(): String {
        return "Transaction(id=$id, description='$description', amount=$amount, date=$date)"
    }
}

// Income class inheriting from Transaction
class Incomes(id: Int, description: String, amount: Double, date: LocalDate, source: String) : Transaction10(id, description, amount, date) {

    private var _source: String = source

    var source: String
        get() = _source
        set(value) {
            if (value.isNotBlank()) {
                _source = value
            } else {
                throw IllegalArgumentException("Source cannot be empty.")
            }
        }

    override fun details(): String {
        return "Income(id=$id, description='$description', amount=$amount, date=$date, source='$source')"
    }
}

// Expense class inheriting from Transaction
class Expenses(id: Int, description: String, amount: Double, date: LocalDate, category: String) : Transaction10(id, description, amount, date) {

    private var _category: String = category

    var category: String
        get() = _category
        set(value) {
            if (value.isNotBlank()) {
                _category = value
            } else {
                throw IllegalArgumentException("Category cannot be empty.")
            }
        }

    override fun details(): String {
        return "Expense(id=$id, description='$description', amount=$amount, date=$date, category='$category')"
    }
}

fun main() {
    val income = Incomes(1, "Salary", 3000.0, LocalDate.of(2025, 1, 10), "Company A")
    println(income.details())

    val expense = Expenses(2, "Groceries", 150.0, LocalDate.of(2025, 1, 12), "Food")
    println(expense.details())

    // Attempting to modify properties
    income.amount = 3500.0 // Works fine
    println("Updated Income: ${income.details()}")

    try {
        income.amount = -500.0 // Throws an exception
    } catch (e: IllegalArgumentException) {
        println("Error: ${e.message}")
    }
}
