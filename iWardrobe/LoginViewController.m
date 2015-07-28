//
//  LoginViewController.m
//  iWardrobe
//
//  Created by Karan on 27/07/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, Lets go on our home screen
        [self performSegueWithIdentifier: @"showMainVC" sender: self];
    } else {
        [self.FBLogin setDelegate:self];
        self.FBLogin.readPermissions = @[@"public_profile", @"email"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error){
        // Process error
    } else if (result.isCancelled){
        // Handle cancellations
        NSLog(@"User press cancel button!");
    } else {
        // If you ask for multiple permissions at once, you
        // should check if specific permissions missing
        if ([result.grantedPermissions containsObject:@"email"]) {
            // Do work
            NSLog(@"User logged in successfully! :)");
            [self performSegueWithIdentifier: @"showMainVC" sender: self];
        }
    }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // Put your logout logic here. We are not doing that for now.
    NSLog(@"User logged out! :(");
}

@end
