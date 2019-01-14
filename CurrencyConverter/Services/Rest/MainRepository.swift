//
//  MainRepository.swift
//  CurrencyConverter
//
//  Created by Vadim Osmanov on 1/10/19.
//  Copyright © 2019 Vadim Osmanov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift


struct MainRepository{
    
    func fetchAllCurrencies() -> Observable<[Currency]> {
        return Observable<[Currency]>.create { observer -> Disposable in
            let request = Alamofire
                .request(API.baseUrl + API.allCurrencies, method: .get)
                .logHttp()
                .validate()
                .responseJSON{ (response) in
                    switch response.result{
                    case .success( _):
                        if let responseValue = response.value as? [String: Any] {
                            if let dictResults = responseValue["results"] as! [String: [String: String]]? {
                                if dictResults.count > 0 {
                                    var currencies = [Currency]()
                                    for (_, value) in dictResults {
                                        let mappedCurrency = Mapper<Currency>().map(JSON: value)
                                        currencies.append(mappedCurrency!)
                                    }
                                    observer.onNext(currencies)
                                    observer.onCompleted()
                                }else{
                                    observer.onError(NSError(domain:"", code: (response.response?.statusCode)!, userInfo:[ NSLocalizedDescriptionKey: "Empty results"]))
                                }
                            }
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: { request.cancel() })
        }
    }
    
    func getRatio(inputCurrencyShortName: String, outputCurrencyShortName: String) -> Observable<Double>{
        return Observable<Double>.create { observer -> Disposable in
            let request = Alamofire
                .request(API.baseUrl + API.ratioCurrencies(inputCurrencyShortName: inputCurrencyShortName, outputCurrencyShortName: outputCurrencyShortName), method: .get)
                .logHttp()
                .validate()
                .responseJSON{ (response) in
                    switch response.result{
                    case .success( _):
                        if let responseValue = response.value as? [String: Double] {
                            if responseValue.count > 0 {
                                observer.onNext((responseValue.first?.value)!)
                                observer.onCompleted()
                            }else{
                                observer.onError(NSError(domain:"", code: (response.response?.statusCode)!, userInfo:[ NSLocalizedDescriptionKey: "Empty ratio results for \(inputCurrencyShortName)_\(outputCurrencyShortName)"]))
                            }
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: { request.cancel() })
        }
    }
    
}
