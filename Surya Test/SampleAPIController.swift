//
//  SampleAPIController.swift
//  Surya Test
//
//  Created by Srinu AMBATI on 15/06/24.
//

import UIKit

class SampleAPIController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var sampleTableV: UITableView!
    @IBOutlet var loaderServerResp: UIActivityIndicatorView!
    
    var tableViewDataArrayServer:[Results]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.loaderServerResp.startAnimating()
       self.loaderServerResp.isHidden = false
        
        tableViewDataArrayServer = []
        testAPICall(searchTerm: "Hello")

        sampleTableV.delegate = self
        sampleTableV.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func testAPICall(searchTerm: String) {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=\(searchTerm)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                let userNameAlert = UIAlertController(title: "Error", message: "Invalid Data", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
                
                userNameAlert.addAction(cancelAction)
                self.present(userNameAlert, animated: true)
                
                print("invalid Data")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("invalid Response")
                return
            }
            
            do {
                let products = try JSONDecoder().decode(ServerResponse.self, from: data)
                print("products array is \(String(describing: products.results))")
                
                self.tableViewDataArrayServer?.append(contentsOf: products.results!)
                DispatchQueue.main.async {
                   self.loaderServerResp.stopAnimating()
                    self.loaderServerResp.isHidden = true
                    self.sampleTableV.reloadData()
                }
            } catch {
                print("error message \(error)")
            }
            // self.tableViewDataArray?.append(stringData ?? "")
        }.resume()
    }
    
    // MARK: - UITableView DataSource
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // return 2
         return tableViewDataArrayServer?.count ?? 0
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "sampleAPIListCell", for: indexPath)
     // cell.textLabel?.text = tableViewDataArray?[indexPath.row] ?? ""
      let result = tableViewDataArrayServer?[indexPath.row]
      cell.textLabel?.text = result?.trackName
      
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            let result = tableViewDataArrayServer?[indexPath.row]
            print(result)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
