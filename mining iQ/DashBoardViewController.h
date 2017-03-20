//
//  DashBoardViewController.h
//  mining iQ
//
//  Created by Anirban on 06/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSideMenu.h"


@interface DashBoardViewController : UIViewController
{
    UIView *backgroundView, *spinnerView;
    UIActivityIndicatorView *spinner;

}

@property (nonatomic, strong) VKSideMenu *menu;
@property (strong,nonatomic) NSMutableArray *arr_ProjectDetails;

@end
