package task1to4

import java.util.*

class Transactions(val amount:Double, val date: Date,val category:String ) {

    fun categorizeTransaction(){
        when(category){
            "Food" -> println("This is a Food transaction.")
            "Entertainment" -> println("This is an Entertainment transaction.")
            "Transportation" -> println("This is a Transportation transaction.")
            "Health" -> println("This is a Health transaction.")
            else -> println("This transaction doesn't fall into a known category.")
        }
    }
    fun displayTransactionDetails() {
        println("Transaction Details:")
        println("Amount: \$${amount}")
        println("Date: ${date}")
        println("Category: ${category}")
        categorizeTransaction()
    }
}
fun main(){
    val transaction1 = Transaction(amount = 100.50,date = Date(),category = "Food")
    transaction1.displayTransactionDetails()
    val transaction2 = Transaction(amount = 200.50,date = Date(),category = "Entertainment")
    transaction2.displayTransactionDetails()
    val transaction3 = Transaction(amount = 300.50,date = Date(),category = "Movie")
    transaction3.displayTransactionDetails()
}