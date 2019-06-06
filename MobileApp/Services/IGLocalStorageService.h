//
//  IGLocalStorageService.h
//  salesforce
//
//  Created by Armando Restrepo on 12/3/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGLocalStorageService : NSObject

+ (id) sharedInstance;

- (id)getFileFrom:(NSString *)path;

- (void)save:(id)object To:(NSString *)path;

- (id)getImageFromFile:(NSString *)path;

- (void)saveImage:(id)image ToFile:(NSString *)path;

- (BOOL)deleteFile:(NSString *)fileName error:(NSError **)err;

@end