//
//  homeCardCell.m
//  iWardrobe
//
//  Created by Karan on 07/08/15.
//  Copyright (c) 2015 Karan. All rights reserved.
//

#import "homeCardCell.h"

@implementation homeCardCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews
{
    [self cardSetup];
}

- (void)cardSetup
{
    [self.cardView setAlpha:1];
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.cornerRadius = 1;   // To make rounded corners
    self.cardView.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    self.cardView.layer.shadowRadius = 1;
    self.cardView.layer.shadowOpacity = 0.2;
}

@end