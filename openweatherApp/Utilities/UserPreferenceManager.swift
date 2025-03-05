//
//  UserPreferenceManager.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import Foundation

class UserPreferenceManager: NSObject {
    
    private let defaultUsername = "username123"
    private let defaultPassword = "password123"
    
    private static let usernameKey = "username"
    private static let passwordKey = "password"
    
    static let shared = UserPreferenceManager()
    
    internal var userDefaults: UserDefaults
    
    override init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var username: String? {
        get {
            return userDefaults.string(forKey: UserPreferenceManager.usernameKey) ?? self.defaultUsername
        }
        set(newUsername) {
            if let username = newUsername {
                userDefaults.set(username, forKey: UserPreferenceManager.usernameKey)
            } else {
                userDefaults.removeObject(forKey: UserPreferenceManager.usernameKey)
            }
        }
    }
    
    var password: String? {
        get {
            return userDefaults.string(forKey: UserPreferenceManager.passwordKey) ?? self.defaultPassword
        }
        set(newPassword) {
            if let password = newPassword {
                userDefaults.set(password, forKey: UserPreferenceManager.passwordKey)
            } else {
                userDefaults.removeObject(forKey: UserPreferenceManager.passwordKey)
            }
        }
    }
}
