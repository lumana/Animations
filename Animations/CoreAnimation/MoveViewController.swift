//
//  MoveViewController.swift
//  Animations
//
//  Created by Luis Umaña on 15/6/23.
//

import UIKit

class MoveViewController: UIViewController {

    let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    let moveButton = makeButton(withText: "Move")
    let scaleButton = makeButton(withText: "Escale")
    let rotateButton = makeButton(withText: "Rotate")
    let shakeButton = makeButton(withText: "Shake")
    
    let blueView = UIView()
    let _width: CGFloat = 40
    let _height: CGFloat = 40
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300
    let animateButton = makeButton(withText: "Animate")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
        blueView.backgroundColor = .blue
        
        moveButton.translatesAutoresizingMaskIntoConstraints = false
        moveButton.addTarget(self, action: #selector(moveButtonTapped(_:)), for: .primaryActionTriggered)
        
        scaleButton.translatesAutoresizingMaskIntoConstraints = false
        scaleButton.addTarget(self, action: #selector(scaleButtonTapped(_:)), for: .primaryActionTriggered)
        
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped(_:)), for: .primaryActionTriggered)
        
        shakeButton.translatesAutoresizingMaskIntoConstraints = false
        shakeButton.addTarget(self, action: #selector(shakeButtonTapped(_:)), for: .primaryActionTriggered)
        
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        animateButton.addTarget(self, action: #selector(animateButtonTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(redView)
        view.addSubview(moveButton)
        view.addSubview(scaleButton)
        view.addSubview(rotateButton)
        view.addSubview(shakeButton)
        
        view.addSubview(blueView)
        view.addSubview(redCircle)
        view.addSubview(animateButton)
        
        NSLayoutConstraint.activate([

            moveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            moveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            scaleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            scaleButton.leadingAnchor.constraint(equalTo: moveButton.trailingAnchor, constant: 8),
            
            rotateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            rotateButton.leadingAnchor.constraint(equalTo: scaleButton.trailingAnchor, constant: 8),
            
            shakeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            shakeButton.leadingAnchor.constraint(equalTo: rotateButton.trailingAnchor, constant: 8),
            
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            animateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // draw box
            blueView.frame = CGRect(x: view.bounds.midX - _width/2,
                                   y: view.bounds.midY - _height/2,
                                   width: _width, height: _height)

            // draw circle
            redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                                   y: view.bounds.midY - _diameter/2,
                                   width: _diameter, height: _diameter)

            let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))

            let img = renderer.image { ctx in
                let rectangle = CGRect(x: 0, y: 0, width: _diameter, height: _diameter)

                ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
                ctx.cgContext.setFillColor(UIColor.clear.cgColor)
                ctx.cgContext.setLineWidth(1)
                ctx.cgContext.addEllipse(in: rectangle)
                ctx.cgContext.drawPath(using: .fillStroke)
            }

            redCircle.image = img
        }

    @objc func moveButtonTapped(_ sender: UIButton) {
        moveAnimation()
    }
    
    @objc func scaleButtonTapped(_ sender: UIButton) {
        scaleAnimation()
    }
    
    @objc func rotateButtonTapped(_ sender: UIButton) {
        rotateAnimation()
    }
    
    @objc func shakeButtonTapped(_ sender: UIButton) {
        shakeAnimation()
    }
    
    @objc func animateButtonTapped(_ sender: UIButton) {
        circleAnimation()
    }
    
    func moveAnimation() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2) // update to final position
    }
    
    func scaleAnimation() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 3
        animation.duration = 1
            
        redView.layer.add(animation, forKey: "basic")
        //redView.layer.transform = CATransform3DMakeScale(2, 2, 1) // update
    }
    
    func rotateAnimation() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z" // Note: z-axis
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4
        animation.duration = 1
            
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
    }
    
    func shakeAnimation() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        redView.layer.add(animation, forKey: "shake")
            
        //redView.layer.add(animation, forKey: "basic")
        //redView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
    }
    
    func circleAnimation() {
            
        let boundingRect = CGRect(x: -_diameter/2, y: -_diameter/2, width: _diameter, height: _diameter)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        
        orbit.duration = 2
        orbit.isAdditive = true
//        orbit.repeatCount = HUGE
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        blueView.layer.add(orbit, forKey: "redbox")
    }
}

// MARK: - Factories

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}
