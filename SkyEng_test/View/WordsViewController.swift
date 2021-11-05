//
//  WordsViewController.swift
//  SkyEng_test
//
//  Created by Dima Loria on 30.10.2021.
//

import UIKit

class WordsViewController: UIViewController {
    
    var delegate: ViewControllerDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        
        view.backgroundColor = .gray
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        let controller = ViewController()
        controller.delegate = self
    }
}

extension WordsViewController: ViewControllerDelegate {
    func update(with title: String) {
        titleLabel.text = title
    }
}
