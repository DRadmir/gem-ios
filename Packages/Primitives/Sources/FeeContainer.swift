// Copyright (c). Gem Wallet. All rights reserved.

import Foundation
import BigInt

public enum FeeOption: Sendable {
    case tokenAccountCreation
}

public typealias FeeOptionMap = [FeeOption: BigInt]

public struct Fee: Sendable {
    public let fee: BigInt
    public let gasPriceType: GasPriceType
    public let gasLimit: BigInt
    public let options: FeeOptionMap

    public init(
        fee: BigInt,
        gasPriceType: GasPriceType,
        gasLimit: BigInt,
        options: FeeOptionMap = [:]
    ) {
        self.fee = fee
        self.gasPriceType = gasPriceType
        self.gasLimit = gasLimit
        self.options = options
    }

    public var gasPrice: BigInt { gasPriceType.gasPrice }
    public var priorityFee: BigInt { gasPriceType.priorityFee }
    public var totalFee: BigInt { fee + optionsFee }
    public var optionsFee: BigInt { options.map { $0.value }.reduce(0, +) }

    public func withOptions(_ feeOptions: [FeeOption]) -> Fee {
        return Fee(
            fee: fee + options.filter { feeOptions.contains($0.key) }.map { $0.value }.reduce(0, +),
            gasPriceType: gasPriceType,
            gasLimit: gasLimit
        )
    }
}

// MARK: - Equatable

extension Fee: Equatable { }
