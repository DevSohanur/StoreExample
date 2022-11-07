//
//  Networking.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 6/11/22.
//

import Foundation
import SystemConfiguration

class RestApiRequest {
    static func getDataFromJSON<T>(fileName: String, decodableModel: T.Type , successCompletionHandler: @escaping ( T ) -> Void , errorCompletionHandler: @escaping ( String ) -> Void ) -> Void where T: Decodable   {
        
        if Reachability.isConnectedToNetwork() {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(T.self, from: data)
                    successCompletionHandler(jsonData)
                } catch {
                    errorCompletionHandler(error.localizedDescription)
                }
            }
        }
        else{
            errorCompletionHandler("No Internet Connection")
        }
    }
}



public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
