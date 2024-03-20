//  WorkspaceStateTests.swift
//  Created by Vladimir Roganov on 20.03.2024

import XCTest
@testable import App

class WorkspaceStateTests: XCTestCase {

    func testWorkspace_InitWithEmptyState() throws {
        let sut = NodeLinkController()
        
        XCTAssertEqual(sut.links.count, 0)
        XCTAssertEqual(sut.nodes.count, 0)
        XCTAssertEqual(sut.workspaceDragOffset, .zero)
    }

}
