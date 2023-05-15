//
//  CustomScrollView.swift
//  ScrollDisabledApplication
//
//  Created by j.lee on 2023/05/15.
//

import UIKit

class MediaView: UIView {

    var touchBeganHandler: (() -> Void)?
    var touchEndedHandler: (() -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesBegan!!!")
        touchBeganHandler?()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesEnded!!!")
        touchEndedHandler?()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesCanceled!!!")
        touchEndedHandler?()
    }
}

