//
//  TableView+Extension.swift
//  Flazhed
//
//  Created by IOS33 on 26/03/21.
//

import UIKit
import Foundation

import UIKit
extension UICollectionView {
    func registerColletionCell(identifier:String)  {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}

extension UITableView {
    func registerTableCell(identifier:String)  {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    func contentInset(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) {
        self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
extension UICollectionView {
  
    func scroolDirection(_ horizontal:Bool) {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            if horizontal {
                layout.scrollDirection = .horizontal
            }else {
                layout.scrollDirection = .vertical
            }
        }
    }
    func contentInset(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) {
        self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
extension UICollectionView {

    public func scrollToLastItem(at scrollPosition: UICollectionView.ScrollPosition, adjustment: CGFloat = 0.0, withAdjustmentDuration duration: TimeInterval = 0.5)
    {
        let lastSection = self.numberOfSections - 1
        let lastRowInLastSection = self.numberOfItems(inSection: lastSection)
        if lastSection > 0, lastRowInLastSection > 0 {
            let indexPath = IndexPath(row: lastRowInLastSection - 1, section: lastSection)
            let visibleIndexPaths = self.indexPathsForVisibleItems
            if !visibleIndexPaths.contains(indexPath) {
                self.self.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
                UIView.animate(withDuration: duration) {
                    switch scrollPosition {
                    case .top, .bottom, .centeredVertically:
                        self.contentOffset.y += adjustment
                    case .left, .right, .centeredHorizontally:
                        self.contentOffset.x += adjustment
                    default:
                        print("Inavlid scrollPosition: \(scrollPosition)")
                    }
                }
            }
        }
    }
}


extension UITableView
{
  func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
    return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
  }

    func scrollToTop(animated: Bool,row:Int = 0)
    {
    let indexPath = IndexPath(row: row, section: 0)
    if self.hasRowAtIndexPath(indexPath: indexPath)
    {
        
        if row>9
        {
            self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
        else
        {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
       
    }
    else
    {
        self.reloadData()
    }
  }
    
    func scrollToBottom(animated: Bool,row:Int = 0,section:Int = 0) {
    let indexPath = IndexPath(row: row, section: section)
    if self.hasRowAtIndexPath(indexPath: indexPath) {
       self.scrollToRow(at: indexPath, at: .bottom, animated: animated)

    }
    else
    {
        self.reloadData()
    }
  }
    
    func scrollSamePostion(animated: Bool,row:Int = 0,section:Int = 0)
    {
    let indexPath = IndexPath(row: row, section: section)
    if self.hasRowAtIndexPath(indexPath: indexPath) {
        self.scrollToRow(at: indexPath, at: .bottom, animated: animated)

    }
    else
    {
        self.reloadData()
    }
  }
}
//MARK:- table extension 

extension UITableView {
      // center point of content size
    var centerPoint : CGPoint {
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }

    // center indexPath
     var centerCellIndexPath: IndexPath? {

        if let centerIndexPath: IndexPath  = self.indexPathForRow(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }

    // visible or not
    func checkWhichVideoToEnableAtIndexPath() -> IndexPath? {
        guard let middleIndexPath = self.centerCellIndexPath else {return nil}
        guard let visibleIndexPaths = self.indexPathsForVisibleRows else {return nil}

        if visibleIndexPaths.contains(middleIndexPath) {
            return middleIndexPath
         }

        return nil

    }
}
extension UITableView {

    func scrollToBottom(){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: false)
           }
        }
    }

}
extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
