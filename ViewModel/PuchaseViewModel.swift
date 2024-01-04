
import Foundation
import StoreKit
import SwiftUI

class PuchaseViewModel: ObservableObject{
    @Published var products: [Product] = []
    @Published var purchaseIds:[String] = []
    private let productDict: [String : String] = [:]
    func fetchForPay(){
        Task{
            do{
                let products = try await Product.products(for: productDict.values)
                DispatchQueue.main.async {
                    self.products = products
                }
               await isPurcahased()
            }catch{
                print(error)
            }
        }
    }
    
    func isPurcahased() async{
      
            guard let product = products.first else { return }
         
            guard   let state = await product.currentEntitlement else {return}
            switch state {
                
            case .unverified(_ , _):
                break
            case .verified(let transaction):
                DispatchQueue.main.async {
                    self.purchaseIds.append(transaction.productID)
                    print(transaction.productID)
                }
             
        }
    }
    func purchase(){
        Task{
            guard let product = products.first else { return }
            do{
                let result = try await product.purchase()
                switch result {
                    
                case .success(let verification):
                    switch verification {
                        
                    case .unverified(_ , _):
                        break
                    case .verified(let transaction):
                        print(transaction.productID)
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            }catch{
                print(error)
            }
        }
    }
}
