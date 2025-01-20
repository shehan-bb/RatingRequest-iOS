//
//  Rating.swift
//  RatingRequestManager
//
//  Created by Shehan Gunarathne on 17/01/2025.
//

import UIKit
import StoreKit
import Resolver
import BackbaseSecureStorage

@MainActor
public struct RatingRequestManager {
    
    private static let lastReviewPromptDateKey = "lastReviewPromptDate"
    private let configuration: Configuration
    
    private let secureStorageInfo: SecureStorageInfo = SecureStorageFactory.createWithMigration()
    private let storage: BackbaseSecureStorage.SecureStorage
    
    init(configuration: Configuration) {
        self.configuration = configuration
        storage = secureStorageInfo.storage
    }
    
    /// Request for App Store review.
    /// Checks if the configured number of months has been passed since the last prompt
    public func requestReviewIfAppropriate() {
        guard shouldRequestReview(lastPromptDate: loadLastPromptDate(), config: configuration) else {
            return
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) else {
            return
        }
        
        if #available(iOS 18.0, *) {
            AppStore.requestReview(in: windowScene)
        } else {
            SKStoreReviewController.requestReview(in: windowScene)
        }
        
        updateLastPromptDate()
    }
    
    /// Determine if the required frequency has been respected since the last prompt
    func shouldRequestReview(lastPromptDate: Date?, config: Configuration) -> Bool {
        let now = Date()
        
        guard let lastPromptDate = lastPromptDate else {
            return true
        }
        
        let monthsSinceLastPrompt = Calendar.current.dateComponents([.month], from: lastPromptDate, to: now).month ?? 0
        
        return monthsSinceLastPrompt >= configuration.frequencyInMonths
    }
    
    /// Write the last prompted date to the Secure Storage
    private func updateLastPromptDate() {
        let dateString = iso8601String(from: Date())
        storage.storeValue(dateString, forKey: Self.lastReviewPromptDateKey)
    }
    
    /// Read the last prompted date from the Secure Storage
    private func loadLastPromptDate() -> Date? {
        do {
            let dateString = try storage.readValue(forKey: Self.lastReviewPromptDateKey).get()
            return iso8601Date(from: dateString)
        } catch {
            return nil
        }
    }
}

// MARK: Utility helper methods
extension RatingRequestManager {
    
    // Converts a Date into a string
    func iso8601String(from date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: date)
    }
    
    //Converts a String into a date
    func iso8601Date(from string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
}
