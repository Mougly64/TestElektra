//
//  TvShowVC.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import UIKit


class TvShowVC: UIViewController {
    @IBOutlet weak var tvShowTableView: UITableView!
    @IBOutlet weak var activityIndicatorShows: UIActivityIndicatorView!
    
    private var showsList: [TvShow]? = nil
    
    /// this method is launched when the viewController is shown for first time
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowTableView.delegate = self
        tvShowTableView.dataSource = self
        tvShowTableView.sectionHeaderHeight = 70
        tvShowTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "showsCustomCell")
        
        activityIndicatorShows.startAnimating()
        activityIndicatorShows.hidesWhenStopped = true
        fetchData()
    }
    
    /// this method is who fetch the data from the database and reload the tableview
    func fetchData() {
        do {
            TvShowProvider.shared.getAllShows { tvShows in
                self.showsList = tvShows
                DispatchQueue.main.async {
                    self.tvShowTableView.reloadData()
                    self.activityIndicatorShows.stopAnimating()
                }
            } failure: { error in
                let alert = UIAlertController(title: "¡Oops, algo salio mal!", message: "Ocurri  un error al consultar el servicio.  ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Si", style: .default))
                alert.addAction(UIAlertAction(title: "No", style: .cancel))
                
                self.present(alert, animated: true, completion: nil)
                print(error as Any)
            }
        }
    }
}

@available(iOS 11.0, *)
extension TvShowVC: UITableViewDataSource{
    
    /// this method return the name header for the tableview
    /// - Parameters:
    ///   - tableView: tableview
    ///   - section: number of section
    /// - Returns: title of header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of TvShows"
    }
    
    /// this method return the number of elements that the viewtable contain
    /// - Parameters:
    ///   - tableView: tableview from the storyboard
    ///   - section: number of sections if contain more than one
    /// - Returns: number of elemnts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let showsList = showsList {
            return showsList.count
        } else {
            return 0
        }
    }
    
    /// this method rill the information in every row and create a custome cell
    /// - Parameters:
    ///   - tableView: table view from the storyboard
    ///   - indexPath: index path
    /// - Returns: custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "showsCustomCell", for: indexPath) as? CustomTableViewCell
        
        cell?.titleLbl.text = showsList![indexPath.row].name
        let url = showsList![indexPath.row].image!["medium"]!
        cell?.showImage.load(url: URL(string: url)!)
        
        return cell!
    }
    
    /// this methos make the swip left on the row from the story board
    /// - Parameters:
    ///   - tableView: tableview
    ///   - indexPath: indexpath from the row selected
    /// - Returns: action swipe configuration
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addFavorite = UIContextualAction(style: .normal, title: "Favorite") { action, view , completationHandler in
            let tv = self.showsList![indexPath.row]
            if #available(iOS 13.0, *) {
                let result = DataBaseHelper.sharedInstance.saveShow(show: tv)
                if !result {
                    let alert = UIAlertController(title: "¡Oops, algo salio mal!", message: "Hubo un problema al guardar/borrar este show de TV. ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Si", style: .default))
                    alert.addAction(UIAlertAction(title: "No", style: .cancel))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                // Fallback on earlier versions
            }
        }
        addFavorite.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [addFavorite])
    }
}

extension TvShowVC: UITableViewDelegate {
}
