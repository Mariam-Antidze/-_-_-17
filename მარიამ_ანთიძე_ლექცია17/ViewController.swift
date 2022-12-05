//
//  ViewController.swift
//  მარიამ_ანთიძე_ლექცია17
//
//  Created by Mariam Antidze on 05.12.22.
//
import UIKit

class ViewController: UIViewController {
    let viewForBackground: UIView = {
        let viewForBackground = UIView()
        viewForBackground.translatesAutoresizingMaskIntoConstraints = false
        viewForBackground.backgroundColor = .systemYellow
        return viewForBackground
    }()
    let centerRedView: UIView = {
        // let centerRedView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let centerRedView = UIView()
        centerRedView.translatesAutoresizingMaskIntoConstraints = false
        centerRedView.backgroundColor = .red
        return centerRedView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewForBackground)
        view.addSubview(centerRedView)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panPerformed(sender:)))
        centerRedView.isUserInteractionEnabled = true
        centerRedView.addGestureRecognizer(panGestureRecognizer)
        addConstraints()
    }
    @objc func panPerformed( sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: sender.view)
            let changeX = (sender.view?.center.x)! + translation.x
            let changeY = (sender.view?.center.y)! + translation.y
            if changeY < viewForBackground.frame.height/2 && changeX > viewForBackground.frame.width/2 {
                playAnimation(centerRedView)
            } else if changeY < viewForBackground.frame.height/2 && changeX < viewForBackground.frame.width/2 {
                rotateAnimation(centerRedView)
            }else if changeY > viewForBackground.frame.height/2 && changeX > viewForBackground.frame.width/2 {
                shakeAnimation(centerRedView)
            } else {
                showAndHideAnimation(centerRedView)
            }
            sender.view?.center = CGPoint(x: changeX, y: changeY)
            sender.setTranslation(CGPoint.zero, in: sender.view)
        }
    }
    @objc func playAnimation(_ sender: UIView) {
        centerRedView.alpha = 1
        centerRedView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1
        )
        UIView.animate(withDuration: 1) {
            self.centerRedView.transform = .identity
        }
    }
    @objc func rotateAnimation(_ sender: UIView) {
        centerRedView.alpha = 1
        let degrees = 20.0
        sender.transform = CGAffineTransformMakeRotation(degrees * Double.pi/180)
        UIView.animate(withDuration: 1) {
            self.centerRedView.transform = .identity
        }
    }
    @objc func shakeAnimation(_ sender: UIView) {
        let myAnimation = CAKeyframeAnimation()
        myAnimation.keyPath = "position.x"
        myAnimation.values = [0,8,-8,8,0]
        myAnimation.duration = 0.6
        myAnimation.isAdditive = true
        sender.layer.add(myAnimation, forKey: "shake")
    }
    @objc  func showAndHideAnimation(_ view: UIView) {
        if view.alpha == 1 {
            view.alpha = 0
        } else {
            view.alpha = 1
        }
    }
    func addConstraints() {
        var myConstraints = [NSLayoutConstraint]()
        //add constraints
        myConstraints.append(viewForBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        myConstraints.append(viewForBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        myConstraints.append(viewForBackground.topAnchor.constraint(equalTo: view.topAnchor))
        myConstraints.append(viewForBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        myConstraints.append(centerRedView.centerXAnchor.constraint(equalTo: viewForBackground.centerXAnchor))
        myConstraints.append(centerRedView.centerYAnchor.constraint(equalTo: viewForBackground.centerYAnchor))
        myConstraints.append(centerRedView.heightAnchor.constraint(equalToConstant: 50))
        myConstraints.append(centerRedView.widthAnchor.constraint(equalToConstant: 50))
        //apply constraints
        NSLayoutConstraint.activate(myConstraints)
    }
}

