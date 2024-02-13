// AppController.swift

import UIKit
import SwiftUI

public class AppController: UIViewController {

    let sui = UIHostingController(rootView: SUITest())

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hue: 0.2, saturation: 0, brightness: 0.2, alpha: 1)
        addChild(sui)
        view.addSubview(sui.view)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sui.view.frame = view.bounds
    }
}
