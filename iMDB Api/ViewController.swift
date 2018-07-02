//
//  ViewController.swift
//  iMDB Api
//
//  Created by Sarthak Mishra on 17/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieCast: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTitle: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var movieDesc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        
        
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchForMovie(q: searchBar.text!)
    }
  
    func searchForMovie(q :String)
    {
        
        if let movie  = q.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            
            let url =  URL(string: "https://www.omdbapi.com/?t=\(movie)&apikey=8d13d99")
         print(url)
            let session = URLSession.shared
          
            let task = session.dataTask(with: url!, completionHandler: {  (data, response, error) in
                
                
                if(error != nil)
                {
                  print(error)
                }else{
                    
                  if(data != nil)
                  {
                    do{
                   
                        let jsonSerialized = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                        
                       
               
                        DispatchQueue.main.async{
                      //  print(jsonResult)
                            
                            
                            self.movieTitle.text = jsonSerialized!["Title"] as! String
                            self.movieCast.text = jsonSerialized!["Actors"] as! String
                            self.movieReleaseDate.text = jsonSerialized!["Released"] as! String
                            self.movieGenre.text = jsonSerialized!["Genre"] as! String
                            self.movieDesc.text = jsonSerialized!["Plot"] as! String
                            
                            
                            if let imageExists = jsonSerialized!["Poster"] {
                                
                                let imageURL = URL(string: imageExists as! String)
                                
                                if let imageData = try? Data(contentsOf: imageURL!) {
                                    self.imageView.image = UIImage(data: imageData)
                                }
                            }
                        }
                    }catch{
                        
                        print("Serialization error")
                    }
                   
                    }
                    
                    
                    
                    
                    
                    
                }
            })
            task.resume()
        }
        
       
        
    }


}

