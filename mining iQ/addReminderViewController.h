//
//  addReminderViewController.h
//  mining iQ
//
//  Created by Anirban on 02/03/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"


@interface addReminderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CKCalendarDelegate>
{
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    UIView *clear_View;
    
    UIView *background_View;
    UIView *popUp_View;
    
    
    CKCalendarView *calendar;
    
}
- (IBAction)btn_Project:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ProjectBtn;
@property (strong, nonatomic) IBOutlet UITextField *txtFld_Name;

- (IBAction)btn_Update:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Update_Btn;

@property (strong,nonatomic) NSMutableArray *arr_ProjectDetails;


@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property (strong, nonatomic) IBOutlet UITextView *textView_Description;
- (IBAction)Btn_Submit:(id)sender;

@property (strong, nonatomic) NSString *str_Project_ID, *str_Date;

@end
