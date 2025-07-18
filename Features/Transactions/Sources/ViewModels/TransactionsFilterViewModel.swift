// Copyright (c). Gem Wallet. All rights reserved.

import Foundation
import Primitives
import Store
import Localization
import PrimitivesComponents
import Components

@Observable
public final class TransactionsFilterViewModel: Equatable {
    public var chainsFilter: ChainsFilterViewModel
    public var transactionTypesFilter: TransactionTypesFilterViewModel
    public var isPresentingChains: Bool = false
    public var isPresentingTypes: Bool = false

    public init(chainsFilterModel: ChainsFilterViewModel,
         transactionTypesFilter: TransactionTypesFilterViewModel) {
        self.chainsFilter = chainsFilterModel
        self.transactionTypesFilter = transactionTypesFilter
    }

    public static func == (lhs: TransactionsFilterViewModel, rhs: TransactionsFilterViewModel) -> Bool {
        lhs.chainsFilter == rhs.chainsFilter &&
        lhs.transactionTypesFilter == rhs.transactionTypesFilter &&
        lhs.isPresentingChains == rhs.isPresentingChains &&
        lhs.isPresentingTypes == rhs.isPresentingTypes
    }

    public var isAnyFilterSpecified: Bool {
        chainsFilter.isAnySelected || transactionTypesFilter.isAnySelected
    }

    public var title: String { Localized.Filter.title }
    public var clear: String { Localized.Filter.clear }
    public var done: String { Localized.Common.done }

    public var networksModel: NetworkSelectorViewModel {
        NetworkSelectorViewModel(
            state: .data(.plain(chainsFilter.allChains)),
            selectedItems: chainsFilter.selectedChains,
            selectionType: .multiSelection
        )
    }

    public var typesModel: TransactionTypesSelectorViewModel {
        TransactionTypesSelectorViewModel(
            state: .data(.plain(transactionTypesFilter.allTransactionsTypes)),
            selectedItems: transactionTypesFilter.selectedTypes,
            selectionType: .multiSelection
        )
    }
    
    public var requestFilters: [TransactionsRequestFilter] {
        var filters: [TransactionsRequestFilter] = []
        
        if !chainsFilter.selectedChains.isEmpty {
            let chainIds = chainsFilter.selectedChains.map { $0.rawValue }
            filters.append(.chains(chainIds))
        }
        
        if !transactionTypesFilter.selectedTypes.isEmpty {
            let typeIds = transactionTypesFilter.requestFilters.map { $0.rawValue }
            filters.append(.types(typeIds))
        }
        
        return filters
    }
}

// MARK: - Actions

extension TransactionsFilterViewModel {
    public func onClear() {
        chainsFilter.selectedChains = []
        transactionTypesFilter.selectedTypes = []
    }
    
    public func onFinishChainSelection(value: SelectionResult<Chain>) {
        chainsFilter.selectedChains = value.items
    }
    
    public func onFinishTypeSelection(value: SelectionResult<TransactionFilterType>) {
        transactionTypesFilter.selectedTypes = value.items
    }
    
    public func onSelectChainsFilter() {
        isPresentingChains.toggle()
    }
    
    public func onSelectTypesFilter() {
        isPresentingTypes.toggle()
    }
}

extension TransactionsFilterViewModel {
    convenience init(wallet: Wallet) {
        self.init(
            chainsFilterModel: ChainsFilterViewModel(
                chains: wallet.chains
            ),
            transactionTypesFilter: TransactionTypesFilterViewModel(
                types: TransactionType.allCases
            )
        )
    }
}
