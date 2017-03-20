//
//  ProjectofInterestViewController.h
//  mining iQ
//
//  Created by Karmick on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectofInterestViewController : UIViewController
{
     NSMutableArray*arr_ProjectDetails;
}

@property (weak, nonatomic) IBOutlet UITableView *Project_TableView;
- (IBAction)Back_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *viewMrBtn;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@end
