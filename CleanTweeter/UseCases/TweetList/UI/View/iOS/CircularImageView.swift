//
//  CircularImageView.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.01.16.
//  Copyright © 2016 Markus Müller. All rights reserved.
//

import UIKit

@IBDesignable class CircularImageView: UIView {
	@IBInspectable var image: UIImage? {
		didSet {
			self.layer.masksToBounds = true;
			self.layer.contents = image?.cgImage
			self.layer.contentsGravity = CALayerContentsGravity.resizeAspectFill
		}
	}
	override var frame: CGRect {
		didSet {
			layer.cornerRadius = frame.width/2
			layer.masksToBounds = layer.cornerRadius > 0
		}
	}
	@IBInspectable var borderWidth: CGFloat = 0 {
		didSet {
			layer.borderWidth = borderWidth
		}
	}
	@IBInspectable var borderColor: UIColor? {
		didSet {
			layer.borderColor = borderColor?.cgColor
		}
	}
}
