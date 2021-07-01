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
        DispatchQueue.main.asyncAfter(deadline: 0.5) { [weak self] in
            self?.lb.text = "Done"
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
