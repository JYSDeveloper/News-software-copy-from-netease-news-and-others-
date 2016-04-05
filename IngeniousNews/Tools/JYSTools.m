//
//  JYSTools.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTools.h"

@implementation JYSTools

+(UILabel *)titleLableWithFrame:(CGRect)frame{
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:frame];
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont systemFontOfSize:15];
    
    
    return titleLable;
}

+(UILabel *)digestLableWithFrame:(CGRect)frame{
    
    UILabel *digestLable = [[UILabel alloc]initWithFrame:frame];
    digestLable.textColor = [UIColor grayColor];
    digestLable.font = [UIFont systemFontOfSize:12];
    digestLable.numberOfLines = 0;
    return digestLable;
}

+(UILabel *)replyCountLableWithFrame:(CGRect)frame {
    
    UILabel *replyLable = [[UILabel alloc]initWithFrame:frame];
    replyLable.textColor = [UIColor grayColor];
    replyLable.font = [UIFont systemFontOfSize:12];
    replyLable.numberOfLines = 0;
    replyLable.layer.borderWidth = 1;
    replyLable.layer.cornerRadius = 8;
    replyLable.layer.borderColor = [UIColor colorWithWhite:0.808 alpha:1.000].CGColor;
    replyLable.textAlignment = NSTextAlignmentCenter;
    return replyLable;
}

+(void)replyCountLableWidth:(NSNumber *)data Height:(CGFloat)height font:(CGFloat)font view:(UILabel *)lable{
//    if (data.integerValue > 10000) {
//        text = [NSString stringWithFormat:@"%.1f万跟帖",data.doubleValue/10000];
//    }
//    else if (data == nil){
////        text = [NSString stringWithFormat:@"直播"];
////        lable.textColor = [UIColor blueColor];
//        [lable removeFromSuperview];
//    }
//    else{
//        text = [NSString stringWithFormat:@"%@跟帖",data];
//
//    }
    lable.text = [self replyCountText:data];
    CGRect rect = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    rect.size.width = rect.size.width+10;
    rect.origin.x = UISCREENWIDTH-10-rect.size.width;
    rect.origin.y = lable.frame.origin.y;
    lable.frame = rect;
}
+(NSString*)replyCountText:(NSNumber*)data{
    if (data.integerValue > 10000) {
        return [NSString stringWithFormat:@"%.1f万跟帖",data.doubleValue/10000];
    }
    else if (data == nil){
        return nil;
    }
    else{
        return [NSString stringWithFormat:@"%@跟帖",data];
    }
}

+(UILabel *)timeLableWithFrame:(CGRect)frame{
    
    UILabel *lable = [[UILabel alloc]initWithFrame:frame];
    lable.textColor = [UIColor colorWithWhite:0.500 alpha:1.000];
    lable.font = [UIFont systemFontOfSize:12];
    
    return lable;
    
}

+(NSString *)timeStampToDate:(NSNumber*)time{
    
   NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.unsignedLongLongValue/1000];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

+(CAAnimationGroup *)animationGroupWithType:(AnimationType)type{
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromBottom;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"opacity";
    animation.duration = 1;
    switch (type) {
        case Show:
            animation.values = @[@0,@1];
            break;
       case Hide:
            animation.values = @[@1,@0];
            break;
    }
    
    group.animations = @[transition];
    group.duration = 1;
    return group;
}
@end
