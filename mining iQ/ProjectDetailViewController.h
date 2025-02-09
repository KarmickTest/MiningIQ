//
//  ProjectDetailViewController.h
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProjectDetailViewController : UIViewController
{
   
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    
    
    NSMutableArray *mArr_test;
    NSArray *Arr_key;
    
    BOOL isShowingList;

}

@property (weak, nonatomic) IBOutlet UILabel *projectDescriptionLbl;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *headerSubView;

@property (strong, nonatomic) IBOutlet UITableView *tbl_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ProjectName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_LocationContinent;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Region;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Country;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Province;
@property (strong, nonatomic) IBOutlet UILabel *lbl_City;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ProjectArea;
@property (strong, nonatomic) IBOutlet UILabel *lbl_CapitalValue;
@property (strong, nonatomic) IBOutlet UILabel *lbl_MineralName;

@property (nonatomic, strong) NSDictionary *dic_Carry;
@property (nonatomic,strong) NSString *strID_Carry;

@property (nonatomic, strong) NSMutableArray *isShowingList;
@property (nonatomic, strong) NSString *str_sectionName;

@end
