//
//  APIClient.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class APIClient {
    private (set) var baseURLString: String
    
    var accessToken: String?//Set this value for api client sending request after user logged in
    
    var defaultHeaders: [String: String] {
        return [:]
    }
    
    var authenticator: (( _ header: inout HTTPHeaders, _ parameters: inout Parameters) -> Void)?
    
    lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        var headers = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders = headers
        return SessionManager(configuration: configuration)
    }()
    
    init(baseURLString: String) {
        self.baseURLString = baseURLString
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    // MARK: Private Methods
    private func resolvePath(_ path: String) -> String {
        return baseURLString + path
    }
    
    func request ( _ method: HTTPMethod,
                   _ path: String,
                   parameters: Parameters? = nil,
                   encoding: ParameterEncoding = JSONEncoding.default,
                   headers: HTTPHeaders? = nil) -> DataRequest {
        let requestURL = URL(string: resolvePath(path)) ?? URL(fileURLWithPath: "")
        var requestHeaders = HTTPHeaders()
        var requestParams = Parameters()
        
        for (key, value) in defaultHeaders {
            requestHeaders[key] = value
        }
        
//        if let parameters = parameters {
//            for (key, value) in parameters {
//                requestParams[key] = value
//            }
//        }
        
        if let headers = headers {
            for (key, value) in headers {
                requestHeaders[key] = value
            }
        }
        
        if let authenticator = authenticator {
            authenticator(&requestHeaders, &requestParams)
        }
        
        let request = sessionManager.request(requestURL, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders)
        
        //Logging request & response data
//        #if DEBUG
        request.responseString { [weak request](response: DataResponse<String>) in
            LogDebug(request.debugDescription)
            switch response.result {
            case .success(let value):
                if let data = value.data(using: .utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [JSONSerialization.WritingOptions.prettyPrinted])
                        let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
                        debugPrint("Response:\n===============\n\(jsonString)\n===============")
                    } catch {
                        debugPrint("Response:\n===============\n\(value)\n===============")
                    }
                } else {
                    debugPrint("Response:\n===============\n\(value)\n===============")
                }
            case .failure(let error):
                debugPrint("Response:\n===============\n\(error)\n===============")
            }
        }
//        #endif

        return request.validate(statusCode: 200..<399)
    }
    
    /**
     This is depend on json response.
     All response must contains "data" key.
    */

    static func responseObjectSerializer<T: Codable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer(serializeResponse: { _, _, data, error -> Alamofire.Result<T> in
            if let error = error {
                return .failure(ServiceError(code: "\((error as NSError).code)", reason: error.localizedDescription))
            } else {
                guard let data = data else {//Empty data response
                    return .failure(ServiceError.emptyResponse)
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let responseData = try jsonDecoder.decode(ResponseData<T>.self, from: data)
                    if responseData.status == "success", let data = responseData.data {
                        return .success(data)
                    } else if let errorCode = responseData.code, let message = responseData.message {
                        return .failure(ServiceError(code: "\(errorCode)", reason: message))
                    }
                    return .failure(ServiceError.undefined)
                } catch {
                    return .failure(ServiceError.invalidDataFormat)
                }
            }
        })
    }
    
    static func responseArraySerializer<T: Codable>() -> DataResponseSerializer<[T]> {
        return DataResponseSerializer(serializeResponse: { _, _, data, error -> Alamofire.Result<[T]> in
            if let error = error {
                return .failure(ServiceError(code: "\((error as NSError).code)", reason: error.localizedDescription))
            } else {
                guard let data = data else {//Empty data response
                    return .failure(ServiceError.emptyResponse)
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let responseData = try jsonDecoder.decode(ResponseDataList<T>.self, from: data)
                    if responseData.status == "success", let data = responseData.data {
                        return .success(data)
                    } else if let errorCode = responseData.code, let message = responseData.message {
                        return .failure(ServiceError(code: "\(errorCode)", reason: message))
                    }
                    return .failure(ServiceError.undefined)
                } catch {
                    return .failure(ServiceError.invalidDataFormat)
                }
            }
        })
    }
}

extension DataRequest {
    
    @discardableResult
    public func responseTask<T: Codable>(queue: DispatchQueue? = nil) -> Promise<T> {
        return Promise { seal in
            response(queue: queue, responseSerializer: APIClient.responseObjectSerializer()) { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    @discardableResult
    public func responseArrayTask<T: Codable>(queue: DispatchQueue? = nil) -> Promise<[T]> {
        return Promise { seal in
            response(queue: queue, responseSerializer: APIClient.responseArraySerializer()) { (response: DataResponse<[T]>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    @discardableResult
    func responseStatus(queue: DispatchQueue? = nil) -> Promise<Bool> {
        return Promise { seal in
            responseData(queue: queue) { response in
                switch response.result {
                case .success(let data):
                    do {
                        let responseData = try JSONDecoder().decode(ResponseStatus.self, from: data)
                        if responseData.status == "success"{
                            seal.fulfill(true)
                        } else if let errorCode = responseData.code, let message = responseData.message {
                            return seal.reject(ServiceError(code: "\(errorCode)", reason: message))
                        }
                        return seal.reject(ServiceError.undefined)
                    } catch {
                        return seal.reject(ServiceError.invalidDataFormat)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

private struct ResponseStatus: Codable {
    var status: String?
    var code: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status, message, code
    }
}

private struct ResponseData<T: Codable>: Codable {
    var status: String?
    var code: Int?
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status, message, data, code
    }
}

private struct ResponseDataList<T: Codable>: Codable {
    var status: String?
    var code: Int?
    var message: String?
    var data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case status, message, data, code
    }
}
