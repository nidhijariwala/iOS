//
//  NewsListTableViewController.swift
//  MVVMDemo
//
//

import Foundation
import UIKit

class NewsListTableViewContoller: UITableViewController {
    
    private var artilceListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0d38f126906c4933a340f7207b32053f")!
        
        Webservice().getNewsArticles(url: url) { articles in
            
            if let articles = articles {
                self.artilceListVM = ArticleListViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.artilceListVM == nil ? 0 : self.artilceListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artilceListVM.numberOfRowsInSection(section)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.artilceListVM.articleAtIndex(indexPath.row)
        cell.titleLable.text = articleVM.title
        cell.descriptionLable.text = articleVM.description
        
        return cell
    }
}
