//
//  ViewController.m
//  test
//
//  Created by 咖达-杨涛 on 2017/3/20.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "ViewController.h"
#import "DSLLoginTextField.h"

#define DSLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:255/255.0]//RGBA

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DSLColor(43, 34, 44);
    NSArray *noImgs=@[@"phone",@"password",@"code"];
    NSArray *selectImgs=@[@"phone_on",@"password_on",@"code_on"];
    NSArray *placeholders=@[@"手机号/11位",@"密码/8位",@"验证码/6位"];
    NSArray *maxLengthS=@[@11,@8,@6];
    CGFloat vWid=self.view.frame.size.width;
    for (int t=0; t<noImgs.count; t++)
    {
        DSLLoginTextField *tf=[[DSLLoginTextField alloc]init];
        tf.clearButtonMode=UITextFieldViewModeWhileEditing;
        tf.placeholderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
        tf.font=[UIFont systemFontOfSize:14];
        tf.leftIconNameStr=noImgs[t];
        tf.leftHighlightedIconNameStr=selectImgs[t];
        tf.placeholder=placeholders[t];
        [self.view addSubview:tf];
        tf.frame=CGRectMake(20, 80+(40+20)*t, vWid-40, 40);
        tf.maxTextLength=[maxLengthS[t] intValue];
        if (t==0||t==2)
        {
            tf.keyboardType=UIKeyboardTypeNumberPad;
        }
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}



@end
