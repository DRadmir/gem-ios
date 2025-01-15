/*
 Generated by typeshare 1.12.0
 */

import Foundation

public struct TonEstimateFee: Codable, Sendable {
	public let address: String
	public let body: String
	public let ignore_chksig: Bool

	public init(address: String, body: String, ignore_chksig: Bool) {
		self.address = address
		self.body = body
		self.ignore_chksig = ignore_chksig
	}
}

public struct TonFee: Codable, Sendable {
	public let in_fwd_fee: Int32
	public let storage_fee: Int32

	public init(in_fwd_fee: Int32, storage_fee: Int32) {
		self.in_fwd_fee = in_fwd_fee
		self.storage_fee = storage_fee
	}
}

public struct TonFees: Codable, Sendable {
	public let source_fees: TonFee

	public init(source_fees: TonFee) {
		self.source_fees = source_fees
	}
}
