//
//  ViewController.swift
//  Freedom Project
//
//  Created by Dinmukhamed Arystanbekov on 11/9/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var specTextField: UITextField!
    @IBOutlet weak var requirementTextField: UITextField!
    @IBOutlet weak var requirementsCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var requirementsArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViews()
    }
    
    func configureViews(){
        requirementsCollectionView.delegate = self
        requirementsCollectionView.dataSource = self
        
        searchButton.layer.cornerRadius = 12.0
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
        
        addButton.layer.cornerRadius = 6.0
        addButton.layer.borderWidth = 1.0
        addButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    

    @IBAction func addRequirement(_ sender: Any) {
        requirementsArray.append(requirementTextField.text!)
        requirementsCollectionView.reloadData()
    }
    
    @IBAction func search(_ sender: Any) {
        let dataViewController = storyboard?.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        dataViewController.spec = specTextField.text!
        dataViewController.prompt = promptContstructor()
        print(promptContstructor())
        navigationController?.show(dataViewController, sender: self)
    }
    
    func promptContstructor() -> String {
        var text = specTextField.text!
        
        for item in requirementsArray{
            text += ", " + item
        }
        
        return text
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requirementsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequirementCell", for: indexPath)
        
        let view = cell.viewWithTag(1000)!
        view.layer.cornerRadius = 6.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = requirementsArray[indexPath.row]
        
        return cell
    }
}

