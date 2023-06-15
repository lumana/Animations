//
//  ViewController.swift
//  Animations
//
//  Created by Luis Umaña on 12/6/23.
//

import UIKit

struct MenuOption {
    let title: String
    let imageName: String
    let viewController: UIViewController
}

let menuOptions = [
    MenuOption(title: "Constrain Based", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Core Animation", imageName: "arrow.forward.circle.fill", viewController: MoveViewController()),
    MenuOption(title: "Core Graphics", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Gradients", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Shadows", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Login Form Field", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Skeleton loader", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Shakey Bell", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
    MenuOption(title: "Stack Views", imageName: "arrow.forward.circle.fill", viewController: LoginViewController()),
]

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let menuCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = .init(width: 400, height: 200)
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
           return collectionView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.backgroundColor = .init(red: CGFloat(22/255.0), green: CGFloat(138/255.0), blue: CGFloat(173/255.0), alpha: 1.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.menuCollectionView.addGestureRecognizer(tap)
        self.menuCollectionView.isUserInteractionEnabled = true
       
        view.addSubview(menuCollectionView)
        
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            cell.backgroundColor = .init(red: CGFloat(181/255.0), green: CGFloat(228/255.0), blue: CGFloat(140/255.0), alpha: 1.0)
            let model = menuOptions[indexPath.row]
                    
            var listContentConfiguration = UIListContentConfiguration.cell()
            listContentConfiguration.text = model.title
            listContentConfiguration.image = UIImage(systemName: model.imageName)
            
            cell.contentConfiguration = listContentConfiguration
            return cell
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let indexPath = self.menuCollectionView.indexPathForItem(at: sender.location(in: self.menuCollectionView)) {
            
            let model = menuOptions[indexPath.row]
            
            let controller = model.viewController
            self.navigationController?.pushViewController(controller, animated:false)
           
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let controller =  LoginViewController()
        //Add the storyboard identifier of your view controller - "DetailController"
        //let controller =  self.storyboard.instantiateViewController(withIdentifier: //"DetailController") as! DetailController
        self.navigationController?.pushViewController(controller, animated:true)
    }
}

