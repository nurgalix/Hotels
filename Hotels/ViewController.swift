//
//  ViewController.swift
//  Hotels
//
//  Created by Nurgali on 20.12.2023.
//

import UIKit

final class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var mainHotel: MainHotel?
    
    private var hotelManager = HotelManager()
    @IBOutlet weak var collectionView: UICollectionView!
    var timer: Timer?
    var currentCellIndex = 0
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Отель"
        
        hotelManager.delegate = self
        hotelManager.performRequest()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/3.3),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            ratingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        guard let count = mainHotel?.image_urls.count else { return }
        pageControl.numberOfPages = count
    }
    
    
    @objc func slideToNext() {
        if currentCellIndex < (mainHotel?.image_urls.count ?? 1) - 1
        {
            currentCellIndex = currentCellIndex + 1
        }
        else 
        {
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainHotel?.image_urls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {
            fatalError("Unable to dequeue YourCollectionViewCell")
        }
        
        guard let mainHotel = mainHotel else {
            return cell
        }
        
        let imageUrl = mainHotel.image_urls[indexPath.item]
        
        loadImageFromUrl(urlString: imageUrl) { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

}

extension ViewController: HotelManagerDelegate {
    func didFetchHotel(_ hotel: MainHotel) {
        mainHotel = hotel
        
        collectionView.reloadData()
    }
    
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

