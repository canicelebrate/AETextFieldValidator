//
//  AETextFieldValidator.m
//  AETextfield Error Handle
//
//  Created by William Wang on 10/18/2016.
//  Copyright (c) 2016 William Wang. All rights reserved.
//

#import "AETextFieldValidator.h"

@interface IQPopUp : UIView

@property (nonatomic,assign) CGRect showOnRect;
@property (nonatomic,assign) int popWidth;
@property (nonatomic,assign) CGRect fieldFrame;
@property (nonatomic,copy) NSString *strMsg;
    
    
@property (nonatomic,strong) UIImageView* iv;
@property (nonatomic,strong) UILabel* lblInPopup;
@property (nonatomic,strong) UIView* popUpView;
@property (nonatomic,assign) BOOL constraintUpdated;
    
//Appearance customization
@property (nonatomic,retain) UIColor *popUpColor;
@property (nonatomic,strong) UIColor* popUpFontColor;
@property (nonatomic,strong) UIColor* popUpShadowColor;
@property (nonatomic,assign) CGFloat popUpShadowRadius;
@property (nonatomic,strong) UIFont* popUpFont;
@property (nonatomic,assign) CGFloat popUpCornerRadius;


    

@end

@implementation IQPopUp
    
-(instancetype)initWithFrame:(CGRect)frame{
    IQPopUp* this = [super initWithFrame:frame];
    if(this){
        this.popUpCornerRadius = kPopupCornerRadius;
        this.popUpShadowRadius = kPopupShadowRadius;
    }
    return this;
}

    
-(void)layoutSubviews{
    [super layoutSubviews];
    
    const CGFloat *color=CGColorGetComponents(self.popUpColor.CGColor);
    
    
    //draw down arrow
    UIGraphicsBeginImageContext(CGSizeMake(30, 20));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, color[0], color[1], color[2], 1);
    
    UIColor* shadowColor = nil;
    if(self.popUpShadowColor){
        shadowColor = self.popUpShadowColor;
    }
    else{
        shadowColor = [UIColor blackColor];
    }
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 5.0, shadowColor.CGColor);
    CGPoint points[3] = { CGPointMake(15, 5), CGPointMake(25, 25),
        CGPointMake(5,25)};
    CGContextAddLines(ctx, points, 3);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end draw down arrow
    
    
    
    if(!self.iv){
        UIImageView *img=[[UIImageView alloc] initWithImage:viewImage highlightedImage:nil];
        [self addSubview:img];
        img.translatesAutoresizingMaskIntoConstraints=NO;
        self.iv = img;
    }
    
    if(!self.popUpView){
        UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
        [self insertSubview:view belowSubview:self.iv];
        view.backgroundColor=self.popUpColor;
        view.layer.cornerRadius=self.popUpCornerRadius;
        
        view.layer.shadowRadius=5.0;
        view.layer.shadowColor = [shadowColor CGColor];
        view.layer.shadowOffset=CGSizeMake(0, 0);
        view.layer.shadowOpacity=1.0;
        
        //view.layer.shadowColor=[[UIColor blackColor] CGColor];
        //view.layer.shadowRadius=5.0;
        //view.layer.shadowOpacity=1.0;
        //view.layer.shadowOffset=CGSizeMake(0, 0);
        view.translatesAutoresizingMaskIntoConstraints=NO;
        self.popUpView = view;
    }
    
    if(!self.lblInPopup){
        UIFont* font = nil;
        if(self.popUpFont){
            font = self.popUpFont;
        }
        else{
            font=[UIFont fontWithName:kFontName size:kFontSize];
        }
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectZero];
        lbl.font=font;
        lbl.numberOfLines=0;
        lbl.backgroundColor=[UIColor clearColor];
        lbl.text=self.strMsg;
        UIColor* fontColor = nil;
        if(self.popUpFontColor){
            fontColor = self.popUpFontColor;
        }
        else{
            fontColor = kColorFont;
        }
        lbl.textColor=fontColor;
        [self.popUpView addSubview:lbl];
        
        lbl.translatesAutoresizingMaskIntoConstraints=NO;
        self.lblInPopup = lbl;
    }
    
}
    
