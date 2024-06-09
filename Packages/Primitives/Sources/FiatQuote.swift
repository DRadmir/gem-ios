/*
 Generated by typeshare 1.9.2
 */

import Foundation

public struct FiatQuote: Codable, Equatable {
	public let provider: FiatProvider
	public let fiatAmount: Double
	public let fiatCurrency: String
	public let cryptoAmount: Double
	public let redirectUrl: String

	public init(provider: FiatProvider, fiatAmount: Double, fiatCurrency: String, cryptoAmount: Double, redirectUrl: String) {
		self.provider = provider
		self.fiatAmount = fiatAmount
		self.fiatCurrency = fiatCurrency
		self.cryptoAmount = cryptoAmount
		self.redirectUrl = redirectUrl
	}
}

public struct FiatQuotes: Codable {
	public let quotes: [FiatQuote]

	public init(quotes: [FiatQuote]) {
		self.quotes = quotes
	}
}
