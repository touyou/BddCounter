//
//  CounterViewControllerTests.swift
//  BddCounterUITests
//
//  Created by 藤井陽介 on 2019/12/10.
//  Copyright © 2019 touyou. All rights reserved.
//

import XCTest
@testable import BddCounter

class CounterViewControllerTests: XCTestCase {

    func testIncrementButton() {

        let vc = CounterViewController.make()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()

        XCTAssertEqual(vc.countLabel.text, "0")

        vc.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(vc.countLabel.text, "1")
    }

}
