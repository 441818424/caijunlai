//
//  TRDataManager.m
//  GCD应用
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDataManager.h"
@interface TRDataManager()


@property (nonatomic,strong) NSMutableDictionary *imageDataDic;
//@property (nonatomic,strong) NSData *imageData;
@end



@implementation TRDataManager
-(NSMutableDictionary *)imageDataDic{
    if (!_imageDataDic) {
        _imageDataDic = [NSMutableDictionary dictionary];
    }
    return _imageDataDic;
}

+(NSArray*)getAlbums{
    NSString *albumsPath = [[NSBundle mainBundle] pathForResource:@"albums.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:albumsPath];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        TRAlbum *album = [[TRAlbum alloc] init];
        [album setValuesForKeysWithDictionary:dict];
        [arrayM addObject:album];
    }
    return [arrayM copy];
}
//生成imageData 返回
- (NSData *)getImagesData:(NSString *)urlStr{
   NSData *imageData = self.imageDataDic[urlStr];
    if (imageData) {
        return imageData;
    }else{
        NSString *fileName = [urlStr lastPathComponent];
        NSString *filePath = [self generateFilePath:fileName];
        NSData *imageFromFile = [NSData dataWithContentsOfFile:filePath];
        if (imageFromFile) {
            return imageFromFile;
        }else{
            return [self downLoadImages:urlStr];
        }
    }
}
//下载图片 保存到字典和沙盒中
- (NSData *)downLoadImages:(NSString *)urlStr{

        NSURL *imageUrl = [NSURL URLWithString:urlStr];
       NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        //存入字典中
        self.imageDataDic[urlStr] = imageData;
        //存入沙盒中
        NSString *filePath = [self generateFilePath:[urlStr lastPathComponent]];
        [imageData writeToFile:filePath atomically:YES];
   
      return imageData;

}


//生成存入的文件目录
- (NSString *)generateFilePath:(NSString *)fileName{
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [cachesPath stringByAppendingPathComponent:fileName];

}

//单例工具类
static TRDataManager *_datamanager = nil;
+ (id)sharedDataManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _datamanager = [[TRDataManager alloc] init];
    });
    return _datamanager;
}


@end
