//
//  ViewController.m
//  mining iQ
//
//  Created by Anirban on 03/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ViewController.h"
#import "DashBoardViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    BOOL showPwdBool;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    showPwdBool = true;
    
    [self.userNameTxt setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.userNameTxt.leftView = paddingView;
    self.userNameTxt.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTxt.delegate=self;
    
    [self.passwordTxt setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.passwordTxt.leftView = paddingView1;
    self.passwordTxt.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxt.delegate=self;
    
    self.loginBtn = [self roundRadious:self.loginBtn radius:2];
    self.registerBtn = [self roundRadious:self.registerBtn radius:2];
    self.forgotPwdBtn = [self roundRadious:self.forgotPwdBtn radius:2];
}

-(UIButton *)roundRadious:(UIButton *)button radius:(NSInteger)radius
{
    button.layer.cornerRadius = 2.0f;
    button.clipsToBounds = YES;
    
    return button;
}

- (IBAction)showPwdAction:(id)sender {
    
    if (showPwdBool == true)
    {
        [self.showPwdBtn setImage:[UIImage imageNamed:@"Visible-25"] forState:UIControlStateNormal];
        self.passwordTxt.secureTextEntry = NO;
        showPwdBool = false;
    }
    else if (showPwdBool == false)
    {
        [self.showPwdBtn setImage:[UIImage imageNamed:@"Invisible-25"] forState:UIControlStateNormal];
        self.passwordTxt.secureTextEntry = YES;
        showPwdBool = true;
    }
}


-(UITextField *)roundRadiousTxt:(UITextField *)textField radius:(NSInteger)radius
{
    textField.layer.cornerRadius = 2.0f;
    textField.clipsToBounds = YES;
    return textField;
}

- (IBAction)goToDashboard:(id)sender {
    DashBoardViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
    [self.navigationController pushViewController:dashBoard animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
