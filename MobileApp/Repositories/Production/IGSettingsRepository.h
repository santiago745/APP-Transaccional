//
//  IGSettingsRepository.h
//  salesforce
//
//  Created by Armando Restrepo on 1/13/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import "IGISettingsRepository.h"

@interface IGSettingsRepository : NSObject<IGISettingsRepository>

+(id) sharedInstance;

@end
