//
//  LaunchViewController.swift
//  Sports App
//
//  Created by Radwa on 27/04/2022.
//

import UIKit
import Lottie
class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView()
        animationView.animation = Animation.named("animation")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
       
        animationView.play()
        view.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else {return}
            let view = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(view, animated: true)
        }

       
    }
    

  

}
