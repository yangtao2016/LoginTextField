//
//  DSLLoginTextField.m
//  DuanSheLi
//
//  Created by 咖达-杨涛 on 2017/3/15.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "DSLLoginTextField.h"

@implementation DSLLoginTextField
{
    UIButton *_leftIconBtn;//默认的leftIcon
    UIView *_customLeftView;//默认的leftView，是_leftIconBtn的父视图
}

-(instancetype)init{
    
    self=[super init];

    if (self) {
        
        //初始化默认状态
        _isChangeBorder=YES;
        _defaultBorderColor=[UIColor grayColor];
        _defaultBorderWidth=1;
        _selectBorderColor=[UIColor whiteColor];
        _placeholderColor=[UIColor whiteColor];
        self.layer.cornerRadius=3;
        self.layer.borderWidth=_defaultBorderWidth;
        self.layer.borderColor=_defaultBorderColor.CGColor;
        self.textColor=[UIColor whiteColor];
        self.tintColor=[UIColor whiteColor];
        
        //初始化默认leftview
        _customLeftView=[[UIView alloc]init];
        CGRect  leftRect=_customLeftView.frame;
        leftRect.size.width=5;
        _customLeftView.frame=leftRect;
        self.leftView=_customLeftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //添加通知监听文本状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }
    
    return self;
}

-(void)setDefaultBorderColor:(UIColor *)defaultBorderColor
{
    _defaultBorderColor=defaultBorderColor;
    self.layer.borderColor=_defaultBorderColor.CGColor;
}

-(void)setDefaultBorderWidth:(CGFloat)defaultBorderWidth
{
    _defaultBorderWidth=defaultBorderWidth;
    self.layer.borderWidth=_defaultBorderWidth;
}

-(void)setLeftIconNameStr:(NSString *)leftIconNameStr
{
    _leftIconNameStr=leftIconNameStr;
    if (_leftIconNameStr!=nil&&_leftIconNameStr.length>0)
    {
        [self settingLeftIcon];
    }
}

-(void)setLeftHighlightedIconNameStr:(NSString *)leftHighlightedIconNameStr
{
    _leftHighlightedIconNameStr=leftHighlightedIconNameStr;
    
    if (_leftHighlightedIconNameStr!=nil&&_leftHighlightedIconNameStr.length>0)
    {
        [self settingLeftIcon];
    }
}

-(void)settingLeftIcon
{
    _leftIconBtn=[_customLeftView viewWithTag:11111];
    if (_leftIconBtn==nil)
    {
        _leftIconBtn=[UIButton buttonWithType:0];
        CGRect  leftRect=_leftIconBtn.frame;
        leftRect.size=CGSizeMake(20, 20);
        _leftIconBtn.frame=leftRect;
        [_customLeftView addSubview:_leftIconBtn];
    }
    
    [_leftIconBtn setImage:[UIImage imageNamed:_leftIconNameStr] forState:0];
    [_leftIconBtn setImage:[UIImage imageNamed:_leftHighlightedIconNameStr] forState:UIControlStateSelected];
    CGRect  leftRect=_customLeftView.frame;
    leftRect.size.width=30;
    _customLeftView.frame=leftRect;
    _leftIconBtn.center=_customLeftView.center;
    self.leftView=_customLeftView;
}


-(void)textBeginEditing:(NSNotification*)note
{
    if (_isChangeBorder==NO)return;
    [self changBorderwithNote:note];

}

-(void)textDidEndEditing:(NSNotification*)note
{
    if (_isChangeBorder==NO)return;
    [self changBorderwithNote:note];

 
}

-(void)textDidChange:(NSNotification*)note
{
    [self changBorderwithNote:note];
}


-(void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:_placeholderColor}];

}


-(void)changBorderwithNote:(NSNotification*)editing
{
    if (![editing.object isEqual:self])return;
    if ([editing.name isEqualToString:UITextFieldTextDidBeginEditingNotification])
    {
        self.layer.borderColor=_selectBorderColor.CGColor;
        _leftIconBtn.selected=YES;
        
    }else if ([editing.name isEqualToString:UITextFieldTextDidEndEditingNotification])
    {
        self.layer.borderColor=_defaultBorderColor.CGColor;
        _leftIconBtn.selected=NO;
        
    }else if ([editing.name isEqualToString:UITextFieldTextDidChangeNotification]){
        
        if (self.maxTextLength!=0)
        {
            if (self.text.length >self.maxTextLength) {
                [self judemaxText];
            }
        }
    }
    
}


//限制最大输入字数
-(void)judemaxText
{
    if (_maxTextLength>0)
    {
        // 键盘输入模式
        NSString *lang=[[UIApplication sharedApplication]textInputMode].primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (self.text.length >= _maxTextLength) {
                    if (self.text.length>_maxTextLength)
                    {
                        [self addShakeAnimation];
                    }
                    NSString *newText=[self.text substringToIndex:_maxTextLength];
                    if (![self.text isEqualToString:newText])
                    {
                        self.text =newText;
                    }
                    
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (self.text.length >= _maxTextLength) {
                if (self.text.length>_maxTextLength)
                {
                    [self addShakeAnimation];
                }
                NSString *newText=[self.text substringToIndex:_maxTextLength];
                if (![self.text isEqualToString:newText])
                {
                    self.text =newText;
                }
            }
        }
        
    }

}

//添加抖动动画
-(void)addShakeAnimation
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = self.transform.tx;
    
    //    animation.delegate = self;
    animation.duration = 0.5;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
}



-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"文本框释放");
}



@end
