//
//  TrackListViewController.swift
//  CS map
//
//  Created by Аркадий Торвальдс on 17.07.2022.
//

import UIKit

class TrackListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let buttonClose = UIButton()
        buttonClose.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeTLVC), for: .touchUpInside)
        view.addSubview(buttonClose)
        buttonClose.snp.makeConstraints{maker in
            maker.left.top.equalTo(5)
        }

    }
    
    @objc func closeTLVC() {
        self.dismiss(animated: true, completion: {})
    }
    
}
