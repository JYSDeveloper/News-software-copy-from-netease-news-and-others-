//
//  JYSLiveMessageImage.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLiveMessageImage.h"

@implementation JYSLiveMessageImage


+(instancetype)liveMessageImageWithDic:(NSDictionary *)dic{
    JYSLiveMessageImage *model = [JYSLiveMessageImage new];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

@end
