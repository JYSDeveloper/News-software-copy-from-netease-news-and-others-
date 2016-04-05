//
//  JYSLocationWebViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/7.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLocationWebViewController.h"
#import "MHNetWorkTask.h"
#import "JYSWebViewImgModel.h"
@interface JYSLocationWebViewController ()<UIWebViewDelegate>

@property(nonatomic,retain)UIWebView *webView;

@property(nonatomic,retain)JYSWebViewModel *webModel;

@end

@implementation JYSLocationWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://api.iclient.ifeng.com/ipadtestdoc?aid=%@",[self.model.documentId substringFromIndex:4]];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        self.webModel = [JYSWebViewModel webViewModelWithDic:result[@"body"] withType:secondType];
        [self showInWebView];
        
    } withFail:^(NSError *error) {
        
    }];
    
    
    [self.view addSubview:_webView];

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
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"JYSDetails.css" withExtension:nil]];
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
    [body appendFormat:@"<div class=\"title\">%@</div>",self.webModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.webModel.ptime];
    if (self.webModel.body != nil) {
        [body appendFormat:@"<div class=\"note\">%@</div>",self.webModel.body];
    }
    //   遍历img
    for (JYSWebViewImgModel *webImgModel in self.webModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 数组存放被切割的像素
        CGFloat width = [webImgModel.width floatValue];
        CGFloat height = [webImgModel.height floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        [imgHtml appendFormat:@"width=\"%f\" height=\"%f\"",width,height];
        NSRange range = [body rangeOfString:@"longdesc="];
        if (range.length>0) {
            
            // 替换标记
            [body replaceCharactersInRange:range withString:imgHtml];
        }
    }

    
    
    return body;
}



@end
