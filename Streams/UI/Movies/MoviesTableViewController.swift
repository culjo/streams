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
        fetchMovie(title: "batman", year: "1966")
        fetchMovie(title: "Batman", year: "1989")
        fetchMovie(title: "Batman Returns", year: "1992")
        fetchMovie(title: "Batman Forever", year: "1995")
        fetchMovie(title: "Batman & Robin", year: "1997")
        fetchMovie(title: "Batman Begins", year: "2005")
        fetchMovie(title: "The Dark Knight", year: "2008")
        fetchMovie(title: "The Dark Knight Rises", year: "2012")
        fetchMovie(title: "Batman v Superman: Dawn of Justice", year: "2016")
        fetchMovie(title: "Suicide Squad", year: "2016")
        fetchMovie(title: "Justice League", year: "2017")
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
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    /**
     Fetches a movie from the api using both the movie title and year it was produced
     - parameters:
         - title: The title of the movie to retrieve
         - year: The year the movie was produced
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
