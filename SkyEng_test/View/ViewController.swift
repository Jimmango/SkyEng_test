//
//  ViewController.swift
//  SkyEng_test
//
//  Created by Dima Loria on 06.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UITextFieldDelegate, UISearchControllerDelegate {

    let color = UIColor()
    
    let searchController = UISearchController()
    
    let tableView = UITableView()
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchTaped")
        searchController.isActive = false
        searchController.searchBar.endEditing(true)

    }
    
    var listOfWords = [Word]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfWords.count) words found"
            }
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationStyle()
        configureSearchController()

        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let listInWithWords = listOfWords[indexPath.row]
        
        cell.textLabel?.text = listInWithWords.text
//      cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWords.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped")
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

