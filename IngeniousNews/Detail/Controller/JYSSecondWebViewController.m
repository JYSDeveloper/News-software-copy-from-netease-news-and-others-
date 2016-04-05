//
//  JYSSecondWebViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSecondWebViewController.h"
#import "MHNetWorkTask.h"
#import "JYSSecondWebModel.h"
#import "JYSSecondWebImageModel.h"
@interface JYSSecondWebViewController ()

@property(nonatomic,retain)UIWebView *webView;

@property(nonatomic,retain)JYSSecondWebModel *webModel;
@end

@implementation JYSSecondWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSString *url = @"http://iphone.myzaker.com/zaker/article_mongo.php?_appid=iphone&_bsize=640_1136&app_id=12266&m=1456972868&pk=56d41a629490cb6505000056&style_v=2";
    
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        result = [result objectForKey:@"data"];
        self.webModel = [JYSSecondWebModel secondWebModelWithDic:result];
        [self showInWebView];
    } withFail:^(NSError *error) {
        
    }];
    
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
 //   [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"JYSDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    //[body appendFormat:@"<div class=\"title\">%@</div>",self.webModel.title];
    //[body appendFormat:@"<div class=\"time\">%@</div>",self.webModel.ptime];
    if (self.webModel.content != nil) {
        [body appendString:self.webModel.content];
    }
    // 遍历img
    for (JYSSecondWebImageModel *webImgModel in self.webModel.imageArr) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        //NSArray *pixel = [webImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [webImgModel.w floatValue];
        CGFloat height = [webImgModel.h floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,webImgModel.url];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:@"" withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}


@end
