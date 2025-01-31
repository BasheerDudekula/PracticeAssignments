//
//  EditTransactionView.swift
//  BudgetTracker2
//
//  Created by admin on 30/01/25.
//

import SwiftUI

struct EditTransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var transaction : Transaction
    @State private var title = ""
    @State private var amount = ""
    @State private var category = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Edit Transactio Details")) {
                    TextField("Edit transaction title", text: $title)
                    TextField("Edit transaction amount", text: $amount)
                }
            }
            .navigationBarTitle("Edit Transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Update") {
                if let isdouble = Double(amount) {
                    transaction.amount = isdouble
                } else {
                    transaction.amount = 0.0
                }
                
                transaction.title = title
                saveContext()
                dismiss()
            }.disabled(title.isEmpty)
            )
            .onAppear {
                amount = String(format: "%.2f", transaction.amount)
                title = transaction.title ?? ""
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error svaing context: \(error)")
        }
    }
}
