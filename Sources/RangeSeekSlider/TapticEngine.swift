//
//  TapticEngine.swift
//  RangeSeekSlider
//
//  Created by Keisuke Shoji on 2017/04/09.
//
//

import UIKit

/// Generates iOS Device vibrations by UIFeedbackGenerator.
@MainActor
open class TapticEngine {

    public static let impact = Impact()
    public static let selection = Selection()
    public static let notification = Notification()

    /// Wrapper of `UIImpactFeedbackGenerator`
    public final class Impact {

        public enum ImpactStyle {
            case light, medium, heavy
        }

        private var style: ImpactStyle = .light
        private var generator: UIImpactFeedbackGenerator?

        @MainActor
        init() {
            self.generator = Self.makeGenerator(style: .light)
        }
        
        @MainActor private static func makeGenerator(style: ImpactStyle) -> UIImpactFeedbackGenerator? {
            guard #available(iOS 10.0, *) else { return nil }

            let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
            switch style {
            case .light:  feedbackStyle = .light
            case .medium: feedbackStyle = .medium
            case .heavy:  feedbackStyle = .heavy
            }

            let generator = UIImpactFeedbackGenerator(style: feedbackStyle)
            generator.prepare()
            return generator
        }

        @MainActor private func updateGeneratorIfNeeded(_ style: ImpactStyle) {
            guard self.style != style else { return }
            generator = Self.makeGenerator(style: style)
            self.style = style
        }

        @MainActor public func feedback(_ style: ImpactStyle) {
            guard #available(iOS 10.0, *) else { return }

            updateGeneratorIfNeeded(style)
            generator?.impactOccurred()
            generator?.prepare()
        }

        @MainActor public func prepare(_ style: ImpactStyle) {
            guard #available(iOS 10.0, *) else { return }

            updateGeneratorIfNeeded(style)
            generator?.prepare()
        }
    }

    /// Wrapper of `UISelectionFeedbackGenerator`
    @MainActor
    public final class Selection {

        @MainActor private var generator: UISelectionFeedbackGenerator? = {
            guard #available(iOS 10.0, *) else { return nil }
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            return generator
        }()

        @MainActor public func feedback() {
            guard #available(iOS 10.0, *) else { return }
            generator?.selectionChanged()
            generator?.prepare()
        }

    @MainActor public func prepare() {
            guard #available(iOS 10.0, *) else { return }
            generator?.prepare()
        }
    }

    /// Wrapper of `UINotificationFeedbackGenerator`
    @MainActor
    public final class Notification {

        public enum NotificationType {
            case success, warning, error
        }

        @MainActor private var generator: UINotificationFeedbackGenerator? = {
            guard #available(iOS 10.0, *) else { return nil }
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            return generator
        }()

        @MainActor public func feedback(_ type: NotificationType) {
            guard #available(iOS 10.0, *) else { return }

            let feedbackType: UINotificationFeedbackGenerator.FeedbackType
            switch type {
            case .success: feedbackType = .success
            case .warning: feedbackType = .warning
            case .error:   feedbackType = .error
            }

            generator?.notificationOccurred(feedbackType)
            generator?.prepare()
        }

        @MainActor public func prepare() {
            guard #available(iOS 10.0, *) else { return }
            generator?.prepare()
        }
    }
}
