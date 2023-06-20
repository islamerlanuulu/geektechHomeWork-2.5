//
//  SecondViewController.swift
//  homeTask-1.5
//
//  Created by Islam Erlan Uulu on 20/6/23.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    public let imgview = UIImageView()
    
    public let labelName: UILabel = {
      let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize:  20)
        return label
    }()
    
    var ff5: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imgview)
        view.addSubview(labelName)
        view.backgroundColor = .white
        addConstraint()
        imgview.layer.cornerRadius = 20
        
        if let imageName = ff5?.image {
                //imgview.image = UIImage(named: imageName)
            ImageDownloader.downloadImage(with: imageName) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.imgview.image = image
                }
            }
            }
        labelName.text = ff5?.name
    }
    private func addConstraint(){
        imgview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        labelName.snp.makeConstraints { make in
            make.top.equalTo(imgview.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
    }
}
