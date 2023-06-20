//
//  StartViewController.swift
//  homeTask-1.5
//
//  Created by Islam Erlan Uulu on 20/6/23.
//

import UIKit

class StartViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: 90)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.dataSource = self
        view.delegate = self
        view.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID
        )
        return view
    }()
    
    private let networkService = NetworkService()
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCharacters()
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func fetchCharacters() {
        networkService.fetchCharacters { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.characters = model
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        print(characters)
    }
}

extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.reuseID,
            for: indexPath
        ) as! CharacterCollectionViewCell
        let model = characters[indexPath.item]
        cell.display(item: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc =  SecondViewController()
        vc.ff5 = characters[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

