//
//  IGLoginTableViewCell.h
//  MobileApp
//
//  Created by Rober on 2/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGLoginTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageItemImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleItemLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionItemLabel;

@end
