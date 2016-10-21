//
//  UIViewController+DataTransfer.swift
//  DataTransition
//
//  Created by Alexey Shadura on 18.10.16.
//  Copyright © 2016 IntellectSoft. All rights reserved.
//

import UIKit

private var ConfiguratorKey: UInt8 = 0

extension UIViewController {
    
    //MARK: - General Methods -
    //MARK: Method for source VC
    func segue(_ identifier:String) -> UIViewController{
        
        let configurator = VCConfigurator(identifier);
        self.setInitConfigurator(configurator)
        return self
    }
    
    /// - Starts transition execution
    func execute(){
        self.performSegue(withIdentifier: self.configurator()!.segueIdentifier, sender: nil)
    }
    
    /// - Pass data in next VC
    func passData(_ inputData:Any) -> UIViewController{
        self.configurator()!.inputData = inputData
        return self
    }
    
    /// - Set callback action
    func onComplete(_ outputBlock:@escaping VCConfigurator.OutputBlock) -> UIViewController{
        self.configurator()!.outputBlock = outputBlock
        return self
    }
    
    //MARK: Methods for destination VC
    func incomingData() -> Any?{
        return self.configurator()?.inputData
    }
    
    func complete(_ parameter:Any?){
        if let outputBlock = self.configurator()?.outputBlock {
            return outputBlock(parameter)
        }
    }
    
    //MARK: - Accessors -
    
    func setConfigurator(_ configurator:VCConfigurator){
        objc_setAssociatedObject(self, &ConfiguratorKey, configurator,.OBJC_ASSOCIATION_RETAIN)
    }
    
    func configurator() -> VCConfigurator?{
        return objc_getAssociatedObject(self, &ConfiguratorKey) as? VCConfigurator
    }
    
    func setInitConfigurator(_ configurator:VCConfigurator?){
        objc_setAssociatedObject(self, &ConfiguratorKey, configurator,.OBJC_ASSOCIATION_RETAIN)
    }
    
    func initConfigurator() -> VCConfigurator?{
        return objc_getAssociatedObject(self, &ConfiguratorKey) as? VCConfigurator
    }
    
    // MARK: - Method Swizzling -
    
    open override static func initialize() {
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        let justAOneTimeThing: () = {
            let originalSelector = #selector(UIViewController.prepare(for:sender:))
            let swizzledSelector = #selector(UIViewController.newPrepare(for:sender:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }()
        
        print(justAOneTimeThing)
        
    }
    
    func newPrepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        let configurator = self.initConfigurator()
        
        if configurator == nil{
            return
        }
        let destination = segue.destination
        if destination is UINavigationController {
            let navigationController:UINavigationController = destination as! UINavigationController
            navigationController.viewControllers.first?.setConfigurator(self.initConfigurator()!)
        } else {
            destination.setConfigurator(self.initConfigurator()!)
        }
        
        self.setInitConfigurator(nil)
    }
    
}

class VCConfigurator{
    

    typealias OutputBlock = (_ parameter:Any? )-> Void
    
    var segueIdentifier:String
    var inputData:Any? = nil
    var outputBlock:OutputBlock? = nil
    
    init(_ identifier:String){
        segueIdentifier = identifier
    }
    
    deinit{
        print("deinit \(self)")
    }

}

func getAssociatedObject<ValueType: AnyObject>(_ base: AnyObject, key: UnsafePointer<UInt8>) -> ValueType? {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        return nil
}

func associateObject<ValueType: AnyObject>( base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}
