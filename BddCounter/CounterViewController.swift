//
//  ViewController.swift
//  BddCounter
//
//  Created by 藤井陽介 on 2019/12/10.
//  Copyright © 2019 touyou. All rights reserved.
//

import UIKit

protocol CounterStorage {
    func save(_ count: Int)
}

class CounterStorageMock: CounterStorage {
    var latestSaveCount: Int?

    func save(_ count: Int) {
        latestSaveCount = count
    }
}

class CounterStorageDefaults: CounterStorage {
    func save(_ count: Int) {
        UserDefaults.standard.set(count, forKey: "count")
    }
}

class Counter {
    private(set) var count: Int
    private let counterStorage: CounterStorage

    var isLowerLimit: Bool { return count == 0 }
    var isUpperLimit: Bool { return count == 10 }

    init(count: Int = 0, counterStorage: CounterStorage = CounterStorageDefaults()) {
        self.count = count
        self.counterStorage = counterStorage
    }

    func increment() {
        count += 1
        counterStorage.save(count)
    }

    func decrement() {
        count -= 1
        counterStorage.save(count)
    }
}

class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var counter = Counter()

    static func make() -> CounterViewController {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! CounterViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    @IBAction func tapIncrementButton(_ sender: Any) {
        counter.increment()
        updateView()
    }

    @IBAction func tapDecrementButton(_ sender: Any) {
        counter.decrement()
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(counter.count)"
        decrementButton.isEnabled = !counter.isLowerLimit
        incrementButton.isEnabled = !counter.isUpperLimit
    }
}

