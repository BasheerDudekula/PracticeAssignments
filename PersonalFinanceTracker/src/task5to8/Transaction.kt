package task5to8

data class Transaction(val id:Int, var description:String, var amount:Double)

class TransactionList{
    val transactions = mutableListOf<Transaction>()

    // Add a transaction
    fun addTransaction(transaction: Transaction){
        transactions.add(transaction)
        println("Transaction Added : $transaction")
    }

    // Delete a transaction by its ID
    fun deleteTransaction(transactionId:Int):Boolean{
        val transaction = transactions.find { it.id == transactionId }
        return if(transaction != null){
            transactions.remove(transaction)
            println("Transaction Deleted: $transaction")
            true
        }else{
            println("Transaction with Id $transactionId not found")
            false
        }
    }

    // Edit a transaction by its ID
    fun editTransaction(transactionId: Int, newDescription: String, newAmount: Double): Boolean {
        val transaction = transactions.find { it.id == transactionId }
        return if (transaction != null) {
            transaction.description = newDescription
            transaction.amount = newAmount
            println("Transaction updated: $transaction")
            true
        } else {
            println("Transaction with ID $transactionId not found")
            false
        }
    }

    // List all transactions
    fun listTransactions() {
        if (transactions.isEmpty()) {
            println("No transactions available")
        } else {
            println("Transactions:")
            transactions.forEach { println(it) }
        }
    }
}

fun main(){
    val transactionList = TransactionList()
    // Add transactions
    transactionList.addTransaction(Transaction(1, "Entertainment", 200.0))
    transactionList.addTransaction(Transaction(2, "Fuel", 40.0))

    // List transactions
    transactionList.listTransactions()

    // Edit a transaction
    transactionList.editTransaction(1, "Supermarket Shopping", 60.0)

    // Delete a transaction
    transactionList.deleteTransaction(2)

    // List transactions after editing and deleting
    transactionList.listTransactions()
}
