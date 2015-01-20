//
//  FirstViewController.m
//  BranchSDKTest
//
//  Created by Scott Hasbrouck on 1/19/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import "FirstViewController.h"
#import "Branch.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//get session params
- (IBAction)getSessionParams:(id)sender {
    NSDictionary *params = [[Branch getInstance] getLatestReferringParams];
    NSLog(@"Session params: %@", params);
}

- (IBAction)getInstallParams:(id)sender {
    NSDictionary *params = [[Branch getInstance] getFirstReferringParams];
    NSLog(@"Session params: %@", params);
}

- (IBAction)generateDeepLink:(id)sender {
    NSDictionary *installParams = [[Branch getInstance] getFirstReferringParams];
    NSString *user_id = [installParams objectForKey:@"user_id"];
    
    NSMutableDictionary *linkParams = [[NSMutableDictionary alloc] init];
    [linkParams setObject:user_id forKey:@"referrer_user_id"];
    
    [[Branch getInstance] getShortURLWithParams:linkParams andCallback:^(NSString *url, NSError *error) {
        NSLog(@"Deep link URL: %@", url);
    }];
}

//REWARDS

//Every acting user gets 5 points on each app open

- (IBAction)getRewardBalance:(id)sender {
    [[Branch getInstance] loadRewardsWithCallback:^(BOOL changed, NSError *error) {
        NSInteger credits = [[Branch getInstance] getCredits];
        
        NSLog(@"Point Balance: %ld", (long)credits);
    }];
}

- (IBAction)redeemFivePoints:(id)sender {
    [[Branch getInstance] redeemRewards:5];
    
    NSLog(@"5 points redeemed");
}

- (IBAction)getCreditHistory:(id)sender {
    [[Branch getInstance] getCreditHistoryWithCallback:^(NSArray *history, NSError *error) {
        if (!error) {
            NSLog(@"Credit History %@", history);
        }
    }];
}

//REFERRALS



@end
