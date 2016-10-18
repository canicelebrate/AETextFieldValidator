//
//  AETextFieldValidator.h
//  Textfield Validation Handler
//
//  Created by William Wang on 10/18/2016.
//  Copyright (c) 2016 William Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    Image name for showing error on textfield.
 */
#define kIconImageName @"error"

/**
    Background color of message popup.
 */
#define kColorPopUpBg [UIColor colorWithRed:0.702 green:0.000 blue:0.000 alpha:1.000]

#define kPopupCornerRadius   3.0f

#define kPopupShadowRadius  5.0f
/**
    Font color of the message.
 */
#define kColorFont [UIColor whiteColor]

/**
    Font size of the message.
 */
#define kFontSize 15

/**
    Font style name of the message.
 */
#define kFontName @"Helvetica-Bold"

/**
    Padding in pixels for the popup.
 */
#define kPaddingInErrorPopUp 5

/**
    Default message for validating length, you can also assign message separately using method 'updateLengthValidationMsg:' for textfields.
 */
#define kMandoatoryInvalidMsg @"This field cannot be blank"


/**
    TextFieldValidator is the inherited class of UITextField for performing validation effectively. This class will handle all kind of validations with just few lines of code using regex and it is fully customisable. You can easily port this functionality in your existing code as well, you just need to change class name from UITextField to TextFieldValidator and apply regex for performing validation.
 */
NS_CLASS_AVAILABLE_IOS(6_0) @interface AETextFieldValidator : UITextField<UITextFieldDelegate>{

}

@property (nonatomic,strong) UIImage* errorImg UI_APPEARANCE_SELECTOR;
    
@property (nonatomic,assign) BOOL isMandatory;   /**< Default is YES*/

@property (nonatomic,retain) IBOutlet UIView *presentInView;    /**< Assign view on which you want to show popup and it would be good if you provide controller's view*/

@property (nonatomic,retain) UIColor *popUpColor UI_APPEARANCE_SELECTOR;   /**< Assign popup background color, you can also assign default popup color from macro "ColorPopUpBg" at the top*/
    
@property (nonatomic,assign) CGFloat popUpCornerRadius UI_APPEARANCE_SELECTOR;   /**< Assign popup corner radius, you can also assign default popup color from macro "kPopupCornerRadius" at the top*/
    
@property (nonatomic,strong) UIColor* popUpShadowColor UI_APPEARANCE_SELECTOR;/**< Assign popup border shadow color, default shadow color is black*/
@property (nonatomic,assign) CGFloat popUpShadowRadius UI_APPEARANCE_SELECTOR;/**< Assign popup border shadow color, default shadow color from macro "kPopupShadowRadius" at the top*/

 
    
    
@property (nonatomic,retain) UIColor* popUpFontColor UI_APPEARANCE_SELECTOR;/**< Assign popup font color, you can also assign default popup font color from macro "ColorFont" at the top*/
    
@property (nonatomic,retain) UIFont* popUpFont UI_APPEARANCE_SELECTOR;/**< Assign popup font, you can also prepare default popup font from macro "FontName" and "FontSize" at the top
    default font name:Helvetica-Bold and font-size:15*/
    
@property (nonatomic,strong) NSString* mandatoryInvalidMsg UI_APPEARANCE_SELECTOR;/**< Assign popup message when mandatory field is invalid, you can also assign default message from macro "kMandoatoryInvalidMsg" at the top*/
    
    
@property (nonatomic,assign) BOOL validateOnCharacterChanged; /**< Default is YES, Use it whether you want to validate text on character change or not.*/

@property (nonatomic,assign) BOOL validateOnResign; /**< Default is YES, Use it whether you want to validate text on resign or not.*/

/**
    Use to add regex for validating textfield text, you need to specify all your regex in queue that you want to validate and their messages respectively that will show when any regex validation will fail.
    @param strRegx Regex string
    @param msg Message string to be displayed when given regex will fail.
 */
-(void)addRegx:(NSString *)strRegx withMsg:(NSString *)msg;


/**
    Use to add validation for validating confirm password
    @param txtPassword Hold reference of password textfield from which they will check text equality.
 */
-(void)addConfirmValidationTo:(AETextFieldValidator *)txtPassword withMsg:(NSString *)msg;

/**
    Use to perform validation
    @return Bool It will return YES if all provided regex validation will pass else return NO
 
    Eg: If you want to apply validation on all fields simultaneously then refer below code which will be make it easy to handle validations
    if([txtField1 validate] & [txtField2 validate]){
        // Success operation
    }
 */
-(BOOL)validate;

/**
    Use to dismiss error popup.
 */
-(void)dismissPopup;

@end
