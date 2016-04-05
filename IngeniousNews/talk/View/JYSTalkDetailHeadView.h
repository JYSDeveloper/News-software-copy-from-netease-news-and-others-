//
//  JYSTalkDetailHeadView.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/10.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSTalkModel.h"

typedef void(^heightBlock) (CGFloat height);

@interface JYSTalkDetailHeadView : UIView


@property(nonatomic,retain)UIImageView *imageView;

@property(nonatomic,retain)UILabel *nameLable;

@property(nonatomic,retain)UILabel *introduceLable;


-(instancetype)initWithFrame:(CGRect)frame Message:(JYSTalkModel*)message;


@end
