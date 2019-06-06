//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expanded = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isExpanded) {
        
        if (![self containsIndicatorView])
            [self addIndicatorView];
        else {
            [self removeIndicatorView];
            [self addIndicatorView];
        }
    }
    
    if (self.imageView.image != nil) {
        if (self.textLabel.text.length > 30) {
            self.textLabel.frame = CGRectMake(50, 0, 230, 45);
            self.textLabel.numberOfLines = 0;
            self.detailTextLabel.frame = CGRectMake(50, 43, 230, 20);
        }
    } else {
        self.textLabel.frame = CGRectMake(16, 0, 230, 45);
        self.textLabel.numberOfLines = 0;
    }
    
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"more"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setExpandable:(BOOL)isExpandable
{
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    
    _expandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    /*if(selected) {
        
        self.backgroundColor = OM_COLORS_LIGHTGREEN;
    }*/
    [super setSelected:NO animated:NO];
}


- (void)addIndicatorView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    SKSTableViewCellIndicator *indicatorView = [[SKSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    self.backgroundColor = OM_COLOR_CELL_SELECTION_GREEN;
    [self.contentView addSubview:indicatorView];
    //self.contentView.backgroundColor = OM_COLORS_LIGHTGREEN;
}

- (void)removeIndicatorView
{
    self.backgroundColor = [UIColor whiteColor];
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView)
    {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation
{
    if (!self.isExpanded)
        [self removeIndicatorView];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isExpanded) {
            UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"less"]];
            self.accessoryView = arrow;
            self.accessoryView.backgroundColor = OM_COLOR_CELL_SELECTION_GREEN;
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
           
            UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
            self.accessoryView = arrow;
            self.accessoryView.backgroundColor = [UIColor whiteColor];
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    } completion:^(BOOL finished) {
        
        /*if (!self.isExpanded)
            [self removeIndicatorView];*/
        
    }];
}

@end
