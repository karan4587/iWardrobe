//
//  apparelViewController.h
//  iWardrobe
//
//  Created by Karan on 01/08/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface apparelViewController : UICollectionViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *shirtCollectionArray;
@property (nonatomic, strong) NSArray *pantCollectionArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, retain) NSArray *shirtAndPantCollectionArray;

@end

@interface apparelCollectionHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIButton *addApparel;

@end

@interface apparelViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *apparelImage;

@end
