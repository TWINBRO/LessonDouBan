//
//  TheaterMapViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterMapViewController.h"
// 显示地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>
// 地图编码(根据位置信息检索)
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface TheaterMapViewController ()<BMKGeoCodeSearchDelegate,BMKMapViewDelegate>
// 地图view
@property (strong, nonatomic) BMKMapView* mapView;
@property (strong, nonatomic) BMKGeoCodeSearch *searcher;

@end

@implementation TheaterMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight)];
    _mapView.zoomLevel = 17;
    self.view = _mapView;
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= @"北京市";
    //geoCodeSearchOption.address = @"海淀区上地10街10号";
    geoCodeSearchOption.address = self.model.address;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
   // [geoCodeSearchOption release];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    //设置代理
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    //当不适用地图的时候,把代理设置为 nil
    _mapView.delegate = nil;
}

// 编码的代理方法
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSLog(@"search result = %@",result);
    // 添加一个大头针
    BMKPointAnnotation* pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = result.location;
    pointAnnotation.title = result.address;
    
    [_mapView addAnnotation:pointAnnotation];
    // 设置当前地点为地图中心点
    _mapView.centerCoordinate = result.location;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void) viewDidAppear:(BOOL)animated {
//    // 添加一个大头针
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    annotation.coordinate = coor;
//    annotation.title = @"这里是北京";
//    [_mapView addAnnotation:annotation];
//}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 大头针标识符
    NSString *annotationViewID = @"annotationID";
    // 根据标识符,查找一个可复用的大头针
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
    // 如果没有可复用的大头针,就创建一个新的大头针,并加上标识符
    // BMKPinAnnotationView 是BMKAnnotationView子类,添加了颜色以及一个动画效果
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationViewID];
        // 设置颜色
        ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorGreen;
        // 设置动画效果(从天而降)
        ((BMKPinAnnotationView *)annotationView).animatesDrop = YES;
    }
    annotationView.annotation = annotation;
    // 设置可以点击大头针弹出信息
    annotationView.canShowCallout = YES;
    return annotationView;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
