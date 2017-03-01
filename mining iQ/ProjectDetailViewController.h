//
//  ProjectDetailViewController.h
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailTableViewCell.h"

@interface ProjectDetailViewController : UIViewController
{
    ProjectDetailTableViewCell *cell;
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;

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


@property (nonatomic,strong) NSString *strID_Carry;

@end
