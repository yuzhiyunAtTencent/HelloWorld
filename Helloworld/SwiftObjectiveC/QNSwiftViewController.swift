//
//  QNSwiftViewController.swift
//  Helloworld
//
//  Created by zhiyunyu on 2020/4/8.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

import UIKit

class QNSwiftViewController: UIViewController {
    @objc var titleStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.red
        
        let person = QNPerson()
        person.name = "俞志云"
        
        person.sayHello()
        
        person.saySomething("swift调用oc 带参数")
        
        person.sayCallback { (helloStr) in
            print(helloStr)
        }
        
        person.saySomething1("第一个参数", something2: "第二个参数") { (helloStr) in
            print(helloStr)
        }
        
//        person.sendGreetingWithMessage("哈哈哈")
//        person.sendGreeting(withMessage: "哈哈哈")
        person.sendGreeting(message: "哈哈哈")
    }
    
    // @objc 使得可以被oc访问
    @objc func testSwiftFunction() {
        print("oc调用swift, 无参数")
    }
    
    @objc func swiftSayHello(helloMsg: String) {
        print(helloMsg)
    }
}
