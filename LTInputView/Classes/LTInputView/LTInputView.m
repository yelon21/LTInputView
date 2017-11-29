//
//  LTInputView.m
//  KeyBorderDemo
//
//  Created by yelon on 16/4/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTInputView.h"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define topViewH 35.0
#define contentkeysViewH 216.0
#define lineW   5
typedef NS_ENUM(NSInteger, LTKeyType) {
    
    LTKeyType_change = -3,
    LTKeyType_delete = -2,
    LTKeyType_done = -1,
    LTKeyType_upper = -4,
    LTKeyType_normal = 0
};

@interface LTValueButton : UIButton

@property(nonatomic,strong) NSString *value;
@end

@implementation LTValueButton

@end

@interface LTInputView ()<UIInputViewAudioFeedback>{
    
    UITextField *handleTF;
}

@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *contentkeysView;
@property(nonatomic,strong) UILabel *titleLabel;
@end

@implementation LTInputView

-(UITextField *)textField{
    
    return handleTF;
}

-(void)setTextField:(UITextField *)textField{
    
    handleTF = textField;
    handleTF.inputView = self;
}

-(void)setTitle:(NSString *)title{

    self.titleLabel.text = title;
}

-(NSString *)title{

    return _titleLabel.text;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"安全输入";
    }
    return _titleLabel;
}

- (UIView *)topView{
    
    if (!_topView) {
        
        CGFloat width = CGRectGetWidth(self.bounds);
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, topViewH)];
        _topView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [self addSubview:_topView];
        _topView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UILabel *titleLabel = self.titleLabel;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_topView addSubview:titleLabel];
        
//        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
//                                                             attribute:NSLayoutAttributeTop
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:_topView
//                                                             attribute:NSLayoutAttributeTop
//                                                            multiplier:1.0
//                                                              constant:0.0]];
//        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
//                                                             attribute:NSLayoutAttributeBottom
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:_topView
//                                                             attribute:NSLayoutAttributeBottom
//                                                            multiplier:1.0
//                                                              constant:0.0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_topView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_topView
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
//        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
//                                                             attribute:NSLayoutAttributeWidth
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:nil
//                                                             attribute:NSLayoutAttributeNotAnAttribute
//                                                            multiplier:1.0
//                                                              constant:200.0]];
        
        LTValueButton *btn = [self newValueButton];
        btn.layer.masksToBounds = NO;
        [btn setBackgroundImage:nil
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:[UIColor lightTextColor]]
                       forState:UIControlStateHighlighted];
        
        btn.tag = LTKeyType_done;
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [_topView addSubview:btn];
        
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_topView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0.0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_topView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0.0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_topView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0.0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:60.0]];
    }
    return _topView;
}

