//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 28/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class BaseViewController: UIViewController {
  let activityIndicator = MDCActivityIndicator()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoader()
    }
    
    func setUpLoader(){
        activityIndicator.sizeToFit()
        self.view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.superview?.bringSubviewToFront(activityIndicator)
        overrideUserInterfaceStyle = .light
    }
    
    
    func hideLoader()  {
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        }
    }
    
    func showLoader()  {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
