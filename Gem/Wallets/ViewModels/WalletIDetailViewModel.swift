import SwiftUI
import Primitives
import Keystore
import Components
import Style
import Localization
import PrimitivesComponents

class WalletDetailViewModel {

    @Binding var navigationPath: NavigationPath
    let wallet: Wallet
    let keystore: any Keystore

    init(
        navigationPath: Binding<NavigationPath>,
        wallet: Wallet,
        keystore: any Keystore
    ) {
        _navigationPath = navigationPath
        self.wallet = wallet
        self.keystore = keystore
    }

    var image: AssetImage {
        AssetImage(
            type: .empty,
            imageURL: .none,
            placeholder: WalletViewModel(wallet: wallet).image,
            chainPlaceholder: .none //Image(systemName: SystemImage.settings)
        )
    }

    var name: String {
        wallet.name
    }
    
    var title: String {
        return Localized.Common.wallet
    }
    
    var address: WalletDetailAddress? {
        switch wallet.type {
        case .multicoin:
            return .none
        case .single, .view, .privateKey:
            guard let account = wallet.accounts.first else { return .none }
            return WalletDetailAddress.account(
                SimpleAccount(
                    name: .none,
                    chain: account.chain,
                    address: account.address,
                    assetImage: .none
                )
            )
        }
    }
}

// MARK: - Business Logic

extension WalletDetailViewModel {
    func rename(name: String) throws {
        try keystore.renameWallet(wallet: wallet, newName: name)
    }
    
    func getMnemonicWords() throws -> [String] {
        try keystore.getMnemonic(wallet: wallet)
    }
    
    func getPrivateKey(for chain: Chain) throws -> String {
        let encoding = getEncodingType(for: chain)
        return try keystore.getPrivateKey(wallet: wallet, chain: chain, encoding: encoding)
    }
    
    func getEncodingType(for chain: Chain) -> EncodingType {
        return chain.defaultKeyEncodingType
    }

    func delete() throws {
        try keystore.deleteWallet(for: wallet)

        if keystore.wallets.isEmpty {
            try CleanUpService(keystore: keystore).onDeleteAllWallets()
        }
    }

    func onSelectImage() {
        //navigationPath.append(Scenes.WalletSelectImage(wallet: wallet))
    }
}
