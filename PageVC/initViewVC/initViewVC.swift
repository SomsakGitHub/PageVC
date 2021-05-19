//
//  initViewVC.swift
//  PageVC
//
//  Created by somsak on 3/5/2564 BE.
//

import UIKit

class initViewVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    let dataSource = ["one view", "two view", "tree view"]
    
    var currentVCIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configuraVC()
    }

    func configuraVC(){
        guard let pageVC = storyboard?.instantiateViewController(withIdentifier: "initViewPageViewController") as? initViewPageViewController else {
            return
        }
        
        pageVC.delegate = self
        pageVC.dataSource = self
        
        addChild(pageVC)
        pageVC.didMove(toParent: self)
        
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.backgroundColor = .black
        
        self.contentView.addSubview(pageVC.view)
        
        let views: [String: Any] = ["pageView": pageVC.view]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingVC = detailVCAt(index: self.currentVCIndex) else {
            return
        }
        
        pageVC.setViewControllers([startingVC], direction: .forward, animated: true)
    }
    
    func detailVCAt(index: Int) -> initViewDataVC? {
        
        if index >= self.dataSource.count || self.dataSource.count == 0 {
            return nil
        }
        
        guard let dataVC = storyboard?.instantiateViewController(withIdentifier: "initViewDataVC") as? initViewDataVC else {
            return nil
        }
        
        dataVC.index = index
        dataVC.displayText = self.dataSource[index]

        return dataVC
    }
}

extension initViewVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentVCIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataVC = viewController as? initViewDataVC
        
        guard var currentIndex = dataVC?.index else {
            return nil
        }
        
        self.currentVCIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailVCAt(index: currentIndex)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataVC = viewController as? initViewDataVC
        
        guard var currentIndex = dataVC?.index else {
            return nil
        }
        
        if currentIndex == self.dataSource.count {
            return nil
        }
        
        currentIndex += 1
        self.currentVCIndex = currentIndex
        
        return detailVCAt(index: currentIndex)
    }
}