- (UIView *)contentkeysView{
    
    if (!_contentkeysView) {
        
        CGFloat width = CGRectGetWidth(self.bounds);
        
        _contentkeysView = [[UIView alloc] initWithFrame:CGRectMake(0.0, topViewH+0.5, width, contentkeysViewH)];
        _contentkeysView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentkeysView];
        _contentkeysView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _contentkeysView;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{

    [self reloadViews];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
    
    CGFloat deltBootom = KIsiPhoneX ? 34.0 : 0.0;
    
    self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.frame = CGRectMake(0.0, 0.0, width, topViewH+contentkeysViewH+1 + deltBootom);
    [self topView];
    [self reloadViews];
}

-(void)setInputType:(LTInputType)inputType{
    
    if (_inputType != inputType) {
        
        _inputType = inputType;
        
        [self reloadViews];
    }
}
//更新键盘
- (void)reloadViews{
    
    switch (_inputType) {
            
        case LTInputType_number:
            [self setupNumber];
            break;
        case LTInputType_alp:
            [self setupAlp];
            break;
        case LTInputType_char:
            [self setupChar];
            break;
        case LTInputType_digit:
            [self setupDigit];
            break;
            
        default:
            [self setupAlp];
            break;
    }
}
//设置数字键盘
- (void)setupNumber{
    
    NSMutableArray *values = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
    
    UIView *superView = self.contentkeysView;
    [[superView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    NSInteger rowCount = 4;
    NSInteger colCount = 3;
    
    CGFloat cellW = (width-(colCount+1)*lineW)/colCount;
    CGFloat cellH = (height-(rowCount+1)*lineW)/rowCount;
    
    for (NSInteger i = 0; i<rowCount; i++) {
        
        for (NSInteger j = 0; j < colCount; j++) {
            
            NSInteger index = i*colCount+j;
            
            LTValueButton *btn = [self newValueButton];
            btn.frame = CGRectMake(j*(cellW+lineW)+lineW, i*(cellH+lineW)+lineW, cellW, cellH);
            
            [superView addSubview:btn];
            
            if (index == 9) {
                
                btn.tag = LTKeyType_delete;
                [btn setImage:[UIImage imageNamed:@"backToDelete0"]
                        forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"backToDelete1"]
                     forState:UIControlStateHighlighted];
            }
            else if (index == 11){
                
                btn.tag = LTKeyType_done;
                [btn setTitle:@"确定" forState:UIControlStateNormal];
            }
            else{
                
                btn.tag = LTKeyType_normal;
                
                NSInteger count = [values count];
                if (count > 1) {
                    
                    NSInteger rand = arc4random()%count;
                    btn.value = values[rand];
                    [btn setTitle:btn.value forState:UIControlStateNormal];
                    [values removeObjectAtIndex:rand];
                }
                else if (count == 1){
                    
                    btn.value = [values firstObject];
                    [btn setTitle:btn.value forState:UIControlStateNormal];
                    [values removeObjectAtIndex:0];
                }
            }
            
        }
    }
}

- (LTValueButton *)newValueButton{
    
    LTValueButton *btn = [LTValueButton new];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [btn addTarget:self
            action:@selector(keyPressed:)
  forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.5]]
                   forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self imageWithColor:[UIColor lightTextColor]]
                   forState:UIControlStateSelected];
    
    btn.layer.cornerRadius = 5.0;
    btn.layer.masksToBounds = YES;
    return btn;
}

