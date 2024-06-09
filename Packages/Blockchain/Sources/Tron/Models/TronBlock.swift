/*
 Generated by typeshare 1.9.2
 */

import Foundation

public struct TronHeader: Codable {
	public let number: UInt64
	public let version: UInt64
	public let txTrieRoot: String
	public let witness_address: String
	public let parentHash: String
	public let timestamp: UInt64

	public init(number: UInt64, version: UInt64, txTrieRoot: String, witness_address: String, parentHash: String, timestamp: UInt64) {
		self.number = number
		self.version = version
		self.txTrieRoot = txTrieRoot
		self.witness_address = witness_address
		self.parentHash = parentHash
		self.timestamp = timestamp
	}
}

public struct TronHeaderRawData: Codable {
	public let raw_data: TronHeader

	public init(raw_data: TronHeader) {
		self.raw_data = raw_data
	}
}

public struct TronBlock: Codable {
	public let block_header: TronHeaderRawData

	public init(block_header: TronHeaderRawData) {
		self.block_header = block_header
	}
}
