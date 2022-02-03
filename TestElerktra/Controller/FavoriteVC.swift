//
//  FavoriteVC.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import UIKit

@available(iOS 13.0, *)
class FavoriteVC: UIViewController {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var showsList: [ShowTv]? = nil
    private var showTv: ShowTv? = nil
    
    @IBOutlet weak var activityIndicatorFavorites: UIActivityIndicatorView!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    /// this method is launched when the viewController is shown for first time
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.sectionHeaderHeight = 60
        favoritesTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "showsCustomCell")
        
        activityIndicatorFavorites.startAnimating()
        activityIndicatorFavorites.hidesWhenStopped = true
        fetchData()
    }
    
    /// this method is launched when the viewcontroller will be appeared every time when back to the view
    /// - Parameter animated: if the will appear is anitmated
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorFavorites.startAnimating()
        activityIndicatorFavorites.hidesWhenStopped = true
        fetchData()
    }
    
    @available(iOS 13.0, *)
    /// this method is who fetch the data from the database and reload the tableview
    func fetchData() {
        do {
            self.showsList = try context.fetch(ShowTv.fetchRequest())
            DispatchQueue.main.async {
                self.activityIndicatorFavorites.stopAnimating()
                self.favoritesTableView.reloadData()
            }
        } catch {
            print("Error al recuperar datos")
        }
    }
    
    /// this method prepare to which viewcontroller do you want to go through the segue identifier
    /// - Parameters:
    ///   - segue: segue defined
    ///   - sender: object lunched by the event
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue" {
            if let destino = segue.destination as? DetailsShowVC {
                destino.showDetail = showTv
            }
        }
    }
}

@available(iOS 13.0, *)
extension FavoriteVC: UITableViewDataSource {
    
    /// this method return the name header for the tableview
    /// - Parameters:
    ///   - tableView: tableview
    ///   - section: number of section
    /// - Returns: title of header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Favorites"
    }
    
    /// this method return the number of elements that the viewtable contain
    /// - Parameters:
    ///   - tableView: tableview from the storyboard
    ///   - section: number of sections if contain more than one
    /// - Returns: number of elemnts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList!.count
    }
    
    /// this method rill the information in every row and create a custome cell
    /// - Parameters:
    ///   - tableView: table view from the storyboard
    ///   - indexPath: index path
    /// - Returns: custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "showsCustomCell") as? CustomTableViewCell
        cell?.titleLbl.text = showsList![indexPath.row].name
        cell?.showImage.load(url: URL(string: showsList![indexPath.row].image!)!)
        return cell!
    }
    
    
    /// this methos make the swip left on the row from the story board
    /// - Parameters:
    ///   - tableView: tableview
    ///   - indexPath: indexpath from the row selected
    /// - Returns: action swipe configuration
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteFavorite = UIContextualAction(style: .normal, title: "Delete") { action, view , completationHandler in
            let alert = UIAlertController(title: "Auxilio", message: "¿esta seguro de eliminar de favoritos?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                let deleteFavorite = self.showsList![indexPath.row]
                // eliminar pais
                self.context.delete(deleteFavorite)
                // guardar cambio en la info
                try! self.context.save()
                //recargar datos
                self.fetchData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
        DeleteFavorite.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [DeleteFavorite])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showTv = showsList![indexPath.row]
        performSegue(withIdentifier: "showDetailsSegue", sender: self)
    }
}

@available(iOS 13.0, *)
extension FavoriteVC: UITableViewDelegate {
}
