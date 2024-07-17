//
//  WWTouchEffectButton.swift
//  WWTouchEffectButton
//
//  Created by William.Weng on 2024/7/17.
//

import UIKit

// MARK: - WWTouchEffectButton
open class WWTouchEffectButton: UIButton {
    
    @IBInspectable public var fromColor: UIColor = .white   // 點擊時顯示的顏色
    @IBInspectable public var toColor: UIColor = .blue      // 點擊後續示的顏色
    @IBInspectable public var duration = 0.5                // 動畫時間
    
    public weak var delegate: WWTouchEffectButtonDelegate?
    
    private var originalBackgroundColor: UIColor?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSetting()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetting()
    }
}

// MARK: - @objc
extension WWTouchEffectButton {
    
    /// 在按鍵內部TouchUp
    /// - Parameter sender: WWTouchEffectButton
    @objc func touchUpInsideAction(_ sender: WWTouchEffectButton) {
        delegate?.touch(self, event: .touchUpInside)
    }
    
    /// 在按鍵外部TouchUp
    /// - Parameter sender: WWTouchEffectButton
    @objc func touchUpOutsideAction(_ sender: WWTouchEffectButton) {
        delegate?.touch(self, event: .touchUpOutside)
    }
    
    /// 點下時的動作
    /// - Parameter sender: WWTouchEffectButton
    @objc func touchDownAction(_ sender: WWTouchEffectButton) {
        touchDownAnimation(sender)
        delegate?.touch(self, event: .touchDown)
    }
    
    /// 長按的動作
    /// - Parameter gesture: UILongPressGestureRecognizer
    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        subLayerColor(longPress: gesture)
        delegate?.longPress(self, state: gesture.state)
    }
}

// MARK: - CAAnimationDelegate
extension WWTouchEffectButton: CAAnimationDelegate {}
public extension WWTouchEffectButton {
    
    func animationDidStart(_ anim: CAAnimation) {}
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDidStopAction(anim, finished: flag)
    }
}

// MARK: - 小工具
private extension WWTouchEffectButton {
    
    /// [初始化功能設定](https://medium.com/彼得潘的-swift-ios-app-開發教室/22-xcode-用uibezierpath畫圓形-矩形-圓角矩形-5188394ff4b2)
    func initSetting() {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressAction(_:)))
        
        originalBackgroundColor = self.backgroundColor
        clipsToBounds = true
        addGestureRecognizer(longPress)
        
        addTarget(self, action: #selector(Self.touchDownAction(_:)), for: .touchDown)
        addTarget(self, action: #selector(Self.touchUpInsideAction(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(Self.touchUpOutsideAction(_:)), for: .touchUpOutside)
    }
    
    /// [產生點擊動畫的Layer](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/ios-15-更容易客製的-uibutton-plain-gray-tinted-filled-四種樣式-1616e21965e3)
    /// - Returns: SubLayer
    func subLayerMaker() -> SubLayer {
        
        let layer = SubLayer()
        
        layer.backgroundColor = toColor.cgColor
        layer.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: bounds.height))
        layer._maskedCorners(radius: bounds.height * 0.5)
        
        return layer
    }
    
    /// [SubLayer動畫完成後的動作 (把SubLayer清掉)](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/ios-15-自動更新選取狀態的-toggle-button-b748ff6b3fb1)
    /// - Parameters:
    ///   - anim: CAAnimation
    ///   - isFinished: Bool
    func animationDidStopAction(_ anim: CAAnimation, finished isFinished: Bool) {
        
        if (isFinished) {
            let subLayers = layer.sublayers?.filter { $0 is SubLayer }
            subLayers?.first?.removeFromSuperlayer()
        }
    }
    
    /// [按下產生的動畫](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/ios-的選單-menu-按鈕-pull-down-button-pop-up-button-2ddab2181ee5)
    /// - Parameter sender: WWTouchEffectButton
    func touchDownAnimation(_ sender: WWTouchEffectButton) {
        
        let subLayer = subLayerMaker()
        let scaleInfo = CAAnimation._basicAnimation(keyPath: .width, fromValue: bounds.width * 0.25, toValue: bounds.width + bounds.height * 0.5, duration: duration)
        let backgroundColorInfo = CAAnimation._basicAnimation(keyPath: .backgroundColor, fromValue: fromColor.cgColor, toValue: toColor.cgColor, duration: duration)
        let animationGroup = CAAnimationGroup._build(animations: [scaleInfo.animation, backgroundColorInfo.animation], duration: duration)
        
        layer.addSublayer(subLayer)
        subLayer.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        subLayer.add(animationGroup, forKey: "scaleAndBackgroundColor")
    }
    
    /// [設定長按動作的顏色](https://jjeremy-xue.medium.com/初入-layer-calayer-58499a414e9a)
    /// - Parameter longPress: UILongPressGestureRecognizer
    func subLayerColor(longPress: UILongPressGestureRecognizer) {
        
        switch longPress.state {
        case .began: layer.backgroundColor = toColor.withAlphaComponent(0.7).cgColor
        case .ended, .cancelled, .failed: layer.backgroundColor = originalBackgroundColor?.cgColor
        case .changed, .possible: break
        @unknown default: break
        }
    }
}
