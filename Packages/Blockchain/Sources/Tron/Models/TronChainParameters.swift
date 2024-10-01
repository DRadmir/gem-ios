/*
 Generated by typeshare 1.11.0
 */

import Foundation

public struct TronChainParameter: Codable, Sendable {
	public let key: String
	public let value: Int64?

	public init(key: String, value: Int64?) {
		self.key = key
		self.value = value
	}
}

public struct TronChainParameters: Codable, Sendable {
	public let chainParameter: [TronChainParameter]

	public init(chainParameter: [TronChainParameter]) {
		self.chainParameter = chainParameter
	}
}

public enum TronChainParameterKey: String, Codable, Equatable, Sendable {
	case getCreateNewAccountFeeInSystemContract
	case getCreateAccountFee
	case getEnergyFee
}
