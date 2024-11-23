/*
 Generated by typeshare 1.11.0
 */

import Foundation

public struct AssetAddress: Codable, Equatable, Hashable, Sendable {
	public let asset: Asset
	public let address: String

	public init(asset: Asset, address: String) {
		self.asset = asset
		self.address = address
	}
}

public struct AssetData: Codable, Sendable {
	public let asset: Asset
	public let balance: Balance
	public let account: Account
	public let price: Price?
	public let price_alert: PriceAlert?
	public let metadata: AssetMetaData

	public init(asset: Asset, balance: Balance, account: Account, price: Price?, price_alert: PriceAlert?, metadata: AssetMetaData) {
		self.asset = asset
		self.balance = balance
		self.account = account
		self.price = price
		self.price_alert = price_alert
		self.metadata = metadata
	}
}
