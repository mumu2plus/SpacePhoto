//
//  ViewController.swift
//  SpacePhoto
//
//  Created by 加加林 on 2019/1/27.
//  Copyright © 2019 mumu2plus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var spaceImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoinfoController = PhotoInfoController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        self.title = "title"
        
        photoinfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
               self.updateUI(with: photoInfo)
            }
        }
    }

    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.spaceImage.image = image
                    self.descriptionLabel.text = photoInfo.description
                    
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                }
            }
        }
        task.resume()
    }

}

