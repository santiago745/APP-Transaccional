//
//  IGISettingsRepository.h
//  salesforce
//
//  Created by Armando Restrepo on 1/13/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IGISettingsRepository<NSObject>

@required

-(NSDictionary*) getSettings;

@end
