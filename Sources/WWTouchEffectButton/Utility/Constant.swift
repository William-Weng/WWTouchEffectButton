//
//  Constant.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit

// MARK: - Constant
final class Constant: NSObject {}

// MARK: - typealias
extension Constant {
    
    typealias BasicAnimationInformation = (animation: CABasicAnimation, keyPath: Constant.AnimationKeyPath) // Basic動畫資訊
}

// MARK: - enum
extension Constant {
    
    /// [動畫路徑 (KeyPath)](https://stackoverflow.com/questions/44230796/what-is-the-full-keypath-list-for-cabasicanimation)
    enum AnimationKeyPath: String {
        
        case strokeEnd = "strokeEnd"
        case position = "position"
        case locations = "locations"
        case bounds = "bounds"
        case width = "bounds.size.width"
        case height = "bounds.size.height"
        case contents = "contents"
        case opacity = "opacity"
        case backgroundColor = "backgroundColor"
        case scale = "transform.scale"
        case scaleXY = "transform.scale.xy"
        case translationX = "transform.translation.x"
        case translationY = "transform.translation.y"
        case translationZ = "transform.translation.z"
        case rotationX = "transform.rotation.x"
        case rotationY = "transform.rotation.y"
        case rotationZ = "transform.rotation.z"
        case centerX = "center.x"
        case centerY = "center.y"
        case shimmer = "shimmer"
        case selectionBounds = "SelectionBounds"
    }
}
