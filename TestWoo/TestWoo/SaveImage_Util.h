//
//  SaveImage_Util.h
//  TestWoo
//
//  Created by 吴远锋 on 2017/6/5.
//  Copyright © 2017年 Wuyuanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SaveImage_Util : NSObject

+(BOOL)saveImage:(UIImage *)saveImage ImageName:(NSString *)imageName back:(void(^)(NSString *imageName))back;



@end
