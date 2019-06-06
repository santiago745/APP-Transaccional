//
//  IGLoginTableViewCell.m
//  MobileApp
//
//  Created by Rober on 2/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGLoginTableViewCell.h"

@implementation IGLoginTableViewCell

@synthesize imageItemImageView = _imageItemImageView;
@synthesize titleItemLabel = _titleItem;
@synthesize descriptionItemLabel = _descriptionItemLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
