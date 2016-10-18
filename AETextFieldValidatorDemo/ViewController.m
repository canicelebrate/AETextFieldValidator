//
//  ViewController.m
//  TextFieldValidationDemo
//
//  Created by William Wang on 10/18/2016.
//  Copyright (c) 2016 William Wang. All rights reserved.
//

#import "ViewController.h"
#import "AETextFieldValidator.h"


#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

@interface ViewController ()<UITextFieldDelegate>{
    IBOutlet AETextFieldValidator *txtUserName;
    IBOutlet AETextFieldValidator *txtEmail;
    IBOutlet AETextFieldValidator *txtPassword;
    IBOutlet AETextFieldValidator *txtConfirmPass;
    IBOutlet AETextFieldValidator *txtPhone;
    AETextFieldValidator *txtDemo;
    
    
    IBOutlet UIView *viewContainer;
    IBOutlet UIScrollView *scrlView;
    __weak IBOutlet UIStackView *formFieldsContainer;
    
}
- (IBAction)btnSubmit:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupAlerts];
    
    txtDemo=[[AETextFieldValidator alloc] init];
    txtDemo.translatesAutoresizingMaskIntoConstraints = NO;
    txtDemo.borderStyle=UITextBorderStyleRoundedRect;
    txtDemo.placeholder=@"Programmatically created - Email";
    txtDemo.delegate=self;
    txtDemo.presentInView= viewContainer;
    txtDemo.validateOnResign = YES;

    
    [formFieldsContainer addArrangedSubview:txtDemo];
    [formFieldsContainer didAddSubview:txtDemo];
    //[formFieldsContainer layoutSubviews];
    [txtDemo addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    txtDemo.delegate=self;
}

-(void)setupAlerts{
    [txtUserName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [txtUserName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    txtUserName.validateOnResign=NO;
    
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
    [txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    txtPhone.isMandatory=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSubmit:(id)sender {
    if([txtUserName validate] & [txtEmail validate] & [txtPassword validate] & [txtConfirmPass validate] & [txtPhone validate] & [txtDemo validate]){

    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(txtDemo==textField){
//        [scrlView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
