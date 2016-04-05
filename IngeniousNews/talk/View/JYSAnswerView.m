//
//  JYSAnswerView.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSAnswerView.h"
#import <UIImageView+WebCache.h>
#import "JYSTools.h"
@implementation JYSAnswerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    self.answerUserImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self addSubview:self.answerUserImage];
    
    self.answerName = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    self.answerName.textColor = [UIColor grayColor];
    self.answerName.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.answerName];
    
    self.answer = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, UISCREENWIDTH-60, 100)];
    self.answer.numberOfLines = 0;
    [self addSubview:self.answer];
    
    self.answerTime = [[UILabel alloc]initWithFrame:CGRectMake(50, 160, 300, 30)];
    self.answerTime.font = [UIFont systemFontOfSize:15];
    self.answerTime.textColor = [UIColor grayColor];
    self.answerTime.numberOfLines = 0;
    [self addSubview:self.answerTime];
}
-(void)getDataWithModel:(JYSTalkDetailAnswerModel *)model{
    
    [self.answerUserImage sd_setImageWithURL:[NSURL URLWithString:model.specialistHeadPicUrl] placeholderImage:nil];
    
    self.answerName.text = model.specialistName;
    
    CGRect answerRect = [self heightForAnswerLableWithText:model.content];
    self.answer.frame = answerRect;
    self.answer.text = model.content;
    
    self.answerTime.frame = CGRectMake(50, 60+answerRect.size.height, 300, 30);
    self.answerTime.text = [JYSTools timeStampToDate:model.cTime];
    
}

-(CGRect)heightForAnswerLableWithText:(NSString*)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(UISCREENWIDTH-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    rect.origin.x = 50;
    rect.origin.y = 50;
    return rect;
}


@end
