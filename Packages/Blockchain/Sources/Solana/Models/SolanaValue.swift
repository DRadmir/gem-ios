/*
 Generated by typeshare 1.11.0
 */

import Foundation

public struct SolanaValue<T: Codable>: Codable, Sendable {
	public let value: T

	public init(value: T) {
		self.value = value
	}
}
