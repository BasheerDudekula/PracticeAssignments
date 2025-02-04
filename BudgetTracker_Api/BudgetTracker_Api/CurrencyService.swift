//
//  CurrencyService.swift
//  BudgetTracker_Api
//
//  Created by admin on 01/02/25.
//

import Foundation

import Combine


struct ExchangeRateResponse: Codable {

    let rates: [String: Double]

}


class CurrencyService {

    static let shared = CurrencyService()

    private var cancellables = Set<AnyCancellable>()


    func fetchExchangeRates(baseCurrency: String) -> AnyPublisher<[String: Double], Error> {

        let urlString = "https://open.er-api.com/v6/latest/\(baseCurrency)?apikey=c1ed5988b3dc3df51563c524"

        guard let url = URL(string: urlString) else {

        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()

    }


        return URLSession.shared.dataTaskPublisher(for: url)

            .map(\.data)

            .decode(type: ExchangeRateResponse.self, decoder: JSONDecoder())

            .map { $0.rates }

            .receive(on: DispatchQueue.main)

            .eraseToAnyPublisher()

    }

}
