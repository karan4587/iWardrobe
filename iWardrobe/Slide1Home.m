//
//  Slide1VC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 1/27/14.
//  Copyright (c) 2014 SocialObjects Software. All rights reserved.
//

#import "Slide1Home.h"
//#import "UIViewController+AMSlideMenu.h"
#import "UIColor+CreateMethods.h"
#import "homeCardCell.h"

@interface Slide1Home () //<UITableViewDataSource, UIAccelerometerDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (double) fact : (int) value;

@end

@implementation Slide1Home
{
    //NSInteger totalCardsLoadedIndex;
    //NSMutableArray *totalCards;
    UIImageView *leftSImage;
    UIImageView *rightPImage;
    NSString *aPath;
    NSArray* sArray;
    NSArray* pArray;
    NSString *favPath;
    NSMutableArray *favData;
    NSMutableDictionary *favPair;
    int maxCard;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        /*totalCards = [[NSMutableArray alloc] init];
        allCardsData = [[NSMutableArray alloc] init];
        totalCardsLoadedIndex = 0;*/
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadIntialData];
}

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
        NSArray *s1 = @[@"s0.jpg",@"s1.jpg",@"s2.jpg",@"s3.jpg",@"s4.jpg",@"s5.jpg"];
        NSArray *p1 = @[@"p0.jpg",@"p1.jpg",@"p2.jpg",@"p3.jpg",@"p4.jpg",@"p5.jpg"];
        NSArray *wardrobeData = [NSArray arrayWithObjects:s1,p1, nil];
        [data setObject:wardrobeData forKey:@"wardrobeData"];
        [data writeToFile:path atomically:YES];
    }
    
    favPath = [documentsDirectory stringByAppendingPathComponent:@"favourites.plist"];
    NSFileManager *favFileManager = [NSFileManager defaultManager];
    
    if (![favFileManager fileExistsAtPath: favPath]) {
        favPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"favourites.plist"] ];
    }
    
    NSMutableDictionary *favouriteData;
    
    if ([fileManager fileExistsAtPath: favPath]) {
        favouriteData = [[NSMutableDictionary alloc] initWithContentsOfFile:favPath];
    } else {
        favouriteData = [[NSMutableDictionary alloc] init];
        [favouriteData writeToFile:favPath atomically:YES];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *loadPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [loadPaths objectAtIndex:0];
    aPath = [documentsDirectory stringByAppendingPathComponent:@"itemsApparel.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: aPath]) {
        
        aPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"itemsApparel.plist"] ];
    }
    //Load the data from the plist and fill it
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: aPath];
    NSArray *value = (NSArray*)[savedValue objectForKey:@"wardrobeData"];
    
    sArray =  [value objectAtIndex:0];
    pArray = [value objectAtIndex:1];
    
    int total = (int)(sArray.count + pArray.count);
    //NSLog(@"Total : %i", total);
    maxCard = [self fact:total]/([self fact:2]*[self fact:total-2]);
    
    int topWearCombination = [self fact:(int)sArray.count]/([self fact:2]*[self fact:(int)sArray.count-2]);
    int bottomWearCombination = [self fact:(int)pArray.count]/([self fact:2]*[self fact:(int)pArray.count-2]);
    
    maxCard = maxCard - (topWearCombination + bottomWearCombination);
    //NSLog(@"maxCard : %i",maxCard);
    
    favData = [[NSMutableArray alloc]init];
    favPath = [documentsDirectory stringByAppendingPathComponent:@"favourites.plist"];
    NSFileManager *favFileManager = [NSFileManager defaultManager];
    
    if (![favFileManager fileExistsAtPath: favPath]) {
        
        favPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"favourites.plist"] ];
    }
    if ([fileManager fileExistsAtPath: favPath]) {
        favPair = [[NSMutableDictionary alloc] initWithContentsOfFile:favPath];
        [favData addObjectsFromArray:[favPair objectForKey:@"favWardrobeData"]];
    }
    
    //NSLog(@"return maxCard : %i", maxCard);
    return maxCard;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"homeCardCell"];
    
    if (cell == nil) {
        cell = [[homeCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCardCell"];
    }
    int sCount = (int)sArray.count;
    int bCount = (int)pArray.count;
    int randomShirt = arc4random() % sCount;
    int randomPant = arc4random() % bCount;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* sPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[sArray objectAtIndex:randomShirt]]];
    NSString* pPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[pArray objectAtIndex:randomPant]]];
    
    
    cell.leftSImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[sArray objectAtIndex:randomShirt]]];
    if(!cell.leftSImage.image)
    {
        cell.leftSImage.image = [UIImage imageWithContentsOfFile:sPath];
    }
    cell.rightPImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[pArray objectAtIndex:randomPant]]];
    if(!cell.rightPImage.image)
    {
        cell.rightPImage.image = [UIImage imageWithContentsOfFile:pPath];
    }
    
    return cell;
}

- (double) fact: (int) value {
    double result = 1;
    for (int i=2; i<=value; i++) {
        result *= (double)i;
    }
    return result;
}

// When User Selects Row that row Add it as Favourite
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIGraphicsBeginImageContext(cell.frame.size);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data=UIImagePNGRepresentation(viewImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *strPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"f%lu",(unsigned long)favData.count]];
    [data writeToFile:strPath atomically:YES];
    
    [favData addObject:[NSString stringWithFormat:@"f%lu.png",(unsigned long)favData.count]];
    [favPair setObject:favData forKey:@"favWardrobeData"];
    [favPair writeToFile:favPath atomically:YES];
    
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil message:@"Add as Favourite" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [toast show];
    int duration = 5;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
