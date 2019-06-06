//
//  UIView+BK.m
//  MobileApp
//
//  Created by steven muñoz on 20/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "UIView+BK.h"

@implementation UIView (BK)
- (UIViewController *)findViewController {
    Class vcc = [UIViewController class];    // Called here to avoid calling it iteratively unnecessarily.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) if ([responder isKindOfClass: vcc]) return (UIViewController *)responder;
    return nil;
}

- (UINavigationBar *)navigationBarFromView {
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UINavigationBar  class]]) {
            return (UINavigationBar *)subview;
        }
        
        UIView *result = [subview navigationBarFromView];
        if (result) {
            return (UINavigationBar *)result;
        }
        
    }
    return nil;
}
@end
