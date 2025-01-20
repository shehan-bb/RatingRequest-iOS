//
//  Configuration.swift
//  RateAndReview
//
//  Created by Shehan Gunarathne on 17/01/2025.
//

public extension RatingRequestManager {
    /// RatingRequestManager configurations
    struct Configuration {
        /// Custom frequency set by the bank to show the prompt - Every X months
        /// default value is 3 months
        public var frequencyInMonths: Int
        
        public init(frequencyInMonths: Int = 3) {
            self.frequencyInMonths = frequencyInMonths
        }
    }
    
    /// Entry point to the RatingRequestManager
    static func build(with frequencyInMonths: Int = 3) -> RatingRequestManager {
        let configuration = Configuration(frequencyInMonths: frequencyInMonths)
        
        return RatingRequestManager(configuration: configuration)
    }
}
