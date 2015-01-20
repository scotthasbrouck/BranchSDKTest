//
//  AppDelegate.m
//  BranchSDKTest
//
//  Created by Scott Hasbrouck on 1/19/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import "AppDelegate.h"
#import "Branch.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Branch *branch = [Branch getInstance:@"84499351119855798"];
    [branch initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary *params, NSError *error) {
        
        NSString *f_name = [params objectForKey:@"f_name"];
        NSString *l_name = [params objectForKey:@"l_name"];
        NSString *user_id = [params objectForKey:@"user_id"];
        
        NSLog(@"First name: %@", f_name);
        NSLog(@"Last name: %@", l_name);
        NSLog(@"User ID: %@", user_id);
        
        [[Branch getInstance] setIdentity:user_id];
    }];
    
    //set userid from install
    NSDictionary *installParams = [[Branch getInstance] getFirstReferringParams];
    NSString *user_id = [installParams objectForKey:@"user_id"];
    [[Branch getInstance] setIdentity:user_id];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //test signout
    
    [[Branch getInstance] logout];
    NSLog(@"Logged out");
}

@end
