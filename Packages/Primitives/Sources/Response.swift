/*
 Generated by typeshare 1.12.0
 */

import Foundation

public struct ResponseError: Codable, Sendable {
	public let error: String

	public init(error: String) {
		self.error = error
	}
}

public struct ResponseResult<T: Codable & Sendable>: Codable, Sendable {
	public let data: T

	public init(data: T) {
		self.data = data
	}
}
