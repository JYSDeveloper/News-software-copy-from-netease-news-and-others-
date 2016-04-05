//
//  JYSImageShowModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSImageShowModel.h"

@implementation JYSImageShowModel


+(instancetype)imageShowModelWithDic:(NSDictionary *)dic{
    
    JYSImageShowModel *model = [JYSImageShowModel new];
    model.imgurl = dic[@"imgurl"];
    model.note = dic[@"note"];
    
    return model;
}

@end
