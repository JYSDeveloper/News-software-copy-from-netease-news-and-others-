//
//  JYSWebViewImgModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSWebViewImgModel.h"

@implementation JYSWebViewImgModel


+(instancetype)webViewImgWithDic:(NSDictionary *)dic{
    
    JYSWebViewImgModel *model = [JYSWebViewImgModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(instancetype)secondWebViewImgWithDic:(NSDictionary *)dic{
    
    JYSWebViewImgModel *model = [JYSWebViewImgModel new];
    model.src = dic[@"url"];
    model.width = dic[@"size"][@"width"];
    model.height = dic[@"size"][@"height"];
    return model;
    
}

@end
