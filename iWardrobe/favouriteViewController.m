//
//  favouriteViewController.m
//  iWardrobe
//
//  Created by Karan on 09/08/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import "favouriteViewController.h"

@interface favouriteViewController()
{
    NSArray *favData;
}

@end

@implementation favouriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"favourites.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) {
        
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"favourites.plist"] ];
    }
    //Load the data from the plist and fill it
    NSMutableDictionary *data;
    if ([fileManager fileExistsAtPath: path]) {
        data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
    }
    favData = [NSArray arrayWithArray:[data valueForKey:@"favWardrobeData"]];
    
    return favData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *favCell = [self.tableView dequeueReusableCellWithIdentifier:@"favCell" forIndexPath:indexPath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",
                                                                         [favData objectAtIndex:indexPath.row]] ];
    
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    UIImageView *favImage = (UIImageView *)[favCell viewWithTag:100];
    favImage.image = image;
    
    return favCell;
}

@end


