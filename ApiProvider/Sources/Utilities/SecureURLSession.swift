//
//  SecureURLSession.swift
//  ApiProvider
//
//  Created by Vladimir Abramichev on 19/05/2019.
//  Copyright © 2019 Vladimir Abramichev. All rights reserved.
//

import Foundation

class SecureURLSession : NSObject, URLSessionDelegate {
    
    private let urls: [URL]
    
    override init() {
        urls = Bundle.allBundles.reduce([URL](), { $0 + ($1.urls(forResourcesWithExtension: ".cer", subdirectory: nil) ?? []) })
        super.init()
    }
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard
            let serverTrust = challenge.protectionSpace.serverTrust,
            let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
            urls.count > 0
            else {
                completionHandler(.cancelAuthenticationChallenge , nil)
                return
        }
        
        let host = challenge.protectionSpace.host as CFString
        let localCertificates = urls.compactMap{ try? Data(contentsOf: $0) }
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray();
        policies.add(SecPolicyCreateSSL(true, host))
        SecTrustSetPolicies(serverTrust, policies);
        
        // Evaluate server certificate
        var result = SecTrustResultType.unspecified
        SecTrustEvaluate(serverTrust, &result)
        let isServerTrusted = result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed
        
        // Get local and remote cert data
        let remoteCertificateData:NSData = SecCertificateCopyData(certificate)
        
        if isServerTrusted && localCertificates.reduce(false) { $0 || remoteCertificateData.isEqual(to:$1) } {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
