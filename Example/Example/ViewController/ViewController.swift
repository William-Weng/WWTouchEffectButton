//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit
import WWPrint
import WWTouchEffectButton

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var myTouchEffectButton: WWTouchEffectButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTouchEffectButton.delegate = self
    }
}

// MARK: - WWTouchEffectButtonDelegate
extension ViewController: WWTouchEffectButtonDelegate {
    
    func touch(_ button: WWTouchEffectButton, event: UIControl.Event) {
        wwPrint("event => \(event)")
    }
    
    func longPress(_ button: WWTouchEffectButton, state: UIGestureRecognizer.State) {
        wwPrint("state => \(state)")
    }
}
