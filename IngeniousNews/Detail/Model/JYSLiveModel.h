//
//  JYSLiveModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSLiveModel : NSObject

//分组
@property(nonatomic,retain)NSArray *section;

@property(nonatomic,copy)NSString *bannerImageUrl;
/** 直播内容*/
@property(nonatomic,retain)NSMutableDictionary *messages;

+(instancetype)liveModelWithDic:(NSDictionary*)dic;

@end
