//
//  Extension.swift
//  WWTouchEffectButton
//
//  Created by William.Weng on 2024/7/17.
//

import UIKit

// MARK: - CGPath (function)
extension CGPath {
    
    /// 建立圓形(弧)路徑
    /// - View的半徑
    /// - Parameters:
    ///   - center: 中點
    ///   - radius: 半徑
    ///   - startAngle: 開始的角度
    ///   - endAngle: 結束的角度
    ///   - clockwise: 順時針 / 逆時針
    /// - Returns: CGMutablePath
    static func _circlePath(center: CGPoint, radius: CGFloat, from startAngle: CGFloat = .zero, to endAngle: CGFloat = .pi, clockwise: Bool = false) -> CGMutablePath {

        let path = CGMutablePath()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

// MARK: - CALayer (static function)
extension CALayer {
    
    /// Layer產生器
    /// - 含路徑 + 相關設定
    /// - Parameters:
    ///   - path: 繪圖的路徑
    ///   - strokeColor: 線的顏色
    ///   - fillColor: 背景色
    ///   - lineWidth: 線寬
    /// - Returns: CAShapeLayer
    static func _shape(path: CGPath?, strokeColor: UIColor? = .black, fillColor: UIColor? = nil, lineWidth: CGFloat = 10) -> CAShapeLayer {
        
        let layer = CAShapeLayer()

        layer.path = path
        layer.lineWidth = lineWidth
        layer.strokeColor = strokeColor?.cgColor
        layer.fillColor = fillColor?.cgColor

        return layer
    }
}

// MARK: - CALayer (function)
extension CALayer {
    
    /// [設定圓角](https://www.appcoda.com.tw/calayer-introduction/)
    /// - [可以個別設定要哪幾個角 / 預設是四個角全是圓角](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/讓-view-變圓角的-layer-cornerradius-54aa7afda2a1)
    /// - Parameters:
    ///   - radius: 圓的半徑
    ///   - masksToBounds: Bool
    ///   - corners: 圓角要哪幾個邊
    func _maskedCorners(radius: CGFloat, masksToBounds: Bool = true, corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.masksToBounds = masksToBounds
        self.maskedCorners = corners
        self.cornerRadius = radius
    }
}

// MARK: - CAAnimation (static function)
extension CAAnimation {
    
    /// [Layer動畫產生器 (CABasicAnimation)](https://jjeremy-xue.medium.com/swift-說說-cabasicanimation-9be31ee3eae0)
    /// - Parameters:
    ///   - keyPath: [要產生的動畫key值](https://blog.csdn.net/iosevanhuang/article/details/14488239)
    ///   - delegate: [CAAnimationDelegate?](https://juejin.cn/post/6936070813648945165)
    ///   - fromValue: 開始的值
    ///   - toValue: 結束的值
    ///   - duration: 動畫時間
    ///   - repeatCount: 播放次數
    ///   - fillMode: [CAMediaTimingFillMode](https://juejin.cn/post/6991371790245183496)
    ///   - isRemovedOnCompletion: Bool
    /// - Returns: Constant.CAAnimationInformation
    static func _basicAnimation(keyPath: Constant.AnimationKeyPath = .strokeEnd, delegate: CAAnimationDelegate? = nil, fromValue: Any?, toValue: Any?, duration: CFTimeInterval = 5.0, repeatCount: Float = 1.0, fillMode: CAMediaTimingFillMode = .forwards, isRemovedOnCompletion: Bool = false) -> Constant.BasicAnimationInformation {
        
        let animation = CABasicAnimation(keyPath: keyPath.rawValue)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        animation.delegate = delegate
        
        return (animation, keyPath)
    }
}

// MARK: - CAAnimationGroup (function)
extension CAAnimationGroup {
    
    /// 建立CAAnimationGroup
    /// - Parameters:
    ///   - animations: [CAAnimation]?
    ///   - delegate: CAAnimationDelegate?
    ///   - duration: CFTimeInterval
    ///   - isAutoreverses: Bool
    ///   - timingFunctionName: CAMediaTimingFunctionName
    ///   - repeatCount: Float
    /// - Returns: CAAnimationGroup
    static func _build(animations: [CAAnimation]?, delegate: CAAnimationDelegate? = nil, duration: CFTimeInterval, isAutoreverses: Bool = false, timingFunctionName: CAMediaTimingFunctionName = .linear, repeatCount: Float = 1.0) -> CAAnimationGroup {
        
        let group = CAAnimationGroup()
        
        group.animations = animations
        group.duration = duration
        group.autoreverses = isAutoreverses
        group.repeatCount = repeatCount
        group.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        group.delegate = delegate
        
        return group
    }
}
