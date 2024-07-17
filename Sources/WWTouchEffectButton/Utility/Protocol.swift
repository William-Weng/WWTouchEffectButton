//
//  WWTouchEffectButtonDelegate.swift
//  WWTouchEffectButton
//
//  Created by William.Weng on 2024/7/17.
//

import UIKit

// MARK: - WWTouchEffectButtonDelegate
public protocol WWTouchEffectButtonDelegate: AnyObject {
    
    /// 點擊的事件
    /// - Parameters:
    ///   - button: WWTouchEffectButton
    ///   - event: UIControl.Event
    func touch(_ button: WWTouchEffectButton, event: UIControl.Event)
    
    /// 長按的狀態
    /// - Parameters:
    ///   - button: WWTouchEffectButton
    ///   - state: UIGestureRecognizer.State
    func longPress(_ button: WWTouchEffectButton, state: UIGestureRecognizer.State)
}
