package task5to8

data class Expense(val id:Int, val description:String, val amount:Double)

class User(private val username: String, private val password: String){

    private var isLoggedIn = false
    private val expenses = mutableListOf<Expense>()

    // Method to log in
    fun login(inputUsername: String, inputPassword: String): Boolean {
        return if (inputUsername == username && inputPassword == password) {
            isLoggedIn = true
            println("Login successful. Welcome, $username!")
            true
        } else {
            println("Login failed. Invalid username or password.")
            false
        }
    }

    // Add an expense (only if logged in)
    fun addExpense(expense: Expense) {
        if (isLoggedIn) {
            expenses.add(expense)
            println("Expense added: $expense")
        } else {
            println("You must be logged in to add expenses")
        }
    }

    // Display a summary of expenses
    fun displayExpensesSummary() {
        if (isLoggedIn) {
            if (expenses.isEmpty()) {
                println("No expenses recorded.")
            } else {
                val totalExpenses = expenses.sumOf { it.amount }
                println("Expenses Summary:")
                expenses.forEach { println(it) }
                println("Total Expenses: $totalExpenses")
            }
        } else {
            println("You must be logged in to view expenses")
        }
    }
}

fun main() {
    val user = User("Basheer", "Ahamed@123")

    // Attempt to log in
    if (user.login("Basheer", "Ahamed@123")) {
        // Add expenses
        user.addExpense(Expense(1, "Shopping", 500.0))
        user.addExpense(Expense(2, "Electricity Bill", 75.5))

        // Display expenses summary
        user.displayExpensesSummary()
    } else {
        println("Unable to proceed. Login required")
    }
}