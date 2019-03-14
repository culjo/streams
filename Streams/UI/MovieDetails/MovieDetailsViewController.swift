//
//  MovieDetailsViewController.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var headerConstraint: NSLayoutConstraint! // headerHeightConstraint
    @IBOutlet weak var titleTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var titleStackView: UIStackView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterBackdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var topTitleLabel: UILabel!
    
    
    let maxHeaderHeight: CGFloat = 320;
    let minHeaderHeight: CGFloat = 64;
    
    var previousScrollOffset: CGFloat = 0;
    
    var movieDetail: Movie?
    var movieInfo: [MovieInfo] = []
//    var movieInfoArray = Array<Any>()
    
    class func instance() -> MovieDetailsViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as! MovieDetailsViewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
        
        // Adding a semi opacity scrim on the image for text visibility
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: posterBackdropImage.frame.size.width, height: posterBackdropImage.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        posterBackdropImage.addSubview(overlay)
        
        displayMovieDetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        self.headerConstraint.constant = self.maxHeaderHeight;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func updateMovie(movie: Movie) {
        
        self.movieDetail = movie
        
    }
    
    func displayMovieDetails() {
        
        guard let movie = movieDetail else {
            print("Movie Not Yet Availabe for Display")
            return
        }
        
        do {
        posterBackdropImage.downloadedFrom(url: try movie.poster.asURL(), contentMode: .scaleAspectFill)
        } catch {
        print("Cannot Get Image")
        }
    
        titleLabel.text = movie.title
        directorLabel.text = "\(movie.director) - \(movie.year)"
        topTitleLabel.text = movie.title
        
        buildMovieInfo()
    }
    
    func buildMovieInfo() {
        
        guard let movie = movieDetail else {
            print("Movie Not Yet Availabe for Display")
            return
        }
        
        movieInfo.append(MovieInfo("Genre", movie.genre))
        
        movieInfo.append( MovieInfo("Type", movie.type))
        movieInfo.append(MovieInfo("Actors", movie.actors))
        movie.ratings.forEach({ rating in
            movieInfo.append(MovieInfo(rating.source,  rating.value))
        })
        movieInfo.append(MovieInfo("Plot",movie.plot))
        movieInfo.append(MovieInfo("Writer",movie.writer))
        movieInfo.append(MovieInfo("Released", movie.released))
        movieInfo.append(MovieInfo("Runtime", movie.runtime))
    
        movieInfo.append(MovieInfo("Rated", movie.rated))
        
        movieInfo.append(MovieInfo("Language", movie.language))
        movieInfo.append(MovieInfo("Country", movie.country))
        movieInfo.append(MovieInfo("Awards", movie.awards))
        movieInfo.append(MovieInfo("ImdbRating", movie.imdbRating))
        movieInfo.append(MovieInfo("MetaScore", movie.metascore))
        movieInfo.append(MovieInfo("ImdbVotes", movie.imdbVotes))
        movieInfo.append(MovieInfo("DVD", movie.dvd))
        movieInfo.append(MovieInfo("BoxOffice", movie.boxOffice))
        movieInfo.append(MovieInfo("Production", movie.production))
        movieInfo.append(MovieInfo("Website", movie.website))
        
        
        
//        movieInfoArray = Array(movieInfo);
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}

extension MovieDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.resuseId, for: indexPath) as! MovieDetailTableViewCell
        
        
        
        cell.updateCell(key: movieInfo[indexPath.row].key, value: movieInfo[indexPath.row].value)
        
        // let cell = UITableViewCell()
        // cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
    
}

extension MovieDetailsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        if canAnimateHeader(scrollView) {
            
            // Calculate new header height
            var newHeight = self.headerConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerConstraint.constant + abs(scrollDiff))
            }
            
            // Header needs to animate
            if newHeight != self.headerConstraint.constant {
                self.headerConstraint.constant = newHeight
                self.updateHeader()
                self.setScrollPosition(self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.headerConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }
    
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.headerConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }

    func setScrollPosition(_ position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.headerConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        // self.titleTopConstraint.constant = -openAmount + 10
        self.titleTopConstaint.constant = -openAmount + 30
        self.posterBackdropImage.alpha = percentage
        self.titleStackView.alpha = percentage
        
    }
    
}
