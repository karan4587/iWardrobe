//
//  apparelViewController.m
//  iWardrobe
//
//  Created by Karan on 01/08/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import "apparelViewController.h"

@interface apparelViewController () {
    NSArray *headerData;
    NSString *imageData;
    NSString *documentPath;
}
@end

@implementation apparelCollectionHeaderView

@synthesize addApparel;
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}

@end

@implementation apparelViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

@end

@implementation apparelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerData = [[NSArray alloc]initWithObjects:@"Shirt",@"Trouser", nil];
    
    UICollectionViewFlowLayout *collectionView = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionView.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    [self loadCollectionView];
}

- (void) loadCollectionView {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentPath = [documentsDirectory stringByAppendingPathComponent:@"itemsApparel.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: documentPath]) {
        
        documentPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"itemsApparel.plist"] ];
    }
    
    NSMutableDictionary *aData;
    
    if ([fileManager fileExistsAtPath: documentPath]) {
        //NSLog(@"FILE EXISTS!");
        aData = [[NSMutableDictionary alloc] initWithContentsOfFile: documentPath];
        
        NSArray *wardrobeValue = (NSArray*)[aData objectForKey:@"wardrobeData"];
        self.shirtCollectionArray = [NSArray arrayWithArray:[wardrobeValue objectAtIndex:0]];
        //NSLog(@"%@",self.shirtCollectionArray);
        self.pantCollectionArray = [NSArray arrayWithArray:[wardrobeValue objectAtIndex:1]];
        //NSLog(@"%@",self.pantCollectionArray);
        self.shirtAndPantCollectionArray = [[NSArray alloc] initWithObjects:self.shirtCollectionArray, self.pantCollectionArray, nil];
        NSLog(@"%@",self.shirtAndPantCollectionArray);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.shirtAndPantCollectionArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.shirtAndPantCollectionArray count];
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *resuableView = nil;
    
    if(kind == UICollectionElementKindSectionHeader) {
        apparelCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"apparelHeaderView" forIndexPath:indexPath];
        
        NSString *title = [[NSString alloc]initWithFormat:@"%@", [headerData objectAtIndex:indexPath.section]];
        headerView.headerTitle.text = title;
        NSString *addBtnId = [[NSString alloc] initWithFormat:@"Add %@", [headerData objectAtIndex:indexPath.section]];
        [headerView.addApparel setTitle:addBtnId forState:UIControlStateNormal];
        resuableView = headerView;
    }
    return resuableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    apparelViewCell *cell = (apparelViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *apparelImage = (UIImageView *)[cell viewWithTag:100];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *_path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@", [_shirtAndPantCollectionArray [indexPath.section] objectAtIndex:indexPath.row]]];
    UIImage *myImage = [UIImage imageWithContentsOfFile:_path];
    //NSLog(@"%@", myImage);
    
    if(!myImage) {
        apparelImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [_shirtAndPantCollectionArray [indexPath.section] objectAtIndex:indexPath.row]]];
        //NSLog(@"%@", [UIImage imageNamed:[NSString stringWithFormat:@"%@", [_shirtAndPantCollectionArray [indexPath.section] objectAtIndex:indexPath.row]]]);
    } else {
        apparelImage.image = [UIImage imageWithContentsOfFile:_path];
    }
    
    return cell;
}

- (IBAction)openPhotoGallery:(UIButton *)sender {
    imageData = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imgPicker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    //NSLog(@"%@",selectedImage);
    
    NSData *imgData = UIImagePNGRepresentation(selectedImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([imageData isEqual: @"Add Shirt"]) {
        NSString *strPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"myshirt%lu.png",(unsigned long) self.shirtCollectionArray.count]];
        [imgData writeToFile:strPath atomically:YES];
        
        NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
        NSMutableArray *newShirtArray = [NSMutableArray arrayWithArray:self.shirtCollectionArray];
        [newShirtArray addObject:[NSString stringWithFormat:@"s%lu.png",(unsigned long) self.shirtCollectionArray.count]];
        NSArray *wardrobeData = [NSArray arrayWithObjects:newShirtArray,self.pantCollectionArray, nil];
        [newData setObject:wardrobeData forKey:@"wardrobeData"];
        [newData writeToFile:documentPath atomically:YES];
    } else if ([imageData isEqual: @"Add Trouser"]) {
         NSString* strPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"mypant%lu.png",(unsigned long) self.pantCollectionArray.count]];
        [imgData writeToFile:strPath atomically:YES];
        
        NSMutableDictionary *newData = [[NSMutableDictionary alloc]init];
        NSMutableArray *newPantArray = [NSMutableArray arrayWithArray:self.pantCollectionArray];
        [newPantArray addObject:[NSString stringWithFormat:@"p%lu.png",(unsigned long) self.pantCollectionArray.count]];
        NSArray *wardrobeData = [NSArray arrayWithObjects:self.shirtCollectionArray, newPantArray, nil];
        [newData setObject:wardrobeData forKey:@"wardrobeData"];
        [newData writeToFile:documentPath atomically:YES];
        
    }
    [self loadCollectionView];
    [self.collectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end