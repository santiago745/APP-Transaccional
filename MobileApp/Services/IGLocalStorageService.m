//
//  IGLocalStorageService.m
//  salesforce
//
//  Created by Armando Restrepo on 12/3/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGLocalStorageService.h"

@implementation IGLocalStorageService

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


- (id) init {
    if (_sharedInstance){
        return _sharedInstance;
    }
    else{
        if (self = [super init]){
            //init properties
        }
        return self;
    }
}

- (id)getFileFrom:(NSString *)path{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *myFilePath = [documentDirectory stringByAppendingPathComponent:path];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:myFilePath];
}

- (void)save:(id)object To:(NSString *)path{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *myFilePath = [documentDirectory stringByAppendingPathComponent:path];
    
    [NSKeyedArchiver archiveRootObject:object toFile:myFilePath];
}

- (BOOL)deleteFile:(NSString *)fileName error:(NSError **)err{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *myFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    if([fm fileExistsAtPath:myFilePath]){
        return [fm removeItemAtPath:myFilePath error:err];
    }
    return NO;
}

- (id)getImageFromFile:(NSString *)path{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *myFilePath = [documentDirectory stringByAppendingPathComponent:path];
    return [UIImage imageNamed:myFilePath];
}

- (void)saveImage:(id)image ToFile:(NSString *)path{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *myFilePath = [documentDirectory stringByAppendingPathComponent:path];
    [UIImagePNGRepresentation(image) writeToFile:myFilePath atomically:YES];
}

@end
