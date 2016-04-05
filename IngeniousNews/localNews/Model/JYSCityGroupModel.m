//
//  JYSCityGroupModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSCityGroupModel.h"
#import "JYSCityMessageModel.h"
@implementation JYSCityGroupModel


-(void)setCitys:(NSMutableArray *)citys{
    
    _citys = [NSMutableArray new];
    for (NSDictionary *tempDic in citys) {
        JYSCityMessageModel *model = [JYSCityMessageModel cityMessageModelWithDic:tempDic];
        [_citys addObject:model];
    }
}

@end
