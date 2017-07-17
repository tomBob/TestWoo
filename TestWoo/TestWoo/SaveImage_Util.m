//
//  SaveImage_Util.m
//  TestWoo
//
//  Created by 吴远锋 on 2017/6/5.
//  Copyright © 2017年 Wuyuanfeng. All rights reserved.
//

#import "SaveImage_Util.h"

@implementation SaveImage_Util

+(BOOL)saveImage:(UIImage *)saveImage ImageName:(NSString *)imageName back:(void(^)(NSString *imageName))back
{
    NSString *path =  [self getImageDocumentFolderPath];
    NSData *imageData = UIImagePNGRepresentation(saveImage);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/",path];
    
    NSString *imageFile = [documentsDirectory stringByAppendingString:imageName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL bRect = [fileManager fileExistsAtPath:imageFile];
    
    if (bRect) {
        
        NSLog(@"文件已存在");
        
        if ([fileManager removeItemAtPath:imageFile error:nil]) {
            
            NSLog(@"删除文件成功");
            
            if ([imageData writeToFile:imageFile atomically:YES]) {
                
                NSLog(@"保存文件成功");
                
                back(imageFile);
            }
            
        }else
        {
            
        }
        
    }else
    {
        if (![imageData writeToFile:imageFile atomically:NO]) {
            
            [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            
            if ([imageData writeToFile:imageFile atomically:YES]) {
                
                back(imageFile);
                
            }
            
            
        }else
        {
            return YES;
        }
    }
    
    return NO;
    
}


+(NSString *)getImageDocumentFolderPath
{
    NSString *pathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [NSString stringWithFormat:@"%@/Images",pathDocument];
    
}



@end
