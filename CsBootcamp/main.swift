import UIKit

class UnitTestAppDelegate: NSObject, UIApplicationDelegate {}

let argc = CommandLine.argc
let argv = CommandLine.unsafeArgv

#if TEST
    UIApplicationMain(argc, argv, nil, NSStringFromClass(UnitTestAppDelegate.self))
#else
    UIApplicationMain(argc, argv, nil, NSStringFromClass(AppDelegate.self))
#endif
