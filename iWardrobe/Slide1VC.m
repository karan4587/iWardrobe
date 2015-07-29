//
//  Slide1VC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 1/27/14.
//  Copyright (c) 2014 SocialObjects Software. All rights reserved.
//

#import "Slide1VC.h"
//#import "UIViewController+AMSlideMenu.h"
#import "UIColor+CreateMethods.h"

@interface Slide1VC () //<UITableViewDataSource, UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Slide1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadIntialData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Setting navigation's bar tint color
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"#C555DC" alpha:1];
}

/*#pragma mark - TableView Deletage and Datasouce methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"Test swipe to delete functionality";
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

    }
}*/

- (void) loadIntialData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"itemsApparel.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) {
        
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"itemsApparel.plist"] ];
    }
    
    NSMutableDictionary *data;
    
    if ([fileManager fileExistsAtPath: path]) {
        NSLog(@"FILE EXISTS!");
        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    }
    else {
        NSLog(@"FILE NOT EXISTS!");
        // If the file doesn’t exist, create an empty dictionary
        data = [[NSMutableDictionary alloc] init];
        // Fill the empty array with our dummy data
        NSArray *shirt = @[@"Shirt1.jpg",@"Shirt2.jpg",@"Shirt3.jpg",@"Shirt4.jpg",@"Shirt5.jpg",@"Shirt6.jpg"];
        NSArray *pant = @[@"J1.jpg",@"J2.jpg",@"J3.jpg",@"J4.png",@"J5.jpg",@"J6.jpg"];
        NSArray *combineData = [NSArray arrayWithObjects:shirt,pant, nil];
        [data setObject:combineData forKey:@"combineData"];
        [data writeToFile:path atomically:YES];
    }
}

@end
