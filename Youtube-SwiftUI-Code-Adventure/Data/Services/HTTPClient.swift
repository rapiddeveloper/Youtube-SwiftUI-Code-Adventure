//
//  HTTPClient.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

 

import Foundation

typealias Token = String

protocol URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol HTTPClient {
   
    func sendRequest<T: Decodable>(_ request: URLRequest, urlSession: URLSessionProtocol, responseModel: T.Type, allowRetry: Bool,  keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, refreshToken: String?) async -> Result<T, RequestError>
}


extension HTTPClient {
   
    
 
    
    func sendRequest<T: Decodable>(_ request: URLRequest, urlSession: URLSessionProtocol = URLSession.shared, responseModel: T.Type, allowRetry: Bool = true, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, refreshToken: String? = nil) async -> Result<T, RequestError> {
        
        
 
        guard let url = request.url else { return .failure(.invalidURL(nil))}
        
        /*
        var urlRequest = URLRequest(url: url)
 
        if let body = request.httpBody {
            
            do {
                
                if let bodyData = body as? Data {
                    urlRequest.httpBody = bodyData
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                }
            } catch {
                
                return .failure(.unexpected(error.localizedDescription))
            }
        }*/
        
        do {
            
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
 
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse(nil))
            }
            
            /*
            print(String(data: data, encoding: .utf8)!)
            print(response.statusCode)*/
             
           // dump(response)
            
           // dump(request)
            switch response.statusCode {
            
            case 204:
                
                return .success(204 as! T)
            case 200...299:
                 let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = keyDecodingStrategy
 
             
                let result = try decoder.decode(T.self, from: data)
                
                return .success(result)
            case 400:
                //                dump(data)
              //  print(String(data: data, encoding: .utf8)!)

                return .failure(.badRequest(nil))
                
            case 401:
                 /*
                 if allowRetry, let authManager = authManager, let refreshToken = refreshToken {
                    
                     
                    let session = try await authManager.refreshSession(refreshToken: refreshToken)
                     
                    
                 var updatedRequest = request
                 updatedRequest.headers["accessToken"] = session.accessToken
                
                     return await sendRequest(updatedRequest, responseModel: T.self, allowRetry: false, keyDecodingStrategy: keyDecodingStrategy, dateDecodingStrategy: dateDecodingStrategy)
                 }*/
                return .failure(.unauthorized)
            case 404:
                return .failure(RequestError.notFound)
            case 500...599:
                return .failure(.server)
            default:
                return .failure(.unexpected(nil))
            }
        } catch  {
            print(error)
            print(error.localizedDescription)
            if error is Swift.DecodingError {
                return .failure(.unexpected("Something went wrong.Contact Support"))
            }
            guard let urlError = error as? URLError else {return .failure(.unexpected(nil))}
           
            switch urlError.code {
        
            case .notConnectedToInternet,
                 .dataNotAllowed:
                return .failure(.addressUnreachable(url))
            case .timedOut:
                return .failure(.unexpected("Request timed out. Try again"))
           // case .cannotDecodeRawData:
             //   return .failure(.unexpected("Cannot decode data"))
             default:
                return .failure(.unexpected(nil))
            }
           
        }
    }
    
}

