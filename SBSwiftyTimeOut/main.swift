



import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(SBTimeOut.self),
    NSStringFromClass(AppDelegate.self)
)

//UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(SBTimeOut), NSStringFromClass(AppDelegate))

