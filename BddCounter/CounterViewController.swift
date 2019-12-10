//
//  ViewController.swift
//  BddCounter
//
//  Created by 藤井陽介 on 2019/12/10.
//  Copyright © 2019 touyou. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var count: Int = 0

    static func make() -> CounterViewController {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! CounterViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    @IBAction func tapIncrementButton(_ sender: Any) {
        count += 1
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(count)"
    }
}

