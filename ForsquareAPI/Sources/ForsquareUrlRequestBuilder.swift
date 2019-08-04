//
//  ForsquareUrlRequestBuilder.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 04/08/2019.
//

import Foundation

public class ForsquareUrlRequestBuilder: RequestBuilder {
    
    private let config : Configuration
    
    public init(with configuration: Configuration) {
        self.config = configuration
    }
    
    public func buildRequest<T>(for endpoint: Endpoint<T>) throws -> URLRequest {
        guard var components = URLComponents(string: config[.url] )
            else { preconditionFailure("invalud URL in config file") }
        
        components.appendPath(config[.version])
        components.appendPath(endpoint.path)
        
        var queryItems = endpoint.queryItems
        queryItems.append(URLQueryItem(name: "client_id", value: config[.client_id]))
        queryItems.append(URLQueryItem(name: "client_secret", value: config[.client_secret]))
        queryItems.append(URLQueryItem(name: "v", value: config[.version_date]))
        components.queryItems = queryItems
        
        guard let url = components.url
            else { preconditionFailure("invalud URL: \(components.description)") }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        return request
    }
}

fileprivate extension URLComponents {
    mutating func appendPath(_ component: String?) {
        guard let component = component else { return }
        appendPath(component.hasPrefix("/") ? "\(component.dropFirst())" : component)
    }
    
    mutating func appendPath(_ component: Int?) {
        guard let component = component else { return }
        appendPath("\(component)")
    }
    
    private mutating func appendPath(_ component: String) {
        path += "/" + component
    }
}

fileprivate extension Date {
    func formatedString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
