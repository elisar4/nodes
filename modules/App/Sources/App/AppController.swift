// AppController.swift

import UIKit
import SwiftUI

public class AppController: UIViewController {

    lazy var rootController: UIViewController = {
        let controller = WorkspaceController()
        let debugController = DebugMenuController(workspace: controller)
        let mainView = MainView(controller: controller, debugController: debugController)
        return UIHostingController(rootView: mainView)
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hue: 0.2, saturation: 0, brightness: 0.2, alpha: 1)
        addChild(rootController)
        view.addSubview(rootController.view)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootController.view.frame = view.bounds
    }
}
