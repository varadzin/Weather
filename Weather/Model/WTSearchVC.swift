//
//  WTSearchVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTSearchVC: UIViewController {
    
    var searchTextField = UITextField()
    var searchButton = UIButton()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
    }
    
}
