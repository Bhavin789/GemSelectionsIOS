//
//  AstrologyViewController.swift
//  GemSelection
//
//  Created by Bhavin on 11/06/18.
//  Copyright © 2018 atlas. All rights reserved.
//

import UIKit

class AstrologyViewController: UIViewController {

    @IBOutlet weak var matchButton: UIButton!
    @IBOutlet weak var makingButton: UIButton!
    @IBOutlet weak var westernButton: UIButton!
    @IBOutlet weak var astroButtonMatch: UIButton!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var hororscopeButton: UIButton!
    @IBOutlet weak var indianButton: UIButton!
    @IBOutlet weak var astroButton: UIButton!
    
    var matchMaking: [String]?
    var westernAstro: [String]?
    var indianAstro: [String]?
    var dailyhoroscope: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchButton.addTarget(self, action: #selector(handleMatch), for: .touchUpInside)
        westernAstro = ["Western Horoscope", "Western Chart", "Daily Tropical Transit", "Weekly Tropical Transit", "Monthly Tropical Transit", "Solar Return", "Solar Return Planet", "Solar Return House", "Lunar Metrics", "Composite Horoscope", "Synastry Horoscope", "Personality Report", "Romantic Personality Report", "Personalized Planet Prediction", "Life Forecast Report", "Romantic Forecast Report", "Friendship Report", "Karma Destiny Report", "love Compatibilty Report", "Romantic Forecast Couple Report", "Zodiac Compatibilty", "Sun Sign Compatibility"]

        matchMaking = ["Match Birth Deatils", "Match Ashtakoot Points", "Match Vedha", "Match Astro Details", "Match Planet Details", "Match Manglik Report", "Match Making Report", "Match Simple Report", "Match Making Deatiled Report", "Match Dashakoot Points", "Match Percentage", "Partner Report", "Custom Match Profiles", "Papasamyam Details"]
        
        indianAstro = ["General House Report", "General Ascendant Report", "General Planet Nature Report", "General Moon BioRythm Report", "Moon Horoscope Report Chart", "Kal Sarpa Details", "Basic Astrology Report", "Basic Astrology Details", "Basic Astrology Planets", "Madhya Bhav", "Ayanmsha", "Major Char Dasha", "Curren Char Dasha", "Sub Char Dasha", "Sub Sub Char Dasha", "Gemstone Suggestion", "Basic Panchang", "Planet Panchang", "Yogini Dasha", "Numerology Report", "Numerology Favourable Time", "Numerology Place Vastu", "Numerology Daily Prediction"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleMatch(){
        let viewController = AstrologyMenuTableViewController()
        viewController.menuItems = matchMaking
        self.present(viewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
