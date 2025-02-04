//
//  TransactionViewModel.swift
//  BudgetTracker_Api
//
//  Created by admin on 01/02/25.
//

import Foundation

import Combine

import CoreData


class TransactionViewModel: ObservableObject {

    @Published var transactions: [Transaction] = []

    @Published var exchangeRates: [String: Double] = [:]


    private var cancellables = Set<AnyCancellable>()

    private let context: NSManagedObjectContext


    init(context: NSManagedObjectContext) {

        self.context = context

        fetchTransactions()

        fetchExchangeRates()

    }


    func fetchTransactions() {

        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)]


        do {

            transactions = try context.fetch(request)

        } catch {

            print("Error fetching transactions: \(error)")

        }

}


    func fetchExchangeRates(baseCurrency: String = "USD") {

        CurrencyService.shared.fetchExchangeRates(baseCurrency: baseCurrency)

            .sink(receiveCompletion: { completion in

                if case .failure(let error) = completion {

                    print("Failed to fetch rates: \(error)")

                }

            }, receiveValue: { [weak self] rates in

                self?.exchangeRates = rates

            }
            )

            .store(in: &cancellables)

    }


    func convertAmount(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double {

        guard let sourceRate = exchangeRates[sourceCurrency],

                let targetRate = exchangeRates[targetCurrency] else { return amount }


        return (amount / sourceRate) * targetRate

    }


    func addTransaction(amount: Double, currency: String, category: String, note: String?) {

        let transaction = Transaction(context: context)

        transaction.id = UUID()

        transaction.amount = amount

        transaction.currency = currency

        transaction.date = Date()

        transaction.category = category

        transaction.note = note


        saveContext()

        fetchTransactions()

    }


    private func saveContext() {

        do {

            try context.save()

        } catch {

            print("Error saving context: \(error)")
            
        }

    }

}
