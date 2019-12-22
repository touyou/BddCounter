//
//  CounterSpec.swift
//  BddCounterTests
//
//  Created by 藤井陽介 on 2019/12/11.
//  Copyright © 2019 touyou. All rights reserved.
//

import Quick
import Nimble
@testable import BddCounter

class CounterSpec: QuickSpec {
    override func spec() {
        describe("#init") {
            context("引数なしで初期化") {
                it("countが0であること") {
                    expect(Counter().count).to(equal(0))
                }
            }
            context("引数5で初期化") {
                it("countが5であること") {
                    expect(Counter(count: 5).count).to(equal(5))
                }
            }
        }
        
        describe("#increment / #decrement") {
            context("現在値が5") {
                var counter: Counter!
                
                beforeEach {
                    counter = Counter(count: 5)
                }
                
                it("incrementすると6になること") {
                    counter.increment()
                    expect(counter.count).to(equal(6))
                }
                it("decrementすると4になること") {
                    counter.decrement()
                    expect(counter.count).to(equal(4))
                }
            }
        }
        
        describe("#isLowerLimit") {
            context("現在値が0") {
                it("trueを返すこと") {
                    expect(Counter(count: 0).isLowerLimit).to(beTrue())
                }
            }
            context("現在値が1以上") {
                it("falseを返すこと") {
                    expect(Counter(count: 1).isLowerLimit).to(beFalse())
                }
            }
        }

        describe("#isUpperLimit") {
            context("現在値が10") {
                it("trueを返すこと") {
                    expect(Counter(count: 10).isUpperLimit).to(beTrue())
                }
            }
            context("現在値が10未満") {
                it("falseを返すこと") {
                    expect(Counter(count: 9).isUpperLimit).to(beFalse())
                }
            }
        }

        describe("永続化") {
            context("現在値が2") {
                var counter: Counter!
                var counterStorageMock: CounterStorageMock!

                beforeEach {
                    counterStorageMock = CounterStorageMock()
                    counter = Counter(count: 2, counterStorage: counterStorageMock)
                }

                context("#incrementを呼び出す") {
                    it("CounterStorage.save()が引数3で呼び出されること") {
                        counter.increment()

                        expect(counterStorageMock.latestSaveCount).to(equal(3))
                    }
                }

                context("#decrementを呼び出す") {
                    it("CounterStorage.save()が引数1で呼び出されること") {
                        counter.decrement()

                        expect(counterStorageMock.latestSaveCount).to(equal(1))
                    }
                }
            }
        }
    }
}