-(void)updateConstraints{
    [super updateConstraints];
    if(self.constraintUpdated){
        return;
    }
    else{
        NSDictionary *dict = nil;
        CGRect imgframe = CGRectZero;
        //image view
        //
        if(self.iv){
            imgframe=CGRectMake((self.showOnRect.origin.x+((self.showOnRect.size.width-30)/2)), ((self.showOnRect.size.height/2)+self.showOnRect.origin.y), 30, 13);
            dict=NSDictionaryOfVariableBindings(_iv);
            [self.iv.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_iv(%f)]",imgframe.origin.x,imgframe.size.width] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
            [self.iv.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_iv(%f)]",imgframe.origin.y,imgframe.size.height] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
        }
        
        //popup
        if(self.popUpView){
            dict=NSDictionaryOfVariableBindings(_popUpView);
            [self.popUpView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_popUpView(%f)]",self.fieldFrame.origin.x+(self.fieldFrame.size.width-([self lblSize].width+(kPaddingInErrorPopUp*2))),[self lblSize].width+(kPaddingInErrorPopUp*2)] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
            [self.popUpView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_popUpView(%f)]",imgframe.origin.y+imgframe.size.height -1.0 ,[self lblSize].height+(kPaddingInErrorPopUp*2)] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
        }
        
        //label
        if(self.lblInPopup){
            dict=NSDictionaryOfVariableBindings(_lblInPopup);
            [self.lblInPopup.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_lblInPopup(%f)]",(float)kPaddingInErrorPopUp,[self lblSize].width] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
            [self.lblInPopup.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_lblInPopup(%f)]",(float)kPaddingInErrorPopUp,[self lblSize].height] options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
        }
        
        if(self.iv || self.popUpView || self.lblInPopup){
            self.constraintUpdated = YES;
        }
    }
}
    
