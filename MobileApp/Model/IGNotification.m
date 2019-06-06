//
//  IGNotification.m
//  salesforce
//
//  Created by Armando Restrepo on 2/13/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import "IGNotification.h"

@implementation IGNotification

+(void) showNotification:(NSError *)error
                   title:(NSString *)title
                subtitle:(NSString *)subtitle
                 andType:(TSMessageNotificationType)type{

     UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    [TSMessage dismissActiveNotification];
    if (!error){
        [TSMessage showNotificationInViewController:controller title:title subtitle:subtitle type:type];
        
    }else{
        [TSMessage showNotificationInViewController:controller title:error.localizedRecoverySuggestion subtitle:[NSString stringWithFormat:IGErrorTitleCodeFormat, error.code] type:type];
    }

}

@end
