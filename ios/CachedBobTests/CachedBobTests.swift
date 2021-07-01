//
//  CachedBobTests.swift
//  CachedBobTests
//
//  Created by Kenneth Dubroff on 7/1/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

import XCTest

class CachedBobTests: XCTestCase {
    func testCachedBob_doesNot_leak() {
        let bob = BobSpy()
        // do some async function that captures self using bob
        bob.mockRetain()
        assertNoMemoryLeak(bob)
    }
    
}

class BobSpy: CachedBobImageView {
    func mockRetain() {
        progressCallback = { pr, size, url in
            
            let percent: Double = Double(pr) * 100 / Double(size)
            let a: Double = 360 / 100 * percent
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 { [weak self] in
                self?.progress.animate(toAngle: a, duration: 0.1, completion: nil)
            }
        }
    }
}

extension XCTestCase {
    // Credit: https://www.essentialdeveloper.com/
    func assertNoMemoryLeak(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential retain cycle.", file: file, line: line)
        }
    }
}
