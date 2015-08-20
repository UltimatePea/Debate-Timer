//
//  GenericTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CommonViewController.h"
@class XFramework;
@interface GenericTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *arrayToReturnCount;
- (NSString *)titleLabelForObjectInArray:(id)object;

- (BOOL)didSelectObjectInArray:(id)object;//return NO if you want to deselect
- (NSString *)reuseID;
- (void)prepareForSegueForDestVC:(UIViewController *)destinationViewController forObjectInArray:(id)object;

//optional
- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object;
- (BOOL)canEditTable;//NO
- (BOOL)canAddItem;//NO
- (void)addNewItem:(void(^)(id addedItem))completionBlock;
- (BOOL)shouldDeleteObject:(id)object;//YES
- (void)confirmDeleting:(id)objectToBeDeleted completion:(void (^)(BOOL ifDelete))completionBlock;
@end
