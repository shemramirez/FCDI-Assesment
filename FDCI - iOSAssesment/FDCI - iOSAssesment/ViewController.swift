//
//  ViewController.swift
//  FDCI - iOSAssesment
//
//  Created by Shem Ramirez on 3/3/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameInputTextField: UITextField!
    
    @IBOutlet weak var regionDropDownButton: UIButton!
    
    @IBOutlet weak var countryDropDownButton: UIButton!
    
    var regionData: [String] = []
    var countriesData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // before the view hierachy and when screen is called
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            do {
                let regions = try await FetchManager().getRegions()
                
                
                DispatchQueue.main.async {
                    self.regionData.removeAll() // Clear existing data
                    self.countriesData.removeAll() // Clear existing data

                    for region in regions {
                        self.appendOneRegion(regionName: region.region)
                        self.countriesData.append(region.name.common)
                    }
                
                    let actions: [UIAction] = self.regionData.map { regionName in
                        return UIAction(title: regionName) { [weak self] action in
                            print("Selected \(action.title)")
                            self?.regionDropDownButton.setTitle(action.title, for: .normal)
                        }
                    }

                    self.regionDropDownButton.menu = UIMenu(children: actions)
                    self.regionDropDownButton.showsMenuAsPrimaryAction = true
                    
                    self.countriesData.sort()
                    let countryActions: [UIAction] = self.countriesData.map { countryName in
                                            return UIAction(title: countryName) { [weak self] action in
                                                print("Selected Country: \(action.title)")
                                                self?.countryDropDownButton.setTitle(action.title, for: .normal)
                                            }
                                        }
                    self.countryDropDownButton.menu = UIMenu(children: countryActions)
                    self.countryDropDownButton.showsMenuAsPrimaryAction = true
                }
            }
        }
    }
    
    func appendOneRegion(regionName: String) {
          if !self.regionData.contains(regionName) {
              self.regionData.append(regionName)
          }
      }
    

    @IBAction func onTappedSubmitButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as DetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // submit button
    
    @IBAction func onTappedClearButton(_ sender: Any) {
        
    }
    
}