-(CGSize)lblSize{
    UIFont* font = nil;
    if(self.popUpFont){
        font = self.popUpFont;
    }
    else{
        font=[UIFont fontWithName:kFontName size:kFontSize];
    }

    CGSize size=[self.strMsg boundingRectWithSize:CGSizeMake(self.fieldFrame.size.width-(kPaddingInErrorPopUp*2), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    size=CGSizeMake(ceilf(size.width), ceilf(size.height));
    return size;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    return NO;
}

@end

@interface TextFieldValidatorSupport : NSObject<UITextFieldDelegate>

@property (nonatomic,retain) id<UITextFieldDelegate> delegate;
@property (nonatomic,assign) BOOL validateOnCharacterChanged;
@property (nonatomic,assign) BOOL validateOnResign;
@property (nonatomic,unsafe_unretained) IQPopUp *popUp;
@end

@implementation TextFieldValidatorSupport
@synthesize delegate,validateOnCharacterChanged,popUp,validateOnResign;

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [delegate textFieldShouldBeginEditing:textField];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [delegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [delegate textFieldShouldEndEditing:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [delegate textFieldDidEndEditing:textField];
    [popUp removeFromSuperview];
    if(validateOnResign)
        [(AETextFieldValidator *)textField validate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [(AETextFieldValidator *)textField dismissPopup];
    if(validateOnCharacterChanged)
        [(AETextFieldValidator *)textField performSelector:@selector(validate) withObject:nil afterDelay:0.1];
    else
        [(AETextFieldValidator *)textField setRightView:nil];
    if([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [delegate textFieldShouldClear:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [delegate textFieldShouldReturn:textField];
    return YES;
}

-(void)setDelegate:(id<UITextFieldDelegate>)dele{
    delegate=dele;
}

@end


@interface AETextFieldValidator(){
    TextFieldValidatorSupport *supportObj;
    NSString *strMsg;
    NSMutableArray *arrRegx;
    IQPopUp *popUp;
}

-(void)tapOnError;

@end

@implementation AETextFieldValidator
@synthesize presentInView,validateOnCharacterChanged,popUpColor,isMandatory,validateOnResign,errorImg;

#pragma mark - Default Methods of UIView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self innerSetup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        [self innerSetup];
    }

    return self;
}
    
-(void)innerSetup{
    arrRegx=[[NSMutableArray alloc] init];
    validateOnCharacterChanged=YES;
    isMandatory=YES;
    validateOnResign=YES;

    supportObj=[[TextFieldValidatorSupport alloc] init];
    supportObj.validateOnCharacterChanged=validateOnCharacterChanged;
    supportObj.validateOnResign=validateOnResign;
    NSNotificationCenter *notify=[NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(didHideKeyboard) name:UIKeyboardWillHideNotification object:nil];
}

-(void)setDelegate:(id<UITextFieldDelegate>)deleg{
    supportObj.delegate=deleg;
    super.delegate=supportObj;
}

-(void)setValidateOnCharacterChanged:(BOOL)validate{
    supportObj.validateOnCharacterChanged=validate;
    validateOnCharacterChanged=validate;
}

-(void)setValidateOnResign:(BOOL)validate{
    supportObj.validateOnResign=validate;
    validateOnResign=validate;
}

#pragma mark - Public methods
-(void)addRegx:(NSString *)strRegx withMsg:(NSString *)msg{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:strRegx,@"regx",msg,@"msg", nil];
    [arrRegx addObject:dic];
}


-(void)addConfirmValidationTo:(AETextFieldValidator *)txtConfirm withMsg:(NSString *)msg{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:txtConfirm,@"confirm",msg,@"msg", nil];
    [arrRegx addObject:dic];
}

-(BOOL)validate{
    if(isMandatory){
        if([self.text length]==0){
            NSString* errorMsg = nil;
            if(self.mandatoryInvalidMsg){
                errorMsg = self.mandatoryInvalidMsg;
            }
            else{
                errorMsg = [kMandoatoryInvalidMsg copy];
            }
            [self showErrorIconForMsg:errorMsg];
            return NO;
        }
    }
    for (int i=0; i<[arrRegx count]; i++) {
        NSDictionary *dic=[arrRegx objectAtIndex:i];
        if([dic objectForKey:@"confirm"]){
            AETextFieldValidator *txtConfirm=[dic objectForKey:@"confirm"];
            if(![txtConfirm.text isEqualToString:self.text]){
                [self showErrorIconForMsg:[dic objectForKey:@"msg"]];
                return NO;
            }
        }else if(![[dic objectForKey:@"regx"] isEqualToString:@""] && [self.text length]!=0 && ![self validateString:self.text withRegex:[dic objectForKey:@"regx"]]){
            [self showErrorIconForMsg:[dic objectForKey:@"msg"]];
            return NO;
        }
    }
    self.rightView=nil;
    return YES;
}

-(void)dismissPopup{
    [popUp removeFromSuperview];
}

#pragma mark - Internal Methods

-(void)didHideKeyboard{
    [popUp removeFromSuperview];
}

-(void)tapOnError{
    [self showErrorWithMsg:strMsg];
}

- (BOOL)validateString:(NSString*)stringToSearch withRegex:(NSString*)regexString {
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [regex evaluateWithObject:stringToSearch];
}

-(void)showErrorIconForMsg:(NSString *)msg{
    UIButton *btnError=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnError addTarget:self action:@selector(tapOnError) forControlEvents:UIControlEventTouchUpInside];
    
    NSBundle* bundle = [NSBundle bundleForClass:[AETextFieldValidator class]];
    UIImage* img;
    if(!self.errorImg){
        img = [UIImage imageNamed:kIconImageName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    else{
        img = self.errorImg;
    }
  
    [btnError setBackgroundImage:img forState:UIControlStateNormal];
    self.rightView=btnError;
    self.rightViewMode=UITextFieldViewModeAlways;
    strMsg=[msg copy];
}

-(void)showErrorWithMsg:(NSString *)msg{
    popUp=[[IQPopUp alloc] initWithFrame:CGRectZero];
    popUp.strMsg=msg;
    if(self.popUpColor){
        popUp.popUpColor=self.popUpColor;
    }
    else{
        popUp.popUpColor = kColorPopUpBg;
    }
    
    if(self.popUpFontColor){
        popUp.popUpFontColor = self.popUpFontColor;
    }
    else{
        popUp.popUpFontColor = kColorFont;
    }
    
    UIColor* shadowColor = nil;
    if(self.popUpShadowColor){
        shadowColor = self.popUpShadowColor;
    }
    else{
        shadowColor = [UIColor blackColor];
    }
    popUp.popUpShadowColor = shadowColor;
    popUp.popUpShadowRadius = self.popUpShadowRadius;
    
    popUp.popUpCornerRadius = self.popUpCornerRadius;
    
    UIFont* font = nil;
    if(self.popUpFont){
        font = self.popUpFont;
    }
    else{
        font=[UIFont fontWithName:kFontName size:kFontSize];
    }
    popUp.popUpFont = font;
    
    popUp.showOnRect=[self convertRect:self.rightView.frame toView:presentInView];
    popUp.fieldFrame=[self.superview convertRect:self.frame toView:presentInView];
    popUp.backgroundColor=[UIColor clearColor];
    [presentInView addSubview:popUp];
    
    popUp.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary *dict=NSDictionaryOfVariableBindings(popUp);
    [popUp.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[popUp]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    [popUp.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[popUp]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing  metrics:nil views:dict]];
    supportObj.popUp=popUp;
}

@end
