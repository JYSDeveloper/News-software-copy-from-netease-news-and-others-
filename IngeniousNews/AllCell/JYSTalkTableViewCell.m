//
//  JYSTalkTableViewCell.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "JYSTalkModel.h"
@implementation JYSTalkTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.userImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    self.userImage.layer.borderWidth = 2;
    self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImage.layer.cornerRadius = 25;
    self.userImage.layer.masksToBounds = YES;//去掉图片边界
    
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 200, 15)];
    [self.contentView addSubview:self.titleLable];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, UISCREENWIDTH, 200)];
    [self.contentView addSubview:self.titleImage];
    
    self.digestLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 265, UISCREENWIDTH-40, 100)];
    self.digestLable.font = [UIFont systemFontOfSize:20];
    self.digestLable.numberOfLines = 0;
    [self.contentView addSubview:self.digestLable];
    
    self.involvementLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 385, UISCREENWIDTH-40, 25)];
    [self.contentView addSubview:self.involvementLable];
    
    [self.contentView addSubview:self.userImage];
    
}

-(void)getDataWithModel:(id)model{
    JYSTalkModel *talkModel = (JYSTalkModel*)model;
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:talkModel.headpicurl] placeholderImage:nil];
    
    NSString *userInfo = [NSString stringWithFormat:@"%@|\t%@",talkModel.name,talkModel.title];
    NSMutableAttributedString *userInfoAtt = [[NSMutableAttributedString alloc]initWithString:userInfo];
    NSRange nameRange = [userInfo rangeOfString:talkModel.name];
    NSRange titleRange = [userInfo rangeOfString:talkModel.title];
    [userInfoAtt addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:nameRange];
    [userInfoAtt addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:titleRange];
    self.titleLable.attributedText = userInfoAtt;
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:talkModel.picurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    self.digestLable.text = talkModel.descriptions;
    self.digestLable.frame = [self heightForDigestLableWithText:talkModel.descriptions];
    
    self.involvementLable.frame = CGRectMake(20, self.digestLable.frame.size.height+285, UISCREENWIDTH-40, 25);
    NSString *involvementText = [NSString stringWithFormat:@"%@\t\t%@关注\t\t%@提问",talkModel.classification,talkModel.concernCount.stringValue,talkModel.questionCount.stringValue];
    NSMutableAttributedString *involvementAtt = [[NSMutableAttributedString alloc]initWithString:involvementText];
    NSRange concrenRange = [involvementText rangeOfString:talkModel.classification];
    [involvementAtt addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, involvementText.length)];
    [involvementAtt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.165 green:0.991 blue:1.000 alpha:1.000] range:concrenRange];
    self.involvementLable.attributedText = involvementAtt;
    
    
}
-(CGRect)heightForDigestLableWithText:(NSString*)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(UISCREENWIDTH-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    rect.origin.x = self.digestLable.frame.origin.x;
    rect.origin.y = self.digestLable.frame.origin.y;
    return rect;
}

@end
