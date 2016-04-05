//
//  JYSListenDetailModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSListenDetailModel : NSObject


@property(nonatomic,copy)NSString *post_title;

@property(nonatomic,copy)NSString *post_date;

@property(nonatomic,copy)NSString *post_lai;

@property(nonatomic,copy)NSString *post_excerpt;

@property(nonatomic,copy)NSString *smeta;

+(instancetype)listenDetailModelWithDic:(NSDictionary*)dic;
@end
