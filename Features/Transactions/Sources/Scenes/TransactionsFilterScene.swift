// Copyright (c). Gem Wallet. All rights reserved.

import SwiftUI
import Style
import Components
import Primitives
import PrimitivesComponents

public struct TransactionsFilterScene: View {
    @Environment(\.dismiss) private var dismiss

    @State private var model: TransactionsFilterViewModel

    public init(model: TransactionsFilterViewModel) {
        _model = State(wrappedValue: model)
    }

    public var body: some View {
        List {
            SelectFilterView(
                typeModel: model.chainsFilter.typeModel,
                action: { model.onSelectChainsFilter() }
            )
            SelectFilterView(
                typeModel: model.transactionTypesFilter.typeModel,
                action: { model.onSelectTypesFilter() }
            )
        }
        .contentMargins(.top, .scene.top, for: .scrollContent)
        .listStyle(.insetGrouped)
        .navigationTitle(model.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if model.isAnyFilterSpecified {
                ToolbarItem(placement: .cancellationAction) {
                    Button(model.clear, action: onSelectClear)
                        .bold()
                        .buttonStyle(.plain)
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button(model.done, action: onSelectDone)
                    .bold()
                    .buttonStyle(.plain)
            }
        }
        .sheet(isPresented: $model.isPresentingChains) {
            SelectableSheet(
                model: model.networksModel,
                onFinishSelection: onFinishSelection(value:),
                listContent: { ChainView(model: ChainViewModel(chain: $0)) }
            )
        }
        .sheet(isPresented: $model.isPresentingTypes) {
            SelectableSheet(
                model: model.typesModel,
                onFinishSelection: onFinishSelection(value:),
                listContent: {
                    ListItemView(title: TransactionFilterTypeViewModel(type: $0).title)
                }
            )
        }
    }
}

// MARK: - Actions

extension TransactionsFilterScene {
    private func onSelectClear() {
        model.onClear()
    }

    private func onSelectDone() {
        dismiss()
    }

    private func onFinishSelection(value: SelectionResult<Chain>) {
        model.onFinishChainSelection(value: value)
        if value.isConfirmed {
            dismiss()
        }
    }

    private func onFinishSelection(value: SelectionResult<TransactionFilterType>) {
        model.onFinishTypeSelection(value: value)
        if value.isConfirmed {
            dismiss()
        }
    }

}

#Preview {
    NavigationStack {
        TransactionsFilterScene(
            model: TransactionsFilterViewModel(
                chainsFilterModel: ChainsFilterViewModel(
                    chains: [.aptos, .arbitrum]
                ),
                transactionTypesFilter: TransactionTypesFilterViewModel(
                    types: [.swap, .stakeDelegate]
                )
            )
        )
    }
}
