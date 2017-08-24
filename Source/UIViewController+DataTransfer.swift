//
//  UIViewController+DataTransfer.swift
//  DataTransition
//
//  Created by Alexey Shadura on 18.10.16.
//  Copyright © 2016 IntellectSoft. All rights reserved.
//

import UIKit

private var InitConfiguratorKey: UInt8 = 0
private var ConfiguratorKey: UInt8 = 0

public extension UIViewController {
    
    
    var initConfigurator: VCConfigurator? {
        get { return objc_getAssociatedObject(self, &InitConfiguratorKey) as? VCConfigurator }
        set { objc_setAssociatedObject(self, &InitConfiguratorKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    var configurator: VCConfigurator? {
        get { return objc_getAssociatedObject(self, &ConfiguratorKey) as? VCConfigurator }
        set { objc_setAssociatedObject(self, &ConfiguratorKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    var incomingData: Any? {
        return self.configurator?.inputData
    }
    
    //MARK: - General Methods -
    //MARK: Method for source VC
   public func segue(_ identifier:String) -> UIViewController {
        initConfigurator = VCConfigurator(identifier);
        return self
    }
    
    /// - Starts transition execution
    public func execute(){
        guard let initConfigurator = self.initConfigurator else {
            return
        }
        
        self.performSegue(withIdentifier: initConfigurator.segueIdentifier, sender: nil)
    }
    
    /// - Pass data in next VC
    public func passData(_ inputData:Any) -> UIViewController {
        guard let initConfigurator = self.initConfigurator else {
            return self
        }
        initConfigurator.inputData = inputData
        return self
    }
    
    /// - Set callback action
    public func onComplete(_ outputBlock:@escaping (_ parameter:Any? )-> Void) -> UIViewController {
        guard let initConfigurator = self.initConfigurator else {
            return self
        }
        initConfigurator.outputBlock = outputBlock
        return self
    }
    
    //MARK: Methods for destination VC
    
    public func complete(_ parameter:Any?){
        
        guard let outputBlock = self.configurator?.outputBlock else {
            return
        }
        outputBlock(parameter)
    }
    
    public func complete(){
        self.complete(nil)
    }
    
    // MARK: - Method Swizzling -
    
    open override class func initialize() {
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        let _: () = {
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
        
    }
    
    func newPrepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let initConfigurator = self.initConfigurator {
            if let navigationController = segue.destination as? UINavigationController {
                navigationController.viewControllers.first?.configurator = initConfigurator
            } else {
                segue.destination.configurator = initConfigurator
            }
            
            self.initConfigurator = nil
        }
    }
    
    class VCConfigurator{
        var segueIdentifier:String
        var inputData:Any? = nil
        var outputBlock:((_ parameter:Any? )-> Void)? = nil
        
        init(_ identifier:String){
            segueIdentifier = identifier
        }
        
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
