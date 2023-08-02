//
//  ApiHandlerClass.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

//MARK: API Constant

struct APIConstant {
    static let content_type = "Content-Type"
    static let content_value_Json = "application/json"
}

private var sharedApi:ApiHandlerClass? = nil

class ApiHandlerClass: NSObject {
    
    class func shared() -> ApiHandlerClass
    {
        if sharedApi == nil { sharedApi = ApiHandlerClass() }
        return sharedApi!
    }
    
    //MARK: Call Get Api Using URLSession
    
    func getApiCall<T: Decodable>(modelClass: T.Type?,
                                  apiName: String?,
                                  body: NSMutableDictionary,
                                  contentType: String,
                                  url: String,
                                  successBlock: @escaping (T) -> Void,
                                  failureBlock: @escaping (Error) -> Void) {
        
        if Reachability().connectionStatus().isOnline() {
            guard let apiName = apiName,
                  let apiUrl = URL(string: url + apiName) else {
                // Handle URL creation failure
                return
            }
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"
            
            let headers: [String: String] = [APIConstant.content_type: contentType]
            
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    
                    if let error = error {
                        failureBlock(error)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return
                    }
                    
                    let statusCode = httpResponse.statusCode
                    
                    //Check Status Code
                    if statusCode != 200 {
                        Alert.shared.showAlert(message: APIErrorMessage.SomethingWentWrong)
                        return
                    }
                    
                    if let data = data {
                        do {
                            let objModalClass = try JSONDecoder().decode(modelClass!, from: data)
                            successBlock(objModalClass)
                        } catch let error {
                            Alert.shared.showAlert(message: APIErrorMessage.SomethingWentWrong)
                            failureBlock(error)
                        }
                    } else {
                        Alert.shared.showAlert(message: APIErrorMessage.SomethingWentWrong)
                        return
                    }
                }
            }
            task.resume()
        } else {
            Alert.shared.showAlert(message: APIErrorMessage.NoInternet)
        }
    }
    
    //MARK: For Download Image
    
    func downloadImage(_ urlString: String, completion: ((_ image: UIImage?, _ urlString: String?) -> ())?) {
        if Reachability().connectionStatus().isOnline() {
            guard let url = URL(string: urlString) else {
                completion?(nil, urlString)
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response,error) in
                if let error = error {
                    print("error in downloading image: \(error)")
                    completion?(nil, urlString)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                    completion?(nil, urlString)
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    completion?(image, urlString)
                    return
                }
                completion?(nil, urlString)
            }.resume()
        } else {
            Alert.shared.showAlert(message: APIErrorMessage.NoInternet)
        }
    }
    
}
