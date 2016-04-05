//
//  JYSLiveMessageImage.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSLiveMessageImage : NSObject

@property(nonatomic,copy)NSString *fullSizeSrc;

@property(nonatomic,copy)NSString *src;

@property(nonatomic,copy)NSString *fullSrcSize;

@property(nonatomic,copy)NSString *href;

+(instancetype)liveMessageImageWithDic:(NSDictionary*)dic;

@end
