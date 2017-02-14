//
//  ProjectSearchViewController.h
//  mining iQ
//
//  Created by Somnath on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldTableViewCell.h"
#import "DropDownTableViewCell.h"
#import "MultiPleDropDownTableViewCell.h"

@interface ProjectSearchViewController : UIViewController
{
    TextFieldTableViewCell *textFieldCell;
    DropDownTableViewCell *dropDownCell;
    MultiPleDropDownTableViewCell *multipleDropDownCell;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerContainerView;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstant;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIView *searchMineOwnersView;
@property (weak, nonatomic) IBOutlet UIView *searchProjectEngineersView;
@property (weak, nonatomic) IBOutlet UIView *searchProjectSuppliersView;


@end
