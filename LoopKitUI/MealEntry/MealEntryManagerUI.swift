//
//  MealEntryManagerUI.swift
//  LoopKitUI
//
//  Copyright © 2026 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKit

public struct MealEntryManagerDescriptor {
    public let identifier: String
    public let localizedTitle: String

    public init(identifier: String, localizedTitle: String) {
        self.identifier = identifier
        self.localizedTitle = localizedTitle
    }
}

public typealias MealEntryViewController = (UIViewController & CompletionNotifying)

/// The UI layer of a meal-entry plugin. Mirrors `ServiceUI`: it vends the plugin's own meal-entry UI.
public protocol MealEntryManagerUI: MealEntryManager {
    /// The image for this type of meal-entry plugin.
    static var image: UIImage? { get }

    /// Create and onboard a new meal-entry manager.
    ///
    /// - Parameters:
    ///     - colorPalette: Color palette to use for any UI.
    ///     - pluginHost: Object that provides name and version information about the host to the plugin.
    /// - Returns: Either a conforming view controller to create and onboard the manager, or a newly created and onboarded manager.
    static func setupViewController(colorPalette: LoopUIColorPalette, pluginHost: PluginHost) -> SetupUIResult<MealEntryViewController, MealEntryManagerUI>

    /// The meal-entry flow UI.
    ///
    /// The returned view controller drives the user through assembling a meal. It reports the completed meal via the
    /// manager's `mealEntryManagerDelegate` and notifies dismissal via its `completionDelegate`.
    ///
    /// - Parameters:
    ///     - colorPalette: Color palette to use for any UI.
    /// - Returns: A view controller presenting the meal-entry flow.
    func mealEntryViewController(colorPalette: LoopUIColorPalette) -> MealEntryViewController
}

public extension MealEntryManagerUI {
    var image: UIImage? { return type(of: self).image }
}
