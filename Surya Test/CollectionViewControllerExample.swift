//
//  TableViewControllerExample.swift
//  Surya Test
//
//  Created by Srinu AMBATI on 02/06/24.
//

import UIKit

class CollectionViewControllerExample: UIViewController {

    @IBOutlet var sampleCollectionV: UICollectionView!
    @IBOutlet var loaderServerResp: UIActivityIndicatorView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var tableViewDataArray:[String]?
    var tableViewDataArrayServer:[Results]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewDataArray = []
        tableViewDataArrayServer = []
        
        tableViewDataArray?.append("First Row")
        tableViewDataArray?.append("Second Row")
        tableViewDataArray?.append("Third Row")
        tableViewDataArray?.append("Fourth Row")
        tableViewDataArray?.append("Fifth Row")
        
        self.loaderServerResp.startAnimating()
        self.loaderServerResp.isHidden = false

        testAPICall(searchTerm: "Hello")
        
        sampleCollectionV.delegate = self
        sampleCollectionV.dataSource = self
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
                    self.sampleCollectionV.reloadData()
                }
            } catch {
                print("error message \(error)")
            }
            // self.tableViewDataArray?.append(stringData ?? "")
        }.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }/Users/srinua/Documents/Surya/Surya Test/Surya Test/Results.swift
    */

}

// MARK: - CollectionView DataSource

extension CollectionViewControllerExample: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableViewDataArrayServer?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesListCell", for: indexPath) as! CollectionViewCell
        let result = tableViewDataArrayServer?[indexPath.row]
        collectionViewCell.artistNamelabel.text = result?.trackName ?? ""
        collectionViewCell.backgroundColor = .yellow
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}

extension CollectionViewControllerExample: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let columns: CGFloat = 3
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = adjustedWidth / columns
        let height: CGFloat = 40

        /*if indexPath.item % 5 == 0 ||  indexPath.item % 8 == 0  {
            return CGSize(width: width, height: height + 35)
        }*/
        
        return CGSize(width: width, height: height)
    }
}
