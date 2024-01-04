
import Foundation
import StoreKit
//import SwiftUI

class StoreKitManager :ObservableObject {
    
    @Published var storeProducts: [Product] = []
    @Published var purchaseCourses: [Product] = []
    private let productDict: [String : String]
    var updateListenToTask: Task<Void, Error>? = nil
    init(){
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: plistPath){
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String] ) ?? [:]
            
        }else{
            productDict = [:]
        }
        
        updateListenToTask = listenForTransactions()
        Task{
            await requestProducts()
            await updateCutomerProductStatus()
        }
    }
    
    deinit {
        updateListenToTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached{
            for await result in Transaction.updates{
                do{
                    let transaction = try self.checkVerified(result)
                    await self.updateCutomerProductStatus()
                    
                    await transaction.finish()
                    
                }catch{
                    print("Transaction faild verfication")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async{
        do{
            storeProducts = try await Product.products(for: productDict.values)
        }catch{
            print("Failed - error retriving product \(error)")
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        
        let result = try await product.purchase()
        
        switch result {
            
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            await updateCutomerProductStatus()
            
            await transaction.finish()
            return transaction
            
        case .userCancelled, .pending:
            return nil
         default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result{
            
        case .unverified:
            throw StoreError.failedVerification
            
        case .verified(let signedType):
            return signedType
        }
    }
    
    @MainActor
    func updateCutomerProductStatus() async{
        var purchaseCourses: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do{
               let transaction = try checkVerified(result)
                if let course = storeProducts.first(where: {$0.id == transaction.productID}){
                    purchaseCourses.append(course)
                }
                
            }catch{
                print("Transaction Failed")
            }
            self.purchaseCourses = purchaseCourses
        }
        
    }
    func isPurchase(_ product: Product) async throws -> Bool{
        return purchaseCourses.contains(product)
    }
    
}

public enum StoreError: Error{
    case failedVerification
}
