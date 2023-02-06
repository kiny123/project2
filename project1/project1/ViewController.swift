//
//  ViewController.swift
//  project1
//
//  Created by nikita on 07.12.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var imageCount = [UserCustomDefults]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fileManage), with: nil)
    }
    
    @objc func fileManage() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try? fm.contentsOfDirectory(atPath: path)
        
        for item in items! {
            if item.hasPrefix("nssl") {
                // find picture to load
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let currentCount = UserDefaults.standard.integer(forKey: pictures[indexPath.row])
        cell.detailTextLabel?.text = String(currentCount)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            guard let selectedImage = vc.selectedImage else { return }
            let curentImageCount = UserDefaults.standard.integer(forKey: selectedImage)
            let currentCount = curentImageCount + 1
            UserDefaults.standard.set(currentCount, forKey: selectedImage)
            
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

