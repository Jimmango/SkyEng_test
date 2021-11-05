//
//  ViewController.swift
//  SkyEng_test
//
//  Created by Dima Loria on 06.10.2021.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func update(with text: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
 
    var delegate: ViewControllerDelegate?
    
    let wordsViewController = WordsViewController()
    let color = UIColor()
    let searchController = UISearchController()
    let tableView = UITableView()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchTaped")
        
        searchController.isActive = false
        searchController.searchBar.endEditing(true)

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    var listOfWords = [Word]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfWords.count) words found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationStyle()
        configureSearchController()

        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let listInWithWords = listOfWords[indexPath.row]
        
//        cell.configure(with: listInWithWords.text)
//        cell.delegate = self
        
      cell.textLabel?.text = listInWithWords.text
//      cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWords.count
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchBarText = searchBar.text else { return }
        NetworkManager.shared.getWords(word: searchBarText) { word, errorMessage in
            guard let word = word
            else {
                print("error")
                return
            }
            self.listOfWords = word
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selecterWord = listOfWords[indexPath.row]
        delegate?.update(with: selecterWord.text)
        
        // !!!
        wordsViewController.titleLabel.text = selecterWord.text
        // !!!
        
        navigationController?.pushViewController(wordsViewController, animated: true)
    }
    
    
    func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Введите слово"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        

    }
    
    func setupNavigationStyle() {
        let appearance = UINavigationBarAppearance()
        let searchController = UISearchController()
        
        searchController.searchResultsUpdater = self
    
        title = "Словарь"
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .lightRed
        
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
}
