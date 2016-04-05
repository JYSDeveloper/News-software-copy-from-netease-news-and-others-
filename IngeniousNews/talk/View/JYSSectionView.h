//
//  JYSSectionView.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/10.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSTalkModel.h"
@interface JYSSectionView : UIView


@property(nonatomic,retain)UILabel *lable;

@property(nonatomic,retain)UISegmentedControl *segment;


-(instancetype)initWithFrame:(CGRect)frame Message:(JYSTalkModel*)message;


@end
