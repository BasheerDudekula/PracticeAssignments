//
//  AddTransactionView.swift
//  BudgetTracker2
//
//  Created by admin on 30/01/25.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var amount = ""
    @State private var category = "expense"
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Transaction Details")) {
                    TextField("Enter Title", text: $title )
                    TextField("Enter amount", text: $amount).keyboardType(.decimalPad)
                    
                    Picker("Category", selection: $category) {
                        Text("Income").tag("income")
                        Text("Expense").tag("expense")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Add New Transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
                                trailing: Button("Save") {
                addTransaction()
                dismiss()
            }
                .disabled(amount.isEmpty || title.isEmpty)
            )
        }
    }
    
    private func addTransaction() {
        let newTransaction = Transaction(context: viewContext)
        
        newTransaction.id = UUID()
        newTransaction.title = title
        newTransaction.category = category
        
        if let isDouble = Double(amount) {
            newTransaction.amount = isDouble
        } else {
            newTransaction.amount = 0.0
        }
        
        do{
            try viewContext.save()
            title = ""
            amount = ""
            category = ""
        } catch {
            print("Error saving transaction: \(error)")
        }
    }
                                
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
