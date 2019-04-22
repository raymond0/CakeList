//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import <Cake_List-Swift.h>

//
//  I was advised to complete the project in Swift, but I also said I'd retain objective-c code.
//  Normally a project of this size I'd recommend conversion to Swift, but as it's a demo project
//  perhaps the gradual conversion to Swift is more representative of the real world.
//

@interface MasterViewController ()
@property (strong, nonatomic) NSArray<Cake *> *cakeList;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cakeList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    Cake *cake = _cakeList[indexPath.row];
    cell.cake = cake;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)getData{
    [CakeApi.shared loadCakeDataWithCompletion:^(NSArray<Cake *> * _Nullable cakelist , NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil){
                [self displayError:error];
                return;
            }
            
            self.cakeList = cakelist;
            [self.tableView reloadData];
        });
    }];
}


-(void)displayError:(NSError *)error{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"Error"
                                                                 message:error.localizedDescription
                                                          preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"Ok"
                                           style:(UIAlertActionStyleDefault)
                                         handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
