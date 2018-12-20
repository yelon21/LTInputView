//
//  LTInputView.h
//  KeyBorderDemo
//
//  Created by yelon on 16/4/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LTInputType) {
    
    LTInputType_alp = -1,//字母
    LTInputType_char = -2,//字符
    LTInputType_digit = -3,//数字
    
    LTInputType_number = -4//纯数字
};

NSString *LTInputViewPlainText(UITextField *textField);

@interface LTInputView : UIView

@property(nonatomic,assign)UITextField *textField;
@property(nonatomic,assign)LTInputType inputType;
@property(nonatomic,assign)NSString *title;
@end
