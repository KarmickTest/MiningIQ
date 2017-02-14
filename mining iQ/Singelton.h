//
//  Singelton.h
//  testk
//
//  Created by Karmick 7 on 01/10/15.
//  Copyright (c) 2015 Karmick 7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Singelton : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>{

    NSString *firstname;
    NSString *lastname;
    NSString *userid;
    NSString *usertype;
   
}
+(Singelton *)getInstance;
-(NSString *)demoMethod:(NSString*)outputString;
-(void)jsonparse:(void(^)(NSDictionary* result))handler andString:(NSString*) yourString;
-(void)jsonParseWithPostMethod:(void(^)(NSDictionary* result))handler andString:(NSString*) yourString andParam:(NSString *)params;
-(BOOL)IsBlank:(NSString *)str;
-(NSString *)trim:(NSString *)str;
-(void)saveDefaults:(NSDictionary *)result;
-(void)saveDefaultsGuest;
-(BOOL)isDeviceLocalizationArabic;
-(void)ButtonEdgeChange:(UIButton *)button spacing:(float)space;
-(NSString *)deviceID;
-(BOOL)isNumeric:(NSString*)inputString;
- (BOOL)isValidPassword:(NSString*)password;
-(NSString *)getLoginId;
-(NSString *)getDeviceToken;
-(NSMutableArray *)dataFromCoredata:(NSString *)entityName;
- (BOOL)validateEmailWithString:(NSString*)email;
@property (strong,nonatomic) NSString *firstname;
@property (strong,nonatomic) NSString *lastname;
@property (strong,nonatomic) NSString *userid;
@property (strong,nonatomic) NSString *usertype;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *profileimgUrl;
@property (strong,nonatomic) NSString *strAddress;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
