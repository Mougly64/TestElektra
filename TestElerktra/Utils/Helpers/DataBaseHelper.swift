//
//  DataBaseHelper.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
final class DataBaseHelper {
    static let sharedInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// this method save the new favorite in the database
    /// - Parameters:
    ///   - show: object that could be saved
    ///   - image: the url image from the object
    func saveShow(show: TvShow) -> Bool {
        do {
            let newTvShow = ShowTv(context: context)
            newTvShow.id = Int32(show.id!)
            newTvShow.name = show.name
            newTvShow.image = show.image![Constants.medium]
            newTvShow.imdb = show.externals.imdb
            newTvShow.summary = show.summary
            try context.save()
            print("Image is saved")
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    /// this method fetch the elements from the database through the context
    /// - Parameters:
    ///   - success: escaping completition handler with the list objects
    ///   - failure: escping failure completition handler with the error
    func fetchShows(success: @escaping(_ showsSaved: [ShowTv]) -> (), failure: @escaping(_ error: Error?) -> ()) {
        do {
            try success(context.fetch(ShowTv.fetchRequest()))
        } catch {
            failure(error)
        }
    }
}
