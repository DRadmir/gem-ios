/*
 Generated by typeshare 1.9.2
 */

import Foundation

public enum DelegationState: String, Codable, CaseIterable, Equatable {
	case active
	case pending
	case undelegating
	case inactive
	case activating
	case deactivating
	case awaitingWithdrawal = "awaitingwithdrawal"
}

public struct DelegationBase: Codable, Equatable, Hashable {
	public let assetId: AssetId
	public let state: DelegationState
	public let balance: String
	public let shares: String
	public let rewards: String
	public let completionDate: Date?
	public let delegationId: String
	public let validatorId: String

	public init(assetId: AssetId, state: DelegationState, balance: String, shares: String, rewards: String, completionDate: Date?, delegationId: String, validatorId: String) {
		self.assetId = assetId
		self.state = state
		self.balance = balance
		self.shares = shares
		self.rewards = rewards
		self.completionDate = completionDate
		self.delegationId = delegationId
		self.validatorId = validatorId
	}
}

public struct DelegationValidator: Codable, Equatable, Hashable {
	public let chain: Chain
	public let id: String
	public let name: String
	public let isActive: Bool
	public let commision: Double
	public let apr: Double

	public init(chain: Chain, id: String, name: String, isActive: Bool, commision: Double, apr: Double) {
		self.chain = chain
		self.id = id
		self.name = name
		self.isActive = isActive
		self.commision = commision
		self.apr = apr
	}
}

public struct Delegation: Codable, Equatable, Hashable {
	public let base: DelegationBase
	public let validator: DelegationValidator
	public let price: Price?

	public init(base: DelegationBase, validator: DelegationValidator, price: Price?) {
		self.base = base
		self.validator = validator
		self.price = price
	}
}
