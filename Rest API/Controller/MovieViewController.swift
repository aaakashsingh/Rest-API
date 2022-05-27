//
//  ViewController.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    var expandedIndexSet : IndexSet = [ ]
    
    
    private var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularMoviesData()
        setupUI()
    }
    
    func setupUI() {
        myTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        myTable.rowHeight = UITableView.automaticDimension
        myTable.estimatedRowHeight = 200
        myTable.tableFooterView =  UIView(frame: .zero)
        myTable.reloadData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.myTable.dataSource = self
            self?.myTable.reloadData()
        }
    }
}

// MARK: - TableView
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else{
            print("FAILED TO GET CELL")  
            return UITableViewCell()
        }
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        if expandedIndexSet.contains(indexPath.row) {
            cell.movieOverview.numberOfLines = 8
        }else{
            cell.movieOverview.numberOfLines = 3
        }
        return cell
    }
    
}
extension MovieViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        
        if(expandedIndexSet.contains(indexPath.row)){
                    expandedIndexSet.remove(indexPath.row)
                } else {
                    expandedIndexSet.insert(indexPath.row)
                }
        myTable.reloadRows(at: [indexPath], with: .automatic)

    }
}

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!,
                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil).string
    }
}


