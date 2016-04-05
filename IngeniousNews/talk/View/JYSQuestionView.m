//
//  JYSQuestionView.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSQuestionView.h"
#import <UIImageView+WebCache.h>
@implementation JYSQuestionView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.questionUserImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self addSubview:self.questionUserImage];
    
    self.questionName = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    self.questionName.textColor = [UIColor grayColor];
    self.questionName.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.questionName];
    
    self.questionLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, UISCREENWIDTH-60, 30)];
    self.questionLable.numberOfLines = 0;
    [self addSubview:self.questionLable];
    
}
-(void)getDataWithModel:(JYSTalkDetailQuestionModel *)model{
    
    [self.questionUserImage sd_setImageWithURL:[NSURL URLWithString:model.userHeadPicUrl] placeholderImage:nil];
    self.questionName.text = model.userName;
    self.questionLable.frame = [self heightForQuestionLableWithText:model.content];
    self.questionLable.text = model.content;
    self.frame = CGRectMake(0, 0, UISCREENWIDTH, self.questionLable.frame.size.height+50);
}


-(CGRect)heightForQuestionLableWithText:(NSString*)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(UISCREENWIDTH-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    rect.origin.x = 50;
    rect.origin.y = 50;
    return rect;
}



@end
