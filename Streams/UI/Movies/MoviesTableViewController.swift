//
//  MoviesTableViewController.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import RxSwift


class MoviesTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var moviesList: [Movie] = [] //

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMovie(title: "Batman", year: "1943")
        fetchMovie(title: "Batman and Robin", year: "1949")
        fetchMovie(title: "Batman", year: "1966")
        fetchMovie(title: "Batman", year: "1989")
        fetchMovie(title: "Joker", year: "2019")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.resuseId, for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        let movie = moviesList[indexPath.row]
        cell.updateData(movie: movie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let movie = moviesList[indexPath.row]
       let nextViewController = MovieDetailsViewController.instance()
       nextViewController.updateMovie(movie: movie)
    self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchMovie(title: String, year: String) {
        
        ApiClient.fetchMovie(title: title, year: year).observeOn(MainScheduler.instance)
            .subscribe(onNext: { movie in
                if movie.response == "True" {
                    print("Movie Came In HOT!");
                    
                    self.moviesList.append(movie)
                    self.tableView.reloadData()
                    
                }
            }, onError: { error in
                print("May Day! We have been Hit! \(error)")
            }).disposed(by: disposeBag)
        
    }

}