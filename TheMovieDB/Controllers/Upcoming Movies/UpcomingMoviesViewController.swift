//
//  UpcomingMoviesViewController.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {

    var result = NSMutableArray()
    var backdropImgArray = NSMutableArray()
    @IBOutlet var upcomingMoviesTableView: UITableView!
    var pageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.upcomingMovieServiceCall(pageCount: pageCount)
    }

    

}
// MARK:- UITableView DataSource, Delegate
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcommingMoviesCell") as! UpcomingMoviesTableViewCell
        cell.cellBgView.viewShadow(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), opacity: 0.8, radius: 10, shadowOffset: CGSize(width: 0, height: 0))
        if let resultDic = self.result[indexPath.row] as? NSDictionary{
            cell.titleLbl.text = "\(resultDic["original_title"] ?? "")"
            cell.releseDateLbl.text = "\(resultDic["release_date"] ?? "")"
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
        
        if scrollView == self.upcomingMoviesTableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                self.pageCount += 1
                print("page count : \(self.pageCount)")
                self.upcomingMovieServiceCall(pageCount: pageCount)
            }
        }
    
    }
    
    
    
}

// MARK:- API Service Calling
extension UpcomingMoviesViewController{
    func upcomingMovieServiceCall(pageCount : Int) {
//        api_key=12b39edda6b9a77493afa39c0438c491&language=en-US&page=1
        let query = "api_key=\(K_API_KEY)&language=en-US&page=\(self.pageCount)"
        APIManager.sharedInstance.apiSerciceCall(controller: self, url: K_UPCOMING + query, params: [:], method: HttpMethod.GET) { (response, error, httpResponsStatus) in
            let statusCode = httpResponsStatus?.statusCode
            print("status code \(statusCode ?? 0)")
            if statusCode == 200 {
                if let response = response as? NSDictionary{
//                    self.fundRequestArray = response
                    if let resultArray = response["results"] as? Array<Any>{
                        for count in 0..<resultArray.count {
                            if let resultDic = resultArray[count] as? NSDictionary{
                                self.result.add(resultDic)
                            }
                        }
                        
                        print("result array : \(self.result.count) \(self.backdropImgArray.count)")
                    }
                    DispatchQueue.main.async {
                        self.upcomingMoviesTableView.reloadData()
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

