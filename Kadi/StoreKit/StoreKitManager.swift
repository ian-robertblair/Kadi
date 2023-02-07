//
//  StoreKitManager.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/29.
//

import Foundation
import StoreKit

class StoreKitManager: ObservableObject {
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedVersions: [Product] = []
    
    var updateListenerTask:Task<Void, Error>? = nil
    private let productDict: [String: String]
    
    init() {
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String:String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
        
    }
    
    deinit {
        
        updateListenerTask?.cancel()
    }
    
    @MainActor
    func requestProducts() async {
        do {
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print("Error retrieving products --- \(error)")
        }
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let tranaction = try self.checkVerified(result)
                    await  self.updateCustomerProductStatus()
                    await tranaction.finish()
                } catch {
                    print("Transaction failed verification.")
                }
            }
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            await updateCustomerProductStatus()
            await transaction.finish()
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, let error):
            throw StoreError.failedVerification(error)  //modified to get error
        case .verified(let signedType):
            return signedType
        }
    }
    
    enum StoreError: Error {
        case failedVerification(Error)
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedVersions:[Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if let version = storeProducts.first(where:  {$0.id == transaction.productID} ) {
                    purchasedVersions.append(version)
                }
            } catch {
                print("Transaction failed verification.")
            }
        }
        
       
        self.purchasedVersions = purchasedVersions
        
    }
    
    func isPurchased(product: Product) async throws -> Bool {
        return self.purchasedVersions.contains(product)
    }
    
}
