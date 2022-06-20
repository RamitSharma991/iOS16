//
//  SwiftGenerics.swift
//  Generics
//
//  Created by Ramit Sharma on 20/06/22.
//

import Foundation

protocol iOSDevt {
    associatedtype MachineType: Machine where MachineType.MacType == Self
    static func process() -> MachineType
}

protocol Machine {
    associatedtype MacType: iOSDevt where MacType.MachineType == Self
    func compile() -> MacType
}

protocol DevLang {
    associatedtype Mactype: iOSDevt
    func run(_ product: Mactype)
}


struct AppDevt {
    func macType(_ swiftLang: some DevLang) {
        let iosDevt = type(of: swiftLang).Mactype.process()
        let app = iosDevt.compile()
        swiftLang.run(app)
    }
    func runAll(_ iosDevLang: [any DevLang]) {
        for devtLang in iosDevLang {
            macType(devtLang)
        }
    }
}

struct iosApps: DevLang {
    func run(_ product: MacPro) {}
}

struct MacPro: iOSDevt {
    static func process() -> AppleSilicon {
        AppleSilicon()
    }
}

struct AppleSilicon: Machine {
    func compile() -> MacPro {
        MacPro()
    }
}
