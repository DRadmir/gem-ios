/*
 Generated by typeshare 1.11.0
 */

import Foundation

public struct BitcoinUTXO: Codable, Sendable {
	public let txid: String
	public let vout: Int32
	public let value: String

	public init(txid: String, vout: Int32, value: String) {
		self.txid = txid
		self.vout = vout
		self.value = value
	}
}
