//
//  DetailsShowVC.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import UIKit

class DetailsShowVC: UIViewController {

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var openLinkBtn: UIButton!
    
    public var showDetail: ShowTv? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = showDetail?.name
        descriptionText.text = showDetail?.summary
        showImage.load(url: URL(string: (showDetail?.image)!)!)
        
        if showDetail?.imdb == "" || showDetail?.imdb == nil {
            openLinkBtn.isHidden = true
        }
        
    }
    
    @IBAction func openLinkActionBtn(_ sender: Any) {
        if let imdb = showDetail?.imdb {
            let urlImdb = "\(Constants.imdbBase)\(imdb)"
            UIApplication.shared.openURL(URL(string: urlImdb)!)
        } else {
            let alert = UIAlertController(title: "Error", message: "Ocurrio un error al obtener la url", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
    }
}
