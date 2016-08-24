//
//  MenuTableController.swift
//  RZKit Example
//
//  Created by Rizbi on 8/24/16.
//  Copyright © 2016 rzkit. All rights reserved.
//

import UIKit

class MenuTableController: UITableViewController, UISplitViewControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
        self.splitViewController?.delegate = self
    }
    
    // MARK: - Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0
        {
            let controller = self.getControllerForID("FadeDemoViewController")
            self.splitViewController?.showDetailViewController(controller, sender: self)
        }
        else if indexPath.row == 1
        {
            let controller = self.getControllerForID("ScaleDemoViewController")
            self.splitViewController?.showDetailViewController(controller, sender: self)
        }
    }
    
    private func getControllerForID(storyboardid: String) -> UINavigationController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier(storyboardid)
        
        return UINavigationController(rootViewController: controller)
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad)
        {
            return false
        }
        return true
    }
}
