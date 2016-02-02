//
//  MainViewController.m
//  Talk2Me
//
//  Created by 刘凯 on 1/29/16.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "MainViewController.h"
#import "MessageViewController.h"

static NSString *const kTableViewCell = @"TableViewCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBarButton];
    
    self.title = @"Messages";
    
    [self setupTableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTableViewCell];
    cell.textLabel.text = @"Honey";
    cell.detailTextLabel.text = @"hello";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageViewController *vc = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private
- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupBarButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapLeftButton:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(didTapRightButton:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didTapLeftButton:(id)sender {
    
}

- (void)didTapRightButton:(id)sender {
    
}

@end
