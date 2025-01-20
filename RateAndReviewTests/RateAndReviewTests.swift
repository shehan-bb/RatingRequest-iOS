//
//  RateAndReviewTests.swift
//  RateAndReviewTests
//
//  Created by Shehan Gunarathne on 07/01/2025.
//

import XCTest
@testable import RateAndReview

@MainActor
final class RatingRequestManagerTests: XCTestCase {

    func testShouldRequestReview_noStoredDate() async throws {
        // Given
        let lastPromptDate: Date? = nil
        let config = RatingRequestManager.Configuration(frequencyInMonths: 3)
        let manager = RatingRequestManager(configuration: config)
        
        // When
        let result = manager.shouldRequestReview(lastPromptDate: lastPromptDate, config: config)
        
        // Then
        XCTAssertTrue(result, "Not requested review previously, should request review")
    }

    func testShouldReqeustReview_validTimePeriodPassed() {
        // Given
        let lastPromptDate: Date? = Calendar.current.date(byAdding: .month, value: -4, to: Date())
        let config = RatingRequestManager.Configuration(frequencyInMonths: 3)
        let manager = RatingRequestManager(configuration: config)
        
        // When
        let result = manager.shouldRequestReview(lastPromptDate: lastPromptDate, config: config)
        
        // Then
        XCTAssertTrue(result, "Requested review four months a go, should request review")
    }
    
    func testShouldReqeustReview_notEnoughTimePeriodPassed() {
        // Given
        let lastPromptDate: Date? = Calendar.current.date(byAdding: .month, value: -2, to: Date())
        let config = RatingRequestManager.Configuration(frequencyInMonths: 3)
        let manager = RatingRequestManager(configuration: config)
        
        // When
        let result = manager.shouldRequestReview(lastPromptDate: lastPromptDate, config: config)
        
        // Then
        XCTAssertFalse(result, "Requested review two months a go, should not request a review")
    }
}
