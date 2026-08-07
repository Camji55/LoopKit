//
//  NewFavoriteFood.swift
//  LoopKit
//
//  Created by Noah Brauner on 8/9/23.
//  Copyright © 2023 LoopKit Authors. All rights reserved.
//

import HealthKit

public struct NewFavoriteFood: FavoriteFood {
    public var name: String
    public var carbsQuantity: HKQuantity
    public var foodType: String
    public var absorptionTime: TimeInterval

    /// Optional macronutrients, used by fat/protein-aware clients.
    public var fatQuantity: HKQuantity?
    public var proteinQuantity: HKQuantity?

    public init(name: String, carbsQuantity: HKQuantity, foodType: String, absorptionTime: TimeInterval, fatQuantity: HKQuantity? = nil, proteinQuantity: HKQuantity? = nil) {
        self.name = name
        self.carbsQuantity = carbsQuantity
        self.foodType = foodType
        self.absorptionTime = absorptionTime
        self.fatQuantity = fatQuantity
        self.proteinQuantity = proteinQuantity
    }
}
