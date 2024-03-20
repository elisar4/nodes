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

    func testWorkspace_InitWithOffset() throws {
        let sut = NodeLinkController()
        let state = WorkspaceState(offset: .init(x: 69, y: 69))

        sut.loadState(state)

        XCTAssertEqual(sut.workspaceDragOffset, state.offset)
    }

    func testWorkspace_SaveState() throws {
        let controller = NodeLinkController()
        let offset = CGPoint(x: 69, y: 69)
        controller.workspaceDragOffset = offset

        XCTAssertEqual(controller.currentWorkspaceState.offset, offset)
    }

    func testWorkspace_SaveNodes() throws {
        let controller = NodeLinkController()
        controller.nodes.append(contentsOf: [
            NodeType.allTypes.randomElement()!.type.init(),
            NodeType.allTypes.randomElement()!.type.init(),
            NodeType.allTypes.randomElement()!.type.init()
        ])
        
        XCTAssertEqual(controller.currentWorkspaceState.nodes.count, 3)
    }
    
    func testWorkspace_SaveNodesNew() throws {
        let controller = NodeLinkController()
        let displayNode = DisplayNode()
        displayNode.position = .init(x: 64, y: 64)
        controller.nodes.append(displayNode)
        
        let state = controller.currentWorkspaceState
        
        displayNode.position = .init(x: 100, y: 100)
        
        XCTAssertEqual(state.nodes.first?.position, .init(x: 64, y: 64))
    }

    func testWorkspace_SaveLinks() throws {
        let controller = NodeLinkController()
        controller.links.append(contentsOf: [
            Link(from: .constant(.zero), to: .constant(.zero), fromId: "", toId: "", toPosition: 0),
            Link(from: .constant(.zero), to: .constant(.zero), fromId: "", toId: "", toPosition: 0)
        ])

        XCTAssertEqual(controller.currentWorkspaceState.links.count, 2)
    }

    func testWorkspace_InitWithNodes() throws {
        let sut = NodeLinkController()
        let state = WorkspaceState(nodes: [
            NodeType.allTypes.randomElement()!.type.init(),
            NodeType.allTypes.randomElement()!.type.init(),
            NodeType.allTypes.randomElement()!.type.init()
        ])

        sut.loadState(state)

        XCTAssertEqual(sut.nodes.count, state.nodes.count)
    }

    func testWorkspace_InitWithNodes_CheckEqualIDs() throws {
        let sut = NodeLinkController()
        let node1 = RandomLetterNode()
        let state = WorkspaceState(nodes: [
            node1
        ])

        sut.loadState(state)

        XCTAssertEqual(sut.nodes.first!.id, node1.id)
        XCTAssertEqual(sut.nodes.first!.name, node1.name)
        XCTAssertEqual(sut.nodes.first!.position, node1.position)
//        XCTAssertEqual(sut.nodes.first!.type, node1.self)
    }
}
