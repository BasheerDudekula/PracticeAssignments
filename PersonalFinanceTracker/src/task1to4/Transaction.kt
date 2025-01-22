package task1to4

import java.util.Date

class Transaction(val amount:Double, val date:Date, val category:String) {
    fun displayTransactionDetails() {
        println("Transaction Details:")
        println("Amount: \$${amount}")
        println("Date: ${date}")
        println("Category: ${category}")
    }
}
fun main(){
    val transaction = Transaction(amount = 50.75,date = Date(),category = "Transportation")
    transaction.displayTransactionDetails()
}