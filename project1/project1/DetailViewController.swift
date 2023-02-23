//
//  DetailViewController.swift
//  project1
//
//  Created by nikita on 07.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    var imageCount = UserCustomDefults(imageViewCount: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(selectedImage != nil)
        
        title = "\(selectedPictureNumber)/\(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        

        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "imageCount") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                imageCount = try jsonDecoder.decode(UserCustomDefults.self, from: savedPeople)
            } catch {
                print("Failed to count")
            }
        }
        
        
        count()
        print("\(imageCount)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false 
    }
    
    func count() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(imageCount) {
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "imageCount")
            } else {
                print("Failed to save count of photos.")
            }
    }

}
