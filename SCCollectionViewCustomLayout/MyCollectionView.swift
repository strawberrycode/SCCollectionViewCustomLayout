//
//  MyCollectionView.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 30/12/2015.
//  Copyright © 2015 Catherine Schwartz. All rights reserved.
//

import UIKit

class MyCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet var collectionView: UICollectionView!
    
    let sectionImage = 0
    let sectionText = 1
    let sectionItem = 2
    let sectionItem2 = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.registerNib(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Important for screen rotation or resizing, on iPad for example
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == sectionItem || section == sectionItem2) {
            return 10
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (indexPath.section == sectionImage) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            
            cell.imageView.image = UIImage(named: "InstaCat")
            
            return cell
            
        } else if (indexPath.section == sectionText) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TextCell", forIndexPath: indexPath) as! TextCell
            
            cell.titleLabel.text = "The Cat - Wikipedia"
            cell.textLabel.text = "The domestic cat (Felis catus or Felis silvestris catus) is a small, typically furry, domesticated, and carnivorous mammal. They are often called house cats when kept as indoor pets or simply cats when there is no need to distinguish them from other felids and felines. Cats are often valued by humans for companionship and their ability to hunt vermin. \n\nCats are similar in anatomy to the other felids, with strong, flexible bodies, quick reflexes, sharp retractable claws, and teeth adapted to killing small prey. Cat senses fit a crepuscular and predatory ecological niche. Cats can hear sounds too faint or too high in frequency for human ears, such as those made by mice and other small animals. They can see in near darkness. Like most other mammals, cats have poorer color vision and a better sense of smell than humans. \n\nDespite being solitary hunters, cats are a social species and cat communication includes the use of a variety of vocalizations (mewing, purring, trilling, hissing, growling, and grunting), as well as cat pheromones and types of cat-specific body language.\n\nImage credit: http://favim.com/image/2817791/"
            
            cell.setBorder(UIColor.blueColor())
            
            return cell
            
        } else if (indexPath.section == sectionItem || indexPath.section == sectionItem2) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
            
            cell.imageView.image = UIImage(named: "kitten\(indexPath.item).jpg")
            cell.imageView.contentMode = .ScaleAspectFill
            cell.itemLabel.text = "Kitten \(indexPath.item)"
            
            if (indexPath.section == sectionItem2) {
                cell.setBorder(UIColor.yellowColor())
            } else {
                cell.setBorder(UIColor.redColor())
            }
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }

    
    // MARK: - Header
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
        if (kind == UICollectionElementKindSectionHeader && (indexPath.section == sectionItem || indexPath.section == sectionItem2)) {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as! HeaderView
            
            if (indexPath.section == sectionItem) {
                view.headerTitle.text = "Cats"
                view.headerText.text = "A world of little kitty cats \n__ Blah blah second line to test a bit more __"
            } else {
                view.headerTitle.text = "One more section"
                view.headerText.text = "A\nB\nC\nD\nE"
            }
            view.setBorder(UIColor.greenColor())
            return view
        }
        return UICollectionReusableView()
    }
    

    
}
