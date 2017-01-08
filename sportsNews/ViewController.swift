//
//  ViewController.swift
//  sportsNews
//
//  Created by Etnuh on 1/3/17.
//  Copyright © 2017 Rainman Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var articles: [Article]? = []
    var source = "nflnews"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchArticles(fromSource: source)
    }
    
    func fetchArticles(fromSource provider: String) {
        
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(provider)&sortBy=top&apiKey=722c05c77ee94c99bb4d8d5e18dedddc")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articlesFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articlesFromJson["title"] as? String, let desc = articlesFromJson["description"] as? String, let author = articlesFromJson["author"] as? String, let url = articlesFromJson["url"] as? String, let urlImage = articlesFromJson["urlToImage"] as? String  {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.urlImage = urlImage
                            
                            
                        }
                        self.articles?.append(article)
                   }
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }
     task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
    
        cell.title.text = self.articles?[indexPath.item].headline
        cell.author.text = self.articles?[indexPath.item].author
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgViewz.downloadImage(from:(self.articles?[indexPath.item].urlImage!)!)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebviewVC
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: false, completion: nil)

        }
    let menuManager = menuMonitor()
    @IBAction func buttonPressed(_ sender: Any) {
        
        menuManager.showMenu()
        menuManager.mainVC = self
    }
    

}

extension UIImageView {
    
    func downloadImage(from url:String) {
        
        let urlRequest = URLRequest(url: URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
    

        DispatchQueue.main.async {
            self.image = UIImage(data: data!)
            }
        }
        task.resume()
}
 
}

