//
//  CounterViewControllerSpec.swift
//  BddCounterTests
//
//  Created by 藤井陽介 on 2019/12/10.
//  Copyright © 2019 touyou. All rights reserved.
//

import Quick
import Nimble
@testable import BddCounter

extension UIButton {
    func tap(repeat: Int = 1) {
        for _ in 1...`repeat` {
            self.sendActions(for: .touchUpInside)
        }
    }
}

class CounterViewControllerSpec: QuickSpec {
    override func spec() {
        var vc: CounterViewController!

        beforeEach {
            vc = CounterViewController.make()
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }

        describe("初期表示") {
            it("カウントが0であること") {
                expect(vc.countLabel.text).to(equal("0"))
            }

            it("ーがボタンが非活性であること") {
                expect(vc.decrementButton.isEnabled).to(beFalse())
            }
        }

        describe("＋ボタンをタップ") {
            context("現在地が0") {
                it("カウンタが1に増えること") {
                    vc.incrementButton.tap()
                    expect(vc.countLabel.text).to(equal("1"))
                }

                it("下限値でなくなるのでーボタンが活性になること") {
                    vc.incrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beTrue())
                }
            }

            context("上限値に達した場合") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                }

                it("上限値なので＋ボタンが非活性になること") {
                    expect(vc.countLabel.text).to(equal("10"))
                    expect(vc.incrementButton.isEnabled).to(beFalse())
                }
            }
        }

        describe("ーボタンをタップ") {
            context("現在値が1") {
                beforeEach {
                    vc.incrementButton.tap()
                }

                it("カウンタが0に減ること") {
                    vc.decrementButton.tap()
                    expect(vc.countLabel.text).to(equal("0"))
                }

                it("下限値になるのでーボタンが非活性になること") {
                    vc.decrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beFalse())
                }
            }

            context("現在値が10（上限値）") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                    vc.decrementButton.tap()
                }

                it("カウントが9に減ること") {
                    expect(vc.countLabel.text).to(equal("9"))
                }
                it("上限値でなくなるので＋ボタンが活性になること") {
                    expect(vc.incrementButton.isEnabled).to(beTrue())
                }
            }
        }

        describe("現在値の保存") {
            context("現在値が2") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 2)
                    UserDefaults.standard.set(0, forKey: "count")
                }

                context("＋ボタンをタップ") {
                    it("現在値3がUserDefaultsに保存されること") {
                        vc.incrementButton.tap()

                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(3))
                    }
                }

                context("ーボタンをタップ") {
                    it("現在値1がUserDefaultsに保存されること") {
                        vc.decrementButton.tap()

                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(1))
                    }
                }
            }
        }
    }
}
