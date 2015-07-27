//
//  LoginViewController.h
//  iWardrobe
//
//  Created by Karan on 27/07/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *FBLogin;

@end

