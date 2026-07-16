//
//  MealEntryManager.swift
//  LoopKit
//
//  Copyright © 2026 LoopKit Authors. All rights reserved.
//

import Foundation

public protocol MealEntryManagerDelegate: AnyObject {
    /// The host's configured default carb absorption times (fast/medium/slow), used to seed the meal-entry UI.
    var defaultAbsorptionTimes: CarbStore.DefaultAbsorptionTimes { get }

    /// Informs the delegate that the user completed a meal. The host is responsible for acting on the nutrition
    /// summary (e.g. creating a carb entry and continuing to bolus).
    ///
    /// - Parameters:
    ///     - manager: The manager that produced the meal.
    ///     - nutrition: The total nutrition of the completed meal.
    func mealEntryManager(_ manager: MealEntryManager, didCompleteWith nutrition: MealNutrition)

    /// Informs the delegate that the user cancelled meal entry without completing a meal.
    ///
    /// - Parameters:
    ///     - manager: The manager whose meal entry was cancelled.
    func mealEntryManagerDidCancel(_ manager: MealEntryManager)

    /// Informs the delegate that the manager updated its state and should be persisted.
    ///
    /// - Parameters:
    ///     - manager: The manager that updated state.
    func mealEntryManagerDidUpdateState(_ manager: MealEntryManager)
}

/// The business-logic layer of a meal-entry plugin. Mirrors `Service`: a lightweight, stateful plugin (not a device).
///
/// A meal-entry manager vends its own UI (see `MealEntryManagerUI` in LoopKitUI), lets the user assemble a meal, sums
/// its nutrition, and reports the total back to the host via `mealEntryManagerDelegate`.
public protocol MealEntryManager: StatefulPluggable {
    /// The localized title of this type of plugin.
    static var localizedTitle: String { get }

    var mealEntryManagerDelegate: MealEntryManagerDelegate? { get set }

    /// Restore meal-entry state from a user activity (e.g. a Siri shortcut or missed-meal notification) before the UI
    /// is vended. Plugins that do not support activity restoration may ignore this.
    ///
    /// - Parameters:
    ///     - activity: The user activity to restore from.
    func restoreUserActivityState(_ activity: NSUserActivity)
}

public extension MealEntryManager {
    var localizedTitle: String { type(of: self).localizedTitle }

    func restoreUserActivityState(_ activity: NSUserActivity) { }
}

public protocol MealEntryManagerProvider {
    var mealEntryManagerType: MealEntryManager.Type? { get }
}
