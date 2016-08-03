//
//  ViewController.swift
//  Gestures
//
//  Created by Koby Samuel on 11/29/15.
//  Copyright © 2015 Koby Samuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var originalRect: CGRect!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var outputLabel: UILabel!
	
	@IBAction func foundTap(sender: AnyObject) {
		outputLabel.text = "Tapped"
	}
	
	@IBAction func foundSwipe(sender: AnyObject) {
		outputLabel.text = "Swiped"
	}
	
	@IBAction func foundPan(sender: UIPanGestureRecognizer) {
		//outputLabel.text = "Pinched"
		var feedback: String
		imageView.transform = CGAffineTransformMakeRotation(0.0)
		let translation = sender.translationInView(self.view)
		if let myView = self.view {
			imageView.center = CGPoint(x: 0.0, y: (myView.center.y / 10) + (translation.y / 10))
		}
		sender.setTranslation(originalRect.origin, inView: self.view)
		feedback = String(format: "Transformed, Scale: %1.2f, Velocity: %1.2f",
			NSStringFromCGPoint(sender.translationInView(sender.view)), NSStringFromCGPoint(sender.velocityInView(sender.view)))
		outputLabel.text = feedback
	}
	
	@IBAction func foundPress(sender: UILongPressGestureRecognizer) {
		//outputLabel.text = "Pinched"
		var feedback: String
		//imageView.transform = CGAffineTransformMakeRotation(0.0)
		feedback = "Long pressed!"
		outputLabel.text = feedback
		imageView.frame.size = CGSizeApplyAffineTransform(imageView.frame.size, CGAffineTransformMakeScale(0.5, 0.5))
	}
	
	
	@IBAction func foundPinch(sender: UIPinchGestureRecognizer) {
		//outputLabel.text = "Pinched"
		var feedback: String
		var scale: CGFloat
		scale = sender.scale
		//imageView.transform = CGAffineTransformMakeRotation(0.0)
		feedback = String(format: "Pinched, Scale: %1.2f, Velocity: %1.2f",
			Float(sender.scale), Float(sender.velocity))
		outputLabel.text = feedback
		imageView.frame = CGRectMake(self.originalRect.origin.x, originalRect.origin.y, originalRect.size.width * scale, originalRect.size.height * scale)
	}
	
	@IBAction func foundRotation(sender: UIRotationGestureRecognizer) {
		//outputLabel.text = "Rotated"
		var feedback: String
		var rotation: CGFloat
		rotation = sender.rotation
		feedback = String(format: "Rotated, Radians: %1.2f, Velocity: %1.2f",
			Float(sender.rotation), Float(sender.velocity))
		outputLabel.text = feedback
		imageView.transform = CGAffineTransformMakeRotation(rotation)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.becomeFirstResponder()
		originalRect = imageView.frame
		/*var tempImageView: UIImageView
		tempImageView = UIImageView(image: UIImage(named: "flower.png"))
		tempImageView.frame = originalRect
		view.addSubview(tempImageView)
		self.imageView = tempImageView*/
	}

	override func canBecomeFirstResponder() -> Bool {
		return true
	}
	
	override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
		if motion == UIEventSubtype.MotionShake {
			outputLabel.text = "Shaking things up!"
			imageView.transform = CGAffineTransformIdentity
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

