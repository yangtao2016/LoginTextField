//
//  DSLLoginTextField.h
//  DuanSheLi
//
//  Created by 咖达-杨涛 on 2017/3/15.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLLoginTextField : UITextField

/**
 左边的icon,不传则不显示
 */
@property(nonatomic,copy)NSString *leftIconNameStr;
@property(nonatomic,copy)NSString *leftHighlightedIconNameStr;


/**
 控制当在编辑时，是否高亮文本框的Border,默认是YES
 */
@property(nonatomic,assign)BOOL isChangeBorder;

/**默认边框颜色*/
@property(nonatomic,copy)UIColor *defaultBorderColor;
/**默认边框宽度*/
@property(nonatomic,assign)CGFloat defaultBorderWidth;
/**编辑时边框颜色*/
@property(nonatomic,copy)UIColor *selectBorderColor;
/**占位文本的颜色*/
@property(nonatomic,copy)UIColor *placeholderColor;
/**最多输入长度*/
@property(nonatomic,assign)int maxTextLength;


@end
