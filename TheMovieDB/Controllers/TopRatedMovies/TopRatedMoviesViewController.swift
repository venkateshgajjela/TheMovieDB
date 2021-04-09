//
//  TopRatedMoviesViewController.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import UIKit

class TopRatedMoviesViewController: UIViewController {

    @IBOutlet var topRatedTableView: UITableView!
    var result = NSMutableArray()
    var backdropImgArray = NSMutableArray()
    var pageCount = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.topRatedServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.topRatedServiceCall(pageCount: pageCount)
    }

   

}

// MARK:- UITableView DataSource, Delegate
extension TopRatedMoviesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedMoviesTableViewCell") as! TopRatedMoviesTableViewCell
        cell.cellBgView.viewShadow(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), opacity: 0.8, radius: 10, shadowOffset: CGSize(width: 0, height: 0))
        if let resultDic = self.result[indexPath.row] as? NSDictionary{
            cell.titleLbl.text = "\(resultDic["original_title"] ?? "")"
            cell.dateLbl.text = "\(resultDic["release_date"] ?? "")"
            if let rating_avarage = resultDic["vote_average"] as? Double{
                cell.ratingView.rating = rating_avarage
            }else{
                cell.ratingView.rating = 0.0
            }
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(resultDic["poster_path"] ?? "")"){
                cell.posterImage.downloaded(from: url)
                cell.posterImage.layer.cornerRadius = 5
            }else{
                cell.posterImage.image = #imageLiteral(resourceName: "image")
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.topRatedTableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                self.pageCount += 1
                print("page count : \(self.pageCount)")
                self.topRatedServiceCall(pageCount: pageCount)
            }
        }
    
    }
    

}

// MARK:- API Service Calling
extension TopRatedMoviesViewController{
    func topRatedServiceCall(pageCount: Int) {
//        api_key=12b39edda6b9a77493afa39c0438c491&language=en-US&page=1
        let query = "api_key=\(K_API_KEY)&language=en-US&page=\(pageCount)"
        APIManager.sharedInstance.apiSerciceCall(controller: self, url: K_TOP_RATED + query, params: [:], method: HttpMethod.GET) { (response, error, httpResponsStatus) in
            let statusCode = httpResponsStatus?.statusCode
            print("status code \(statusCode ?? 0)")
            if statusCode == 200 || statusCode == 201{
                if let response = response as? NSDictionary{
                    if let resultArray = response["results"] as? Array<Any>{
                        for count in 0..<resultArray.count {
                            if let resultDic = resultArray[count] as? NSDictionary{
                                self.result.add(resultDic)
                            }
                        }
                        
                        print("result array : \(self.result.count) \(self.backdropImgArray.count)")
                    }
//                    self.fundRequestArray = response
                    DispatchQueue.main.async {
                        self.topRatedTableView.reloadData()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    CustomeAlert.shared.showValidationAlert(target: self, title: "", message: "Status failed") {
                    }
                }
            }
        }
    }
}
