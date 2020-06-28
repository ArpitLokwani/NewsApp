//
//  ViewController.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 27/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import UIKit
class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
  
    var dataSources:News?
    var totalDataCount = 0
    var loadMorePageCount = 1
    
    var articleDataSource = [Article]()
    let newsViewModel = NewsViewModel()
    var pullDownRefresh = false
    let kNewsCellIdentifier = "NewsCustomCell"
    
    @IBOutlet weak var newsTableView: UITableView!
  
    func setTable()  {
        pullDownRefresh = true;
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(UINib(nibName: kNewsCellIdentifier, bundle: nil), forCellReuseIdentifier: kNewsCellIdentifier)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTable()
        newsViewModel.getNews(pageNumber: "1") { (articles) in
            self.articleDataSource = articles
            self.reloadData()
        }
    }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    @IBAction func languageChangeBtnPressed(_ sender: Any) {
        
        if(LocalizationSystem.sharedInstance.getLanguage() == "en"){
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "fr")
             (sender as! UIButton).setTitle("ENGLISH", for: .normal)
        }else{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            (sender as! UIButton).setTitle("FRENCH", for: .normal)
        }
       
        updateLanguage()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellIdentifier, for: indexPath) as! NewsCustomCell

        if(self.articleDataSource.count>0){
            cell.titleLabel.text = self.articleDataSource[indexPath.row].title
            cell.authorLabel.text = self.articleDataSource[indexPath.row].author
            cell.descLabel.text = self.articleDataSource[indexPath.row].descriptionField
            
            // hide/unhide the  author label if data is not there
            if let authoreName = self.articleDataSource[indexPath.row].author{
                 if (authoreName.count == 0) {
                          cell.authorPlaceholderLabel.isHidden = true
                      }else{
                          cell.authorPlaceholderLabel.isHidden = false
                      }
                }
             else {
                cell.authorPlaceholderLabel.isHidden = true
            }
            
            // hide/unhide the  description label if data is not there
            if let description = self.articleDataSource[indexPath.row].descriptionField{
                  if (description.count == 0) {
                        cell.descPlaceholderLabel.isHidden = true
                    }else{
                        cell.descPlaceholderLabel.isHidden = false
                    }
                }
            else {
                    cell.descPlaceholderLabel.isHidden = true
            }
            
            let imageURL = (self.articleDataSource[indexPath.row].urlToImage) ?? ""
            cell.newsImgView.downloaded(from: imageURL, contentMode: .scaleAspectFit)
            }
           return cell
     }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.dataCount
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
            let totalRow = tableView.numberOfRows(inSection: indexPath.section)
             if(totalRow>4){
                if(newsViewModel.totalNumbers>5){
                        if(indexPath.row == totalRow-2 && pullDownRefresh){
                            loadMore()
                        }
                    }
                }
            }
    
    
    func loadMore() -> Void {
        totalDataCount += newsViewModel.dataCount
        if (newsViewModel.totalNumbers >= totalDataCount) {
            pullDownRefresh = true;
            loadMorePageCount += 1
            self.showLoader()
            newsViewModel.getNews(pageNumber: "\(loadMorePageCount)", completionHandler: { (articles) in
                self.articleDataSource = articles
                self.reloadData()
            })
        } else {
            self.hideLoader()
            pullDownRefresh = false;
        }
     }
    
   func reloadData() {
          DispatchQueue.main.async {
              self.newsTableView.reloadData()
              self.hideLoader()

          }
      }
    
    func updateLanguage() -> Void {
            for j in 0...self.newsTableView.numberOfRows(inSection: 0)
               {
                if let cell:NewsCustomCell = (self.newsTableView.cellForRow(at: NSIndexPath(row: j, section: 0) as IndexPath) as? NewsCustomCell) {
                    cell.titlePlaceholderLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Title", comment: "")
                    cell.descPlaceholderLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Description", comment: "")
                    cell.authorPlaceholderLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Author", comment: "")
                   }
               }
            }
    
    
}

