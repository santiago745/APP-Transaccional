//
//  CustomRBStoryBoardLink.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/31/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "CustomRBStoryBoardLink.h"

@interface CustomRBStoryBoardLink ()

@end

@implementation CustomRBStoryBoardLink

-(void)awakeFromNib{
    if (IPAD) {
        self.storyboardName = [NSString stringWithFormat:@"%@%@",self.storyboardName,@"Ipad"];
    }
    
    [super awakeFromNib];
}

@end
