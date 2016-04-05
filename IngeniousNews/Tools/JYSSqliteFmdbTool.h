//
//  JYSSqliteFmdbTool.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/11.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSSqliteFmdbTool : NSObject
+(NSMutableArray*)selectedChannels;
+(void)delectedAll;
+(void)addChannelWithDic:(NSDictionary*)dic;
+(void)addChannelsWithArr:(NSMutableArray*)arr;
@end
