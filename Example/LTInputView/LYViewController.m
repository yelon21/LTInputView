//
//  LYViewController.m
//  LTInputView
//
//  Created by yelon21 on 07/15/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"

#import "LTInputView.h"
@interface LYViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    LTInputView *inputView = [[LTInputView alloc]init];
    inputView.title = @"安全输入";
    inputView.textField = self.textField;
    inputView.inputType = LTInputType_alp;
    
    [self.textField becomeFirstResponder];
    
    LTInputView *inputView2 = [[LTInputView alloc]init];
    inputView2.title = @"安全输入";
    inputView2.textField = self.numberTF;
    inputView2.inputType = LTInputType_number;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"shouldChangeCharactersInRange=%@",textField.text);
    NSLog(@"string=%@",string);
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"textFieldShouldBeginEditing=%@",textField.text);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"textFieldDidBeginEditing=%@",textField.text);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSLog(@"textFieldShouldEndEditing=%@",textField.text);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"textFieldDidEndEditing=%@",textField.text);
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    NSLog(@"textFieldShouldClear=%@",textField.text);
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn=%@",textField.text);
    return YES;
}

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

@end
