//
//  ViewController.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getAllShowsBtnAction(_ sender: Any) {
        TvShowProvider.shared.getAllShows { tvShow in
            _ = tvShow
        } failure: { error in
            print(error.debugDescription)
        }
    }
    
    @IBAction func getAShowBtnActon(_ sender: Any) {
        TvShowProvider.shared.getAShow { tvShow in
            print("Aqui el objeto:")
            print(tvShow)
        } failure: { error in
            print(error.debugDescription)
        }

    }
    
}

