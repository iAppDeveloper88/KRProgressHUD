//
//  KRProgressHUD.swift
//  KRProgressHUD
//
//  Copyright © 2016 Krimpedance. All rights reserved.
//

import UIKit
import KRActivityIndicatorView

/// KRProgressHUD is a beautiful and easy-to-use progress HUD.
public final class KRProgressHUD: KRProgressHUDInstance {

    static let shared = KRProgressHUD()

    private override init() {
        super.init()
    }
}

// MARK: - Set styles --------------------------

extension KRProgressHUD {
    /// Returns the appearance proxy for the receiver.
    ///
    /// - Returns: The appearance proxy for the receiver.
    public static func appearance() -> KRProgressHUDAppearance {
        return shared.viewAppearance
    }

    /// Sets the HUD style.
    /// This value is cleared by `resetStyles()`.
    ///
    /// - Parameter style: KRProgressHUDStyle
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(style: KRProgressHUDStyle) -> KRProgressHUD.Type {
        shared.style = style
        return KRProgressHUD.self
    }

    /// Sets the HUD mask type.
    /// This value is cleared by `resetStyles()`.
    ///
    /// - Parameter maskType: KRProgressHUDMaskType
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(maskType: KRProgressHUDMaskType) -> KRProgressHUD.Type {
        shared.maskType = maskType
        return KRProgressHUD.self
    }

    /// Sets the KRActivityIndicatorView gradient colors.
    /// This value is cleared by `resetStyles()`.
    ///
    /// - Parameter colors: KRActivityIndicatorViewStyle
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(activityIndicatorViewColors colors: [UIColor]) -> KRProgressHUD.Type {
        shared.activityIndicatorColors = colors
        return KRProgressHUD.self
    }

    /// Sets the HUD message label font.
    /// This value is cleared by `resetStyles()`.
    ///
    /// - Parameter font: The message label font.
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(font: UIFont) -> KRProgressHUD.Type {
        shared.font = font
        return KRProgressHUD.self
    }

    /// Sets the HUD center offset of y axis.
    /// This value is cleared by `resetStyles()`.
    ///
    /// - Parameter offset: The HUD center offset of y axis.
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(viewOffset offset: CGFloat) -> KRProgressHUD.Type {
        shared.viewOffset = offset
        return KRProgressHUD.self
    }

    /**

     This value is cleared by `resetStyles()`.

     - parameter time:

     - returns:
     */
    /// Sets duration to show HUD.
    ///
    /// This is used:
    /// - `showSuccess()`
    /// - `showInfo()`
    /// - `showWarning()`
    /// - `showError()`
    /// - `showImage()`
    /// - `showMessage()`
    ///
    /// - Parameter time: Deadline time.
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func set(duration: Double) -> KRProgressHUD.Type {
        shared.duration = duration
        return KRProgressHUD.self
    }

    @discardableResult public static func set(graceTime: Double) -> KRProgressHUD.Type {
        shared.graceTime = graceTime
        return KRProgressHUD.self
    }

    /// Resets the HUD styles.
    ///
    /// - Returns: KRProgressHUD.Type (discardable)
    @discardableResult public static func resetStyles() -> KRProgressHUD.Type {
        shared.style = nil
        shared.maskType = nil
        shared.activityIndicatorColors = nil
        shared.font = nil
        shared.viewOffset = nil
        shared.duration = nil
        return KRProgressHUD.self
    }

    /// Sets the view controller which presents HUD.
    /// This is applied only once.
    ///
    /// - Parameter viewController: Presenting view controller.
    /// - Returns: KRProgressHUD.Type
    public static func showOn(_ viewController: UIViewController) -> KRProgressHUD.Type {
        shared.presentingViewController = viewController
        return KRProgressHUD.self
    }

    @available(*, deprecated, message: "Use set(activityIndicatorViewColors:)")
    @discardableResult public static func set(activityIndicatorViewStyle style: KRActivityIndicatorViewStyle) -> KRProgressHUD.Type {
        shared.activityIndicatorColors = [style.headColor, style.tailColor]
        return KRProgressHUD.self
    }

    @available(*, renamed: "set(ducation:)")
    @discardableResult public static func set(deadline time: Double) -> KRProgressHUD.Type {
        shared.duration = time
        return KRProgressHUD.self
    }
}

// MARK: - Show, Update & Dismiss ------------

extension KRProgressHUD {
    /// Shows the HUD.
    /// You can appoint only the args which You want to appoint.
    ///
    /// - Parameters:
    ///   - message: HUD's message.
    ///   - completion: Handler when showing is completed.
    public static func show(withMessage message: String? = nil, completion: CompletionHandler? = nil) {
        shared.show(withMessage: message, isLoading: true, completion: completion)
    }

    /// Shows the HUD with success glyph.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameter message: HUD's message.
    public static func showSuccess(withMessage message: String? = nil) {
        shared.show(withMessage: message, iconType: .success)
    }

    /// Shows the HUD with information glyph.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameter message: HUD's message.
    public static func showInfo(withMessage message: String? = nil) {
        shared.show(withMessage: message, iconType: .info)
    }

    /// Shows the HUD with warning glyph.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameter message: HUD's message.
    public static func showWarning(withMessage message: String? = nil) {
        shared.show(withMessage: message, iconType: .warning)
    }

    /// Shows the HUD with error glyph.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameter message: HUD's message.
    public static func showError(withMessage message: String? = nil) {
        shared.show(withMessage: message, iconType: .error)
    }

    /// Shows the HUD with image.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameters:
    ///   - image: Image that display instead of activity indicator.
    ///   - size: Image size.
    ///   - message: HUD's message.
    public static func showImage(_ image: UIImage, size: CGSize? = nil, message: String? = nil) {
        shared.show(withMessage: message, image: image, imageSize: size)
    }

    /// Shows the message only HUD.
    /// The HUD dismiss after `duration` secound.
    ///
    /// - Parameter message: HUD's message.
    public static func showMessage(_ message: String) {
        shared.show(withMessage: message, isOnlyText: true)
    }

    /// Updates the HUD message.
    ///
    /// - Parameter message: Message.
    public static func update(message: String) {
        shared.messageLabel.text = message
    }

    /// Hides the HUD.
    ///
    /// - Parameter completion: Hide completion handler.
    public static func dismiss(_ completion: CompletionHandler? = nil) {
        shared.dismiss(completion: completion)
    }
}
