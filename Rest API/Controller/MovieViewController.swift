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
    
    var selectedIndex = -1
    var isCollapse = false

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
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
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
            cell.movieOverview.numberOfLines = 0
        }else{
            cell.movieOverview.numberOfLines = 3
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndex == indexPath.row && isCollapse == true{
            return 50
        }
        else{
            return UITableView.automaticDimension
        }
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row{
            if self.isCollapse == false
            {
                self.isCollapse = true
            } else
            {
                self.isCollapse = false
            }
            }else{
            self.isCollapse = true
            }
        self.selectedIndex = indexPath.row
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
