//
//  MyRemindersViewController.h
//  mining iQ
//
//  Created by Admin on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRemindersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *openMenu;
- (IBAction)btnOpenMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *topHeaderView;
@property (weak, nonatomic) IBOutlet UIView *footerView;


@end
