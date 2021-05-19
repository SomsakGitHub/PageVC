//
//  initViewDataVC.swift
//  PageVC
//
//  Created by somsak on 18/5/2564 BE.
//

import UIKit

class initViewDataVC: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var index = 0
    
    var displayText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.displayLabel.text = self.displayText
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
