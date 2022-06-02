//
//  ViewController.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.
//

import UIKit
import RealmSwift

class MovieViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var expandedIndexSet : IndexSet = [ ]
    
//    var realmDB: Realm!
    var listUser : [MovieCell] = []
//    let realm = try! Realm()
    private var realmDB : Realm!
    
    
    let reachability = try! Reachability()
    private var viewModel = MovieViewModel()
    
    //MARK: ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularMoviesData()
        setupUI()
        ReadData()
        
        realmDB =  try! Realm()
//        realmDB = try! Realm()
        print(realmDB.configuration.fileURL!)

        
        //MARK: - Internet Connection Support
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi{
                print("Reachable via WiFi...")
            }
            else{
                print("Reachable Via Cellular...")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not Reachable")
            self.ShowAlert()
        }
        do{
            try reachability.startNotifier()
        }catch{
            print("Unable to start Notifier")
        }
    }
    
    func ShowAlert(){
        let alert = UIAlertController(title: "No Internet",
                                      message: "This App requires WiFi/Internet connection!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"),
                                      style: .default,
                                      handler: {_ in
                NSLog("The \"Ok\" alert occured...")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Table Cell Setup
    func setupUI() {
        myTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        myTable.rowHeight = UITableView.automaticDimension
        myTable.estimatedRowHeight = 100
        myTable.reloadData()
    }
    
    
    //MARK: - Loading all movies
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            guard let self = self else { return }
            self.myTable.dataSource = self
            self.myTable.delegate = self
            self.myTable.reloadData()
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
        cell.movieOverview.text = movie.summary?.html2String
        cell.selectionStyle = .none
    
        if expandedIndexSet.contains(indexPath.row) {
            cell.movieOverview.numberOfLines = 0
        }else{
            cell.movieOverview.numberOfLines = 3
        }
        return cell
    }
}
    
extension MovieViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }

}

extension MovieViewController {
    func ReadData()  {
        realmDB?.beginWrite()
        let data = realmDB?.objects(MovieCell.self)
        let jsonData = try! JSONEncoder().encode(data)
        print(String(data: jsonData, encoding: .utf8))
        try! realmDB?.commitWrite()
    }
}



