//
//  ViewController.m
//  UISearchBar
//
//  Created by 谢鑫 on 2019/7/6.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *dataList;//总数据
@property(nonatomic,strong)NSMutableArray *searchList;//搜索的结果数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建searchBar
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 40,UIScreen.mainScreen.bounds.size.width, 60)];
    //2.searchBar属性设置
    _searchBar.barStyle=UIBarStyleDefault;
    _searchBar.searchBarStyle=UISearchBarStyleDefault;
    _searchBar.text=@"收索框";
    //_searchBar.prompt=@"prompt";
    _searchBar.placeholder=@"占位符";
    
    _searchBar.showsBookmarkButton=YES;
   // _searchBar.showsSearchResultsButton=YES;
    
    _searchBar.showsCancelButton=YES;
    _searchBar.tintColor=[UIColor yellowColor];
    _searchBar.barTintColor=[UIColor redColor];
    _searchBar.translucent=YES;
    //输入框和输入文字的调整
    //白色的那个输入框的偏移
    _searchBar.searchFieldBackgroundPositionAdjustment=UIOffsetMake(0, 0);
    //输入的文字的位置偏移
    _searchBar.searchTextPositionAdjustment=UIOffsetMake(0, 0);
    //特定图片修改
    [_searchBar setImage:[UIImage imageNamed:@"1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    //设置代理
    _searchBar.delegate=self;
    [self.view addSubview:_searchBar];
    [self myTableView];
    
}
//懒加载初始化
-(NSMutableArray*)dataList{
    if(!_dataList){
        _dataList=[[NSMutableArray alloc]initWithCapacity:120];
        for(NSInteger i=0;i<120;i++){
            [_dataList addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return _dataList;
}
-(NSMutableArray*)searchList{
    if(!_searchList){
        _searchList=[[NSMutableArray alloc]init];
    }
    return _searchList;
}
- (UITableView *)myTableView{
    if(_myTableView==nil){
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 110, 375, self.view.bounds.size.height-70) style:UITableViewStylePlain];
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    if(self.searchList !=nil&& self.searchList.count>0){
        NSInteger row=[indexPath row];
        cell.textLabel.text=[self.searchList objectAtIndex:row];
    }
    return cell;
}
//询问搜索框是否允许编辑使用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return  YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"DidBegin");
}
//询问搜索框是否允许编辑结束编辑
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"DidEnd");
}
//是否允许输入框内容改变
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //NSLog(@"%lu",(unsigned long)range.length);
   // NSLog(@"%lu",(unsigned long)range.location);
    if(range.location>=10)
    {
        return  NO;
    }
    return YES;
}
//当输入框内容发生改变时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //NSLog(@"textDidChange");
    //NSLog(@"%@",searchText);
    if(searchText!=nil&&searchText.length>0){
        _searchList=[NSMutableArray array];//需要清空searchList数组，否则原来的数据会一直存在
        for(NSString *tempStr in self.dataList){
            //对比数据
            if ([tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch].length>0) {
                [self.searchList addObject:tempStr];
                NSLog(@"%ld",[self.searchList count]);
            }
        }
        [self.myTableView reloadData];
    }else{//当收索框为空时，搜索结果为全部数据
        self.searchList=[NSMutableArray arrayWithArray:self.dataList];
        [self.myTableView reloadData];    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"SearchButton");
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"BookmarkButton");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"CancelButton");
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"ResultsListButton");
}
//基本不会用到
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
}
@end