//设置字母键盘
- (void)setupAlp{
    
    NSArray *line0 = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    NSArray *line1 = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    NSArray *line2 = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    
    NSMutableArray *values = [[NSMutableArray alloc]initWithObjects:line0,line1,line2,nil];
    
    UIView *superView = self.contentkeysView;
    [[superView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    NSInteger rowCount = 4;
    NSInteger colCount = 10;
    
    CGFloat cellW = (width-(colCount+1)*lineW)/colCount;
    CGFloat cellH = (height-(rowCount+1)*lineW)/rowCount;
    
    for (NSInteger row = 0; row<rowCount; row++) {
        
        CGFloat y = row*(cellH+lineW)+lineW;
        
        if (row == rowCount-1) {
            
            
            LTValueButton *doneBtn = [self newValueButton];
            doneBtn.frame = CGRectMake(lineW, y, 2*cellW+lineW, cellH);
            [superView addSubview:doneBtn];
            
            doneBtn.tag = LTKeyType_change;
            [doneBtn setTitle:@"123" forState:UIControlStateNormal];
            doneBtn.value = [@(LTInputType_digit) stringValue];
            
            LTValueButton *spaceBtn = [self newValueButton];
            spaceBtn.frame = CGRectMake(2*(cellW+lineW)+lineW, y, 6*(cellW+lineW)-lineW, cellH);
            [superView addSubview:spaceBtn];
            
            spaceBtn.tag = LTKeyType_normal;
            spaceBtn.value = @" ";
            [spaceBtn setTitle:@"空 格" forState:UIControlStateNormal];

            LTValueButton *changeBtn = [self newValueButton];
            changeBtn.frame = CGRectMake(8 * (cellW + lineW)+lineW, y, 2*cellW+lineW, cellH);
            [superView addSubview:changeBtn];
            
            changeBtn.value = [@(LTInputType_char) stringValue];
            changeBtn.tag = LTKeyType_change;
            [changeBtn setTitle:@"#+=" forState:UIControlStateNormal];
        }
        else{
            
            NSInteger alpCount = [values[row] count];
            
            if (row == 2) {
                
                
                LTValueButton *upperBtn = [self newValueButton];
                upperBtn.frame = CGRectMake(lineW, y, 1.5*cellW+lineW*0.5, cellH);
                [superView addSubview:upperBtn];
                
                [upperBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]
                               forState:UIControlStateSelected];
                
                upperBtn.tag = LTKeyType_upper;
                [upperBtn setImage:[UIImage imageNamed:@"upper0"]
                        forState:UIControlStateNormal];
                [upperBtn setImage:[UIImage imageNamed:@"upper1"]
                        forState:UIControlStateSelected];
                
                LTValueButton *delBtn = [self newValueButton];
                delBtn.frame = CGRectMake((cellW+lineW)*8.5+lineW, y, 1.5*cellW+lineW*0.5, cellH);
                [superView addSubview:delBtn];
                
                delBtn.tag = LTKeyType_delete;
                
                [delBtn setImage:[UIImage imageNamed:@"backToDelete0"]
                        forState:UIControlStateNormal];
                [delBtn setImage:[UIImage imageNamed:@"backToDelete1"]
                        forState:UIControlStateHighlighted];
            }
            
            for (NSInteger col = 0; col < alpCount; col++) {
                
                LTValueButton *btn = [self newValueButton];
                
                CGFloat space = 0.0;
                CGFloat itemCount = (colCount - alpCount)/2.0;
                if (itemCount==0) {
                    
                    space = 0.0;
                }
                else {
                    
                    if (itemCount <= 1.0) {
                        
                        space = itemCount*cellW+lineW*0.5;
                    }
                    else if (itemCount > 1.0 && itemCount <= 2.0){
                        
                        space = itemCount*cellW+lineW*0.5 + lineW;
                    }
                    else if (itemCount > 2.0 && itemCount <= 3.0){
                        
                        space = itemCount*cellW+lineW*0.5 + lineW*2;
                    }
                }
                
                btn.frame = CGRectMake(col*(cellW+lineW)+space+lineW, y, cellW, cellH);
                
                [superView addSubview:btn];
                
                btn.tag = LTKeyType_normal;
                btn.value = values[row][col];
                [btn setTitle:btn.value forState:UIControlStateNormal];
            }
        }
    }
}
//设置字符键盘
- (void)setupChar{
    
//    NSArray *line0 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *line1 = @[@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"(",@")"];
    NSArray *line2 = @[@"'",@"\"",@"=",@"_",@":",@";",@"?",@"~",@"`"];
    NSArray *line3 = @[@"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@"*"];
    NSArray *line4 = @[@"<",@">",@"|",@",",@"."];
    
    NSMutableArray *values = [[NSMutableArray alloc]initWithObjects:line1,line2,line3,line4,nil];
    
    UIView *superView = self.contentkeysView;
    [[superView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    NSInteger rowCount = 4;
    NSInteger colCount = line1.count;
    
    CGFloat cellW = (width-(colCount+1)*lineW)/colCount;
    CGFloat cellH = (height-(rowCount+1)*lineW)/rowCount;
    
    for (NSInteger row = 0; row<rowCount; row++) {
        
        NSInteger alpCount = [values[row] count];
        
        for (NSInteger col = 0; col < alpCount; col++) {
            
            CGFloat y = row*(cellH+lineW)+lineW;
            
            CGFloat space = 0.0;
            CGFloat itemCount = (colCount - alpCount)/2.0;
            if (itemCount==0) {
                
                space = 0.0;
            }
            else {
                
                if (itemCount <= 1.0) {
                    
                    space = itemCount*cellW+lineW*0.5;
                }
                else if (itemCount > 1.0 && itemCount <= 2.0){
                    
                    space = itemCount*cellW+lineW + lineW;
                }
                else if (itemCount > 2.0 && itemCount <= 3.0){
                    
                    space = itemCount*cellW+lineW*0.5 + lineW*2;
                }
            }

            
            LTValueButton *btn = [self newValueButton];
            btn.frame = CGRectMake(col*(cellW+lineW)+space+lineW, y, cellW, cellH);
            
            [superView addSubview:btn];
            
            btn.tag = LTKeyType_normal;
            btn.value = values[row][col];
            [btn setTitle:btn.value forState:UIControlStateNormal];
            
            if (row == rowCount-1) {
                
                LTValueButton *changeBtn = [self newValueButton];
                changeBtn.frame = CGRectMake(lineW, y, 2*cellW+lineW, cellH);
                [superView addSubview:changeBtn];
                
                changeBtn.value = [@(LTInputType_alp) stringValue];
                changeBtn.tag = LTKeyType_change;
                [changeBtn setTitle:@"ABC" forState:UIControlStateNormal];
                
                LTValueButton *delBtn = [self newValueButton];
                delBtn.frame = CGRectMake(7*(cellW + lineW)+lineW, y, cellW*2 + lineW, cellH);
                [superView addSubview:delBtn];
                
                delBtn.tag = LTKeyType_delete;
                
                [delBtn setImage:[UIImage imageNamed:@"backToDelete0"]
                        forState:UIControlStateNormal];
                [delBtn setImage:[UIImage imageNamed:@"backToDelete1"]
                        forState:UIControlStateHighlighted];
            }
        }
    }
}

//设置数字
- (void)setupDigit{
    
    NSArray *line0 = @[@"1",@"2",@"3"];
    NSArray *line1 = @[@"4",@"5",@"6"];
    NSArray *line2 = @[@"7",@"8",@"9"];
    NSArray *line3 = @[@"-3",@"0",@"-2"];
    
    NSMutableArray *values = [[NSMutableArray alloc]initWithObjects:line0,line1,line2,line3,nil];
    
    UIView *superView = self.contentkeysView;
    [[superView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    NSInteger rowCount = 4;
    NSInteger colCount = 3;
    
    CGFloat cellW = (width-(colCount+1)*lineW)/colCount;
    CGFloat cellH = (height-(rowCount+1)*lineW)/rowCount;
    
    for (NSInteger row = 0; row<rowCount; row++) {
        
        NSInteger alpCount = [values[row] count];
        
        for (NSInteger col = 0; col < alpCount; col++) {
            
            CGFloat y = row*(cellH+lineW)+lineW;
            
            CGFloat space = 0.0;
            CGFloat itemCount = (colCount - alpCount)/2.0;
            if (itemCount==0) {
                
                space = 0.0;
            }
            else {
                
                if (itemCount <= 1.0) {
                    
                    space = itemCount*cellW+lineW*0.5;
                }
                else if (itemCount > 1.0 && itemCount <= 2.0){
                    
                    space = itemCount*cellW+lineW + lineW;
                }
                else if (itemCount > 2.0 && itemCount <= 3.0){
                    
                    space = itemCount*cellW+lineW*0.5 + lineW*2;
                }
            }
            
            
            LTValueButton *btn = [self newValueButton];
            btn.frame = CGRectMake(col*(cellW+lineW)+space+lineW, y, cellW, cellH);
            
            [superView addSubview:btn];
            
            
            btn.value = values[row][col];
            
            NSInteger keyValue = [btn.value integerValue];
            if (keyValue == LTKeyType_delete) {
                
                btn.tag = LTKeyType_delete;
                [btn setImage:[UIImage imageNamed:@"backToDelete0"]
                        forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"backToDelete1"]
                     forState:UIControlStateHighlighted];
            }
            else if (keyValue == LTKeyType_change) {
                
                btn.tag = LTKeyType_change;
                [btn setTitle:@"ABC" forState:UIControlStateNormal];
                btn.value = [@(LTInputType_alp) description];
            }
            else{
                btn.tag = LTKeyType_normal;
                [btn setTitle:btn.value forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark key action
- (void)keyPressed:(LTValueButton *)btn{
    
    [[UIDevice currentDevice] playInputClick];
    
    NSString *value = btn.value;
    
    LTKeyType keyType = btn.tag;
    
    switch (keyType) {
            
        case LTKeyType_delete:{
            
            [handleTF deleteBackward];
            break;
        }
        case LTKeyType_done:{
            
            [handleTF resignFirstResponder];
            break;
        }
        case LTKeyType_normal:{
            
            if (value && [value isKindOfClass:[NSString class]]) {
                
                [handleTF insertText:value];
            }
            break;
        }
        case LTKeyType_upper:{
            
            btn.selected = !btn.selected;
            [self showAlphabetUpper:btn.selected];
            break;
        }
        case LTKeyType_change:{
            
            self.inputType = [btn.value integerValue];
            break;
        }
            
        default:
            break;
    }
}

- (void)showAlphabetUpper:(BOOL)upper{
    
    for (LTValueButton *btn in  [self.contentkeysView subviews]) {
        
        if ([btn isKindOfClass:[LTValueButton class]]&&btn.tag==LTKeyType_normal&&![btn.value isEqualToString:@" "]) {
            
            NSString *value = [btn value];
            value = upper?[value uppercaseString]:[value lowercaseString];
            
            btn.value = value;
            [btn setTitle:btn.value forState:UIControlStateNormal];
        }
    }
}
#pragma mark UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible {
    
    return YES;
}
#pragma mark 颜色2图片
//根据颜色返回图片
- (UIImage*) imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
