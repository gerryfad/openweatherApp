//
//  APIManager.swift
//  openweatherApp
//
//  Created by Gerry on 03/03/25.
//


import RxSwift
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    func request<T: Decodable>(
        path: String,
        method: Alamofire.HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) -> Observable<T> {
        return Observable.create { observer in
            let url = self.baseURL + path
            
            let request = AF.request(
                url,
                method: HTTPMethod(rawValue: method.rawValue),
                parameters: parameters,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
