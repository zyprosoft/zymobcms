//
//  BFImageListViewController.m
//  PPFIphone
//
//  Created by ZYVincent on 12-8-23.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFImageListViewController.h"

@interface BFImageListViewController ()

@end

@implementation BFImageListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    [sourceArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    sourceArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (int i=0; i<3; i++) {
        NSMutableArray *each = [NSMutableArray arrayWithCapacity:0];
        [each addObject:@"http://pic1.ooopic.com/uploadfilepic/sheying/2009-04-18/OOOPIC_changyue1903_2009041827a338413dd65176.jpg"];
        [each addObject:@"http://www.taopic.com/uploads/allimg/120214/2238-1202141k22554.jpg"];
        [each addObject:@"http://pic12.nipic.com/20110111/2457331_113917865334_2.jpg"];
        [each addObject:@"http://www.lalilawai.com/updata/XianHuaSuDi_DanGaoPeiSong_YuanYiHuaYi_613/XianHuaSuDi_XianHuaTianHeQuShenZhen_ShenZhenXianHuaDianQuanGuoPeiSong_HangZhouMeiGuiHua_9067378562.jpg"];
        [each addObject:@"http://pic17.nipic.com/20111026/7347859_101459253000_2.jpg"];
        
        [each addObject:@"http://img9.3lian.com/c1/vector2/22/42/d/82.jpg"];
        [each addObject:@"http://hiphotos.baidu.com/dxzwnj/pic/item/68eab49727d1c94c54fb965d.jpg"];
        [each addObject:@"http://www3.365shu.com/images3/wall/20050929/001/001-rose004.jpg"];
        [each addObject:@"http://pic6.nipic.com/20100307/1295091_143422816139_2.jpg"];
        [each addObject:@"http://www.hrcq.com/UploadFile/2010121017611453.jpg"];
        [each addObject:@"http://www.sxn8452.com/qianguogedi.files/shihua.shishu/hnly1.jpg"];
        [each addObject:@"http://www.邮政鲜花网.com/8452/qianguogedi.files/shihua.shishu/gxly1.jpg"];
        [each addObject:@"http://www.zgxh.org/8452/qianguogedi.files/shihua.shishu/gdst1.jpg"];
        [each addObject:@"http://pic12.nipic.com/20110222/2531170_130024073555_2.jpg"];
        [each addObject:@"http://pic8.nipic.com/20100715/5060814_214331042410_2.jpg"];
        
        [each addObject:@"http://pic1a.nipic.com/2009-02-07/20092723148538_2.jpg"];
        [each addObject:@"http://pic4.nipic.com/20091008/2032802_090419336794_2.jpg"];
        [each addObject:@"http://pic8.nipic.com/20100804/1384561_174438398393_2.jpg"];
        [each addObject:@"http://pic6.nipic.com/20100310/2025710_140306067381_2.jpg"];
        [each addObject:@"http://pic7.nipic.com/20100527/2928847_132804029691_2.jpg"];
        [each addObject:@"http://863dh.com/baike/zhiwu/huahui/P/007a.jpg"];
        [each addObject:@"http://www.dabaoku.com/sucai/zhiwu/meigui/040bn.jpg"];
        [each addObject:@"http://pic6.nipic.com/20100310/2025710_142637071634_2.jpg"];
        [each addObject:@"http://pic4.nipic.com/20091029/98170_193726002600_2.jpg"];
        [each addObject:@"http://pic5.nipic.com/20100127/47541_001936133519_2.jpg"];
        
        [each addObject:@"http://pic4.nipic.com/20091018/3583546_172423065035_2.jpg"];
        [each addObject:@"http://pic8.nipic.com/20100729/3320946_111305001958_2.jpg"];
        [each addObject:@"http://pic9.nipic.com/20100819/2572038_010239539196_2.jpg"];
        [each addObject:@"http://pic12.nipic.com/20110104/5090749_183744662000_2.jpg"];
        [each addObject:@"http://a2.att.hudong.com/33/36/300000739452130383360093116_950.jpg"];
        [sourceArray addObject:each];
    }

    
    //设置视图
    _imageListView = [[BFImageListView alloc]initWithDataSource:self withDelegate:self withFrame:CGRectMake(0, 0, 320, 480)];
    
    [self.view addSubview:_imageListView];
    
    [_imageListView release];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - ImageListDelegate and DataSource

//设置有多少列
- (NSInteger)numberOfCloumsInImageList:(BFImageListView *)imageList
{
    return [sourceArray count];
}

//设置每一列有多少行
- (NSInteger)numberofRowsInImageList:(BFImageListView *)imageList inCloum:(NSInteger)nCloum
{
    return [[sourceArray objectAtIndex:nCloum]count];
}

//设置有多少行在当前屏幕可见
- (NSInteger)numberOfVisiableSubviewsForEachCloumnInImageList:(BFImageListView *)imageList
{
    return 4;
}

//设置横向两个子视图之间的间隔
- (CGFloat)gapWidthBetweenSubviewInImageList:(BFImageListView *)imageList
{
    return 10;
}

//设置纵向两个子视图之间的间隔
- (CGFloat)gapHeightBetweenSubviewInImageList:(BFImageListView *)imageList
{
    return 10;
}


//设置每一个视图
- (BFImageListCell*)imageListView:(BFImageListView *)imageList cellViewForIndexPath:(BFIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    
    BFImageListCell *cell = [imageList dequeuReuseWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[BFImageListCell alloc]initWithIdentifier:identifier]autorelease];
    }
    
    //set cell color
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//点击某个视图时的方法
- (void)imageListView:(BFImageListView *)imageList didSelectAtIndexPath:(BFIndexPath *)indexPath
{
    NSLog(@"did selected at indexpat cloum is ==> %d, row is ==>%d",indexPath.cloum,indexPath.row);
}


@end
