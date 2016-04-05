//
//  JYSSectionView.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/10.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSectionView.h"

@implementation JYSSectionView

-(instancetype)initWithFrame:(CGRect)frame Message:(JYSTalkModel *)message{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH/2, 30)];
        self.lable.text = [NSString stringWithFormat:@"%d提问\t%ld回复",message.questionCount.intValue,message.answerCount];
        self.lable.textColor = [UIColor grayColor];
        [self addSubview:self.lable];
        self.segment = [[UISegmentedControl alloc]initWithItems:@[@"最热",@"最新"]];
        self.segment.tintColor = [UIColor colorWithRed:1.000 green:0.184 blue:0.091 alpha:1.000];
        self.segment.frame = CGRectMake(UISCREENWIDTH-100, 0, 100, 30);
        self.segment.selectedSegmentIndex = 0;
        [self addSubview:self.segment];
        self.backgroundColor = [UIColor colorWithWhite:0.836 alpha:1.000];
    }
    return self;
}

@end
