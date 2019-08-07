//
//  LFNavViewController.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/7.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

class LFNavContainerView: NSView {
    override func resizeSubviews(withOldSize oldSize: NSSize) {
        super.resizeSubviews(withOldSize: oldSize)
        for v in self.subviews {
            v.frame = self.bounds
        }
    }
}
class LFNavViewController: NSViewController {

    @IBOutlet weak var containerView: LFNavContainerView!
    @IBOutlet weak var backBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(HomeViewController())
        self.containerView.addSubview(self.children.first!.view)
        self.backBtn.isHidden = self.children.count <= 1
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.lf_pop()
    }
    
}
extension LFNavViewController {
    // MARK: - push功能
    func lf_push(viewController: NSViewController,options: NSViewController.TransitionOptions = .slideLeft, completionHandler completion: (() -> Void)? = nil) -> Void {
        self.addChild(viewController)
        let count = self.children.count
        if count <= 1 {
            self.containerView.addSubview(viewController.view)
            return
        }
        let fromVC = self.children[count-2]
        let toVC = self.children[count-1]
        //[weak self]
        self.transition(from: fromVC, to: toVC, options: options) {
            //guard let strongSelf = self else {return}
            self.backBtn.isHidden = self.children.count <= 1
            guard let completion2 = completion else {
                return
            }
            completion2()
        }
    }
    // MARK: - pop功能
    func lf_pop(options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        let count = self.children.count
        if count <= 1 {
            return
        }
        let toVC = self.children[count-2]
        self.lf_pop(toVC: toVC,options: options,completionHandler: completion)
    }
    func lf_popToRoot(options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        let count = self.children.count
        if count <= 1 {
            return
        }
        let toVC = self.children[0]
        self.lf_pop(toVC: toVC,options: options,completionHandler: completion)
    }
    func lf_pop(toVC: NSViewController,options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        let count = self.children.count
        if count <= 1 {
            return
        }
        let fromVC = self.children[count-1]
        guard let toIndex = self.children.lastIndex(of: toVC) else{
            return
        }
        let willRemoveVCS = self.children[toIndex+1...count-1]
        self.transition(from: fromVC, to: toVC, options: options) {
            
            // 从父容器里去除
            for vc in willRemoveVCS {
                vc.removeFromParent()
            }
            self.backBtn.isHidden = self.children.count <= 1
            guard let completion2 = completion else {
                return
            }
            completion2()
        }
    }
}

extension NSViewController {
    var nav: LFNavViewController? {
        guard let vc = self.parent as? LFNavViewController else {
            return nil
        }
        return vc
    }
    // MARK: - push功能
    func push(viewController: NSViewController,options: NSViewController.TransitionOptions = .slideLeft, completionHandler completion: (() -> Void)? = nil) -> Void {
        self.nav?.lf_push(viewController: viewController, options: options, completionHandler: completion)
    }
    // MARK: - pop功能
    func pop(options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        self.nav?.lf_pop(options: options, completionHandler: completion)
    }
    func popToRoot(options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        self.nav?.lf_popToRoot(options: options, completionHandler: completion)
    }
    func pop(toVC: NSViewController,options: NSViewController.TransitionOptions = .slideRight, completionHandler completion: (() -> Void)? = nil) -> Void {
        self.nav?.lf_pop(toVC:toVC,options: options, completionHandler: completion)
    }
}
