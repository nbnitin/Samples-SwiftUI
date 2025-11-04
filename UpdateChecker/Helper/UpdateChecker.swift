//
//  UpdateChecker.swift
//  UpdateChecker
//
//  Created by Nitin Bhatia on 01/11/25.
//

import SwiftUI

@MainActor
class UpdateCheckerManager {
    static let shared = UpdateCheckerManager()
    
    private init() {}
    
    var bundleID : String? {
        Bundle.main.bundleIdentifier
    }
    
    private func getLookUpUrl(_ appID: String? = nil) -> URL? {
        if let appID {
            return URL(string: "https://itunes.apple.com/lookup?id=\(appID)")
        }
        guard let bundleID, let lookUpURL = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleID)") else {
            return nil
        }
        return lookUpURL
    }
    
    
    func checkIfAppUpdateAvailable(appID: String? = nil) async -> ReturnResult? {
        guard let lookUpURL = getLookUpUrl(appID) else {
            return nil
        }
        print(lookUpURL)
        do {
            //https://itunes.apple.com/lookup?id=\(appID)
            let data = try await URLSession.shared.data(from: lookUpURL).0
            guard let rawJSON = (try JSONSerialization.jsonObject(with: data)) as? Dictionary<String, Any> else {
                return nil
            }
            guard let jsonResult = rawJSON["results"] as? [Any] else {
                return nil
            }

            guard let jsonValues = jsonResult.first as? Dictionary<String, Any> else {
                return nil
            }

            guard let availableVersion = jsonValues["version"] as? String,
                  let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                  let appLogo = jsonValues["artworkUrl512"] as? String,
                  let releaseNotes = jsonValues["releaseNotes"] as? String,
                  let appURl = jsonValues["trackViewUrl"] as? String else {
                return nil
            }
                        
            let result: ReturnResult = .init(currrntVersion: currentVersion,
                                             availableVersion: availableVersion,
                                             releaseNotes: releaseNotes,
                                             appLogo: appLogo,
                                             appURL: appURl)
            return result
            
            
        } catch {
            return nil
        }
    }
    
   
    struct ReturnResult: Identifiable {
        private(set) var id : String = UUID().uuidString
        var currrntVersion: String
        var availableVersion: String
        var releaseNotes: String
        var appLogo: String
        var appURL: String
        
    }
}
