//
//  AppDelegate.swift
//  HBook
//
//  Created by 臧乾坤 on 2017/4/23.
//  Copyright © 2017年 臧乾坤. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /**
         设置share SDK
         **/
        ShareSDK.registerApp("1d731f9367e10", activePlatforms: [SSDKPlatformType.typeWechat.rawValue,SSDKPlatformType.typeQQ.rawValue,SSDKPlatformType.typeSinaWeibo.rawValue], onImport: { (platform : SSDKPlatformType) in
            
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
            case SSDKPlatformType.typeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
            case SSDKPlatformType.typeQQ:
                ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
            default:
                break
            }
            
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                appInfo?.ssdkSetupSinaWeibo(byAppKey: "568898243",
                                            appSecret : "38a4f8204cc784f81f9f0daaf31e02e3",
                                            redirectUri : "https://baidu.com",
                                            authType : SSDKAuthTypeBoth)
                
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "wx4868b35061f87885", appSecret: "64020361b8ec4c99936c0e3999a9f249")
                
            case SSDKPlatformType.typeTencentWeibo:
                //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                appInfo?.ssdkSetupTencentWeibo(byAppKey: "801307650",
                                               appSecret : "ae36f4ee3946e1cbb98d6965b0b2ff5c",
                                               redirectUri : "https://baidu.com")
            case SSDKPlatformType.typeQQ:
                //设置QQ应用信息
                appInfo?.ssdkSetupQQ(byAppId: "100371282",
                                     appKey : "aed9b0303e3ed1e27bae87c33761161d",
                                     authType : SSDKAuthTypeWeb)
            default:
                break
            }
        }
        
        /**
         设置LeanCloud
         **/
        AVOSCloud.setApplicationId("F1h5zCwUrhTIbhslYLi6bnjq-gzGzoHsz", clientKey: "JhKrddqmavt3aCT9NguCcQhP")
        
        self.window = UIWindow(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT))
        
        let tabbarController = UITabBarController()
        
        let searchController = UINavigationController(rootViewController:searchViewController())
        let rankController = UINavigationController(rootViewController:rankViewController())
        let pushController = UINavigationController(rootViewController:pushViewController())
        let circleController = UINavigationController(rootViewController:circleViewController())
        let moreController = UINavigationController(rootViewController:moreViewController())
        
        tabbarController.viewControllers = [rankController,searchController,pushController,circleController,moreController]
        
        let tabbarItem1 = UITabBarItem(title:"排行榜",image:UIImage(named:"bio"),selectedImage:UIImage(named:"bio_red"))
        let tabbarItem2 = UITabBarItem(title:"发现",image:UIImage(named:"timer 2"),selectedImage:UIImage(named:"timer 2"))
        let tabbarItem3 = UITabBarItem(title:"",image:UIImage(named:"pencil"),selectedImage:UIImage(named:"pencil_red"))
        let tabbarItem4 = UITabBarItem(title:"圈子",image:UIImage(named:"users two-2"),selectedImage:UIImage(named:"users two-2_red"))
        let tabbarItem5 = UITabBarItem(title:"更多",image:UIImage(named:"more"),selectedImage:UIImage(named:"more"))
        
        rankController.tabBarItem = tabbarItem1
        searchController.tabBarItem = tabbarItem2
        pushController.tabBarItem = tabbarItem3
        circleController.tabBarItem = tabbarItem4
        moreController.tabBarItem = tabbarItem5
        
        rankController.tabBarController?.tabBar.tintColor = MAIN_RED
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()

        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

