//
//  MealNutrition.swift
//  LoopKit
//
//  Copyright © 2026 LoopKit Authors. All rights reserved.
//

import Foundation
import HealthKit

/// A summary of the total nutrition of a meal, produced by a meal-entry plugin and handed back to the host app.
///
/// A meal-entry plugin is responsible for letting the user assemble a meal (one or more food items) and summing its
/// nutrition into this total. Today the host only consumes `carbohydrates` and `carbAbsorptionTime` — they are mapped
/// into a carb entry. The remaining macronutrient fields are reserved for future use: a plugin may sum them internally,
/// but the host does not yet act on them.
public struct MealNutrition: Equatable {
    /// The total carbohydrates in the meal.
    public let carbohydrates: HKQuantity

    /// The carb absorption time to use for the meal (e.g. selected via the fast/medium/slow food icons).
    public let carbAbsorptionTime: TimeInterval

    /// A description of the meal (emoji shortcut or free text) to persist as the food type.
    public let foodType: String?

    /// When the meal was consumed.
    public let startDate: Date

    /// Total protein in the meal, if tracked. Reserved for future use.
    public let protein: HKQuantity?

    /// Total fat in the meal, if tracked. Reserved for future use.
    public let fat: HKQuantity?

    /// Total energy in the meal, if tracked. Reserved for future use.
    public let calories: HKQuantity?

    public init(carbohydrates: HKQuantity,
                carbAbsorptionTime: TimeInterval,
                foodType: String?,
                startDate: Date,
                protein: HKQuantity? = nil,
                fat: HKQuantity? = nil,
                calories: HKQuantity? = nil) {
        self.carbohydrates = carbohydrates
        self.carbAbsorptionTime = carbAbsorptionTime
        self.foodType = foodType
        self.startDate = startDate
        self.protein = protein
        self.fat = fat
        self.calories = calories
    }
}
