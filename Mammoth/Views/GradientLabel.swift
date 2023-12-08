//
//  GradientLabel.swift
//  Mammoth
//
//  Created by Benoit Nolens on 27/11/2023.
//

import UIKit

class GradientLabel: UILabel {
    public var colors: [CGColor] {
        didSet {
            self.layoutSubviews()
        }
    }
    private let startPoint: CGPoint
    private let endPoint: CGPoint
    
    init(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.bounds.size.height.isZero && !self.bounds.size.width.isZero {
            self.textColor = UIColor.gradient(colors: self.colors, startPoint: self.startPoint, endPoint: self.endPoint, bounds: self.bounds)
        }
    }
}
