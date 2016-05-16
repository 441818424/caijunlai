//
//  TRDataManager.h
//  GCD应用
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRAlbum.h"
@interface TRDataManager : NSObject

+(NSArray*)getAlbums;

- (NSData *)getImagesData:(NSString *)urlStr;

+ (id)sharedDataManager;
@end
