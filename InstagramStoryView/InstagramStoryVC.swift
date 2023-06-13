//
//  ViewController.swift
//  InstagramStoryView
//
//  Created by Afham on 6/13/23.
//

import UIKit
import ColorKit

class InstagramStoryVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    private var backgroundGradientLayer = CAGradientLayer()
    private var timer: Timer?
    private var images: [Int] = [1,2,3,4,5]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpGradientLayer()
        self.loadRandomImageFromAsset()
        self.applyDominantColors()
        
        self.animateRandomImages()
    }
    
}

// MARK: - Private Methods
private extension InstagramStoryVC {
    func animateRandomImages() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            UIView.animate(withDuration: 0.3) {
                
                self.loadRandomImageFromAsset()
                self.applyDominantColors()
            }
        }
    }
    
    func setUpGradientLayer() {
        backgroundGradientLayer.locations = [0.0, 1.0]
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        backgroundGradientLayer.frame = self.view.bounds
        backgroundGradientLayer.zPosition = -1
        self.view.layer.addSublayer(backgroundGradientLayer)
        
    }
    
    func applyDominantColors() {
       
        guard let dominantColors = try? imageView.image?.dominantColors() else {
            return
        }
        
        if dominantColors.count > 1 {
           
            let color1 = dominantColors[0]
            let color2 = dominantColors[1]
            
            func changeGradientWithEffect() {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = .fade
                
                backgroundGradientLayer.add(transition, forKey: kCATransition)
                backgroundGradientLayer.colors = [color2.cgColor, color1.cgColor]
            }
            
            changeGradientWithEffect()
        }
    }
    
    func loadRandomImageFromAsset() {
        
        guard let imageNumber = images.randomElement() else {
            return
        }
        
        let imageNameString = String(imageNumber)
        guard let image = UIImage.init(named: imageNameString) else {
            return
        }
        
        func changeImageWithEffect() {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .fade
            
            imageView.layer.add(transition, forKey: kCATransition)
            imageView.image = image
        }
    
        
        changeImageWithEffect()
        
    }
    
}
