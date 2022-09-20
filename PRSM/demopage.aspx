﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="demopage.aspx.cs" Inherits="demopage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, shrink-to-fit=no" />
      <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
    <link href="assets/plugins/pace/pace-theme-flash.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="assets/plugins/jquery-scrollbar/jquery.scrollbar.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="assets/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="assets/plugins/nvd3/nv.d3.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="assets/plugins/mapplic/css/mapplic.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/rickshaw/rickshaw.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap-datepicker/css/datepicker3.css" rel="stylesheet" type="text/css" media="screen">
    <link href="assets/plugins/jquery-metrojs/MetroJs.css" rel="stylesheet" type="text/css" media="screen" />
    <link class="main-stylesheet" href="pages/css/pages.css" rel="stylesheet" type="text/css" />
    <!-- Please remove the file below for production: Contains demo classes -->
    <link class="main-stylesheet" href="assets/css/style.css" rel="stylesheet" type="text/css" />
	<style>
	.widget-8 {
    height: 165px;
}
	</style>
	
</head>
<body class="fixed-header dashboard">
    <form id="form1" runat="server">
        <div>

        </div>
    </form>

    <nav class="page-sidebar" data-pages="sidebar">
      <!-- BEGIN SIDEBAR MENU TOP TRAY CONTENT-->
      <div class="sidebar-overlay-slide from-top" id="appMenu">
        <div class="row">
          <div class="col-xs-6 no-padding">
            <a href="#" class="p-l-40"><img src="assets/img/demo/social_app.svg" alt="socail">
            </a>
          </div>
          <div class="col-xs-6 no-padding">
            <a href="#" class="p-l-10"><img src="assets/img/demo/email_app.svg" alt="socail">
            </a>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-6 m-t-20 no-padding">
            <a href="#" class="p-l-40"><img src="assets/img/demo/calendar_app.svg" alt="socail">
            </a>
          </div>
          <div class="col-xs-6 m-t-20 no-padding">
            <a href="#" class="p-l-10"><img src="assets/img/demo/add_more.svg" alt="socail">
            </a>
          </div>
        </div>
      </div>
      <!-- END SIDEBAR MENU TOP TRAY CONTENT-->
      <!-- BEGIN SIDEBAR MENU HEADER-->
      <div class="sidebar-header">
        <img src="assets/img/apaar-logo-web.png" alt="logo" class="brand" data-src="assets/img/apaar-logo-web.png" data-src-retina="assets/img/apaar-logo-web.png" width="78" height="22">
        <div class="sidebar-header-controls">
          <button aria-label="Toggle Drawer" type="button" class="btn btn-icon-link invert sidebar-slide-toggle m-l-20 m-r-10" data-pages-toggle="#appMenu">
            <i class="pg-icon">chevron_down</i>
          </button>
          <button aria-label="Pin Menu" type="button" class="btn btn-icon-link invert d-lg-inline-block d-xlg-inline-block d-md-inline-block d-sm-none d-none" data-toggle-pin="sidebar">
            <i class="pg-icon"></i>
          </button>
        </div>
      </div>
      <!-- END SIDEBAR MENU HEADER-->
      <!-- START SIDEBAR MENU -->
      <div class="sidebar-menu">
        <!-- BEGIN SIDEBAR MENU ITEMS-->
        <ul class="menu-items">
          <li class="m-t-20 ">
            <a href="index-2.html" class="detailed">
              <span class="title">Dashboard</span>
               <!--<span class="details">12 New Updates</span>-->
            </a>
            <span class="icon-thumbnail"><i class="pg-icon">home</i></span>
          </li>
          <li class="">
            <a href="email.html" class="detailed">
              <span class="title">Email</span>
              <!--<span class="details">234 New Emails</span>-->
            </a>
            <span class="icon-thumbnail"><i class="pg-icon">inbox</i></span>
          </li>
         
          <li>
		  
            <a href="javascript:;"><span class="title">Master</span>
            <span class=" arrow"></span></a>
            <span class="icon-thumbnail"><i class="pg-icon">calendar</i></span>
            <ul class="sub-menu">
              <li class="">
                <a href="calendar.html">Activity</a>
                <span class="icon-thumbnail"><i class="pg-icon">c</i></span>
              </li>
              <li class="">
                <a href="calendar_lang.html">Languages</a>
                <span class="icon-thumbnail"><i class="pg-icon">l</i></span>
              </li>
              <li class="">
                <a href="calendar_month.html">Box Location</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">City</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			   <li class="">
                <a href="calendar_month.html">Company Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
<li class="">
                <a href="calendar_lazy.html">Customer</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Rate Card</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Row Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
            </ul>
          </li>
          
		  <li>
		  
            <a href="javascript:;"><span class="title">Transactions</span>
            <span class=" arrow"></span></a>
            <span class="icon-thumbnail"><i class="pg-icon">calendar</i></span>
            <ul class="sub-menu">
              <li class="">
                <a href="calendar.html">Activity</a>
                <span class="icon-thumbnail"><i class="pg-icon">c</i></span>
              </li>
              <li class="">
                <a href="calendar_lang.html">Languages</a>
                <span class="icon-thumbnail"><i class="pg-icon">l</i></span>
              </li>
              <li class="">
                <a href="calendar_month.html">Box Location</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">City</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			   <li class="">
                <a href="calendar_month.html">Company Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
<li class="">
                <a href="calendar_lazy.html">Customer</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Rate Card</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Row Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
            </ul>
          </li>
		  
		  <li>
		  
            <a href="javascript:;"><span class="title">Users</span>
            <span class=" arrow"></span></a>
            <span class="icon-thumbnail"><i class="pg-icon">calendar</i></span>
            <ul class="sub-menu">
              <li class="">
                <a href="calendar.html">Activity</a>
                <span class="icon-thumbnail"><i class="pg-icon">c</i></span>
              </li>
              <li class="">
                <a href="calendar_lang.html">Languages</a>
                <span class="icon-thumbnail"><i class="pg-icon">l</i></span>
              </li>
              <li class="">
                <a href="calendar_month.html">Box Location</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">City</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			   <li class="">
                <a href="calendar_month.html">Company Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
<li class="">
                <a href="calendar_lazy.html">Customer</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Rate Card</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Row Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
            </ul>
          </li>
		 
         <li>
		  
            <a href="javascript:;"><span class="title">Reports</span>
            <span class=" arrow"></span></a>
            <span class="icon-thumbnail"><i class="pg-icon">calendar</i></span>
            <ul class="sub-menu">
              <li class="">
                <a href="calendar.html">Activity</a>
                <span class="icon-thumbnail"><i class="pg-icon">c</i></span>
              </li>
              <li class="">
                <a href="calendar_lang.html">Languages</a>
                <span class="icon-thumbnail"><i class="pg-icon">l</i></span>
              </li>
              <li class="">
                <a href="calendar_month.html">Box Location</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">City</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			   <li class="">
                <a href="calendar_month.html">Company Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">m</i></span>
              </li>
              <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
<li class="">
                <a href="calendar_lazy.html">Customer</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Rate Card</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Row Master</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
			  <li class="">
                <a href="calendar_lazy.html">Company Group</a>
                <span class="icon-thumbnail"><i class="pg-icon">la</i></span>
              </li>
            </ul>
          </li>
            </ul>
          </li>
          <li class="">
            <a href="charts.html"><span class="title">Charts</span></a>
            <span class="icon-thumbnail"><i class="pg-icon">chart</i></span>
          </li>
         
        
          <li class="">
            <a href="https://docs.pages.revox.io/" rel="noreferrer" target="_blank"><span class="title">Docs</span></a>
            <span class="icon-thumbnail"><i class="pg-icon">flag</i></span>
          </li>
          <li class="m-b-40">
            <a href="http://changelog.pages.revox.io/" rel="noreferrer" target="_blank"><span class="title">Changelog</span></a>
            <span class="icon-thumbnail"><i class="pg-icon">clipboard</i></span>
          </li>
        </ul>
        <div class="clearfix"></div>
      </div>
      <!-- END SIDEBAR MENU -->
    </nav>
    <!-- END SIDEBAR -->
    <!-- END SIDEBPANEL-->
    <!-- START PAGE-CONTAINER -->
    <div class="page-container ">
      <!-- START HEADER -->
      <div class="header ">
        <!-- START MOBILE SIDEBAR TOGGLE -->
        <a href="#" class="btn-link toggle-sidebar d-lg-none pg-icon btn-icon-link" data-toggle="sidebar">
      		menu</a>
        <!-- END MOBILE SIDEBAR TOGGLE -->
        <div class="">
          <div class="brand inline   ">
            <img src="assets/img/apaar-logo-web.png" alt="logo" data-src="assets/img/apaar-logo-web.png" data-src-retina="assets/img/apaar-logo-web.png" width="78" height="22">
          </div>
          <!-- START NOTIFICATION LIST -->
          <ul class="d-lg-inline-block d-none notification-list no-margin d-lg-inline-block b-grey b-l b-r no-style p-l-20 p-r-20">
            <li class="p-r-5 inline">
              <div class="dropdown">
                <a href="javascript:;" id="notification-center" class="header-icon  btn-icon-link" data-toggle="dropdown">
                  <i class="pg-icon">world</i>
                  <span class="bubble"></span>
                </a>
                <!-- START Notification Dropdown -->
                <div class="dropdown-menu notification-toggle" role="menu" aria-labelledby="notification-center">
                  <!-- START Notification -->
                  <div class="notification-panel">
                    <!-- START Notification Body-->
                    <div class="notification-body scrollable">
                      <!-- START Notification Item-->
                      <div class="notification-item unread clearfix">
                        <!-- START Notification Item-->
                        <div class="heading open">
                          <a href="#" class="text-complete pull-left d-flex align-items-center">
                            <i class="pg-icon m-r-10">map</i>
                            <span class="bold">Apaar Infosystems</span>
                            <span class="fs-12 m-l-10">Rahul Sawant</span>
                          </a>
                          <div class="pull-right">
                            <div class="thumbnail-wrapper d16 circular inline m-t-15 m-r-10 toggle-more-details">
                              <div><i class="pg-icon">chevron_down</i>
                              </div>
                            </div>
                            <span class=" time">few sec ago</span>
                          </div>
                          <div class="more-details">
                            <div class="more-details-inner">
                              <h5 class="semi-bold fs-16">“Apple’s Motivation - Innovation <br>
																															distinguishes between <br>
																															A leader and a follower.”</h5>
                              <p class="small hint-text">
                                Commented on john Smiths wall.
                                <br> via pages framework.
                              </p>
                            </div>
                          </div>
                        </div>
                        <!-- END Notification Item-->
                        <!-- START Notification Item Right Side-->
                        <div class="option" data-toggle="tooltip" data-placement="left" title="mark as read">
                          <a href="#" class="mark"></a>
                        </div>
                        <!-- END Notification Item Right Side-->
                      </div>
                      <!-- START Notification Body-->
                      <!-- START Notification Item-->
                      <div class="notification-item  clearfix">
                        <div class="heading">
                          <a href="#" class="text-danger pull-left">
                            <i class="pg-icon m-r-10">alert_warning</i>
                            <span class="bold">98% Server Load</span>
                            <span class="fs-12 m-l-10">Take Action</span>
                          </a>
                          <span class="pull-right time">2 mins ago</span>
                        </div>
                        <!-- START Notification Item Right Side-->
                        <div class="option">
                          <a href="#" class="mark"></a>
                        </div>
                        <!-- END Notification Item Right Side-->
                      </div>
                      <!-- END Notification Item-->
                      <!-- START Notification Item-->
                      <div class="notification-item  clearfix">
                        <div class="heading">
                          <a href="#" class="text-warning pull-left">
                            <i class="pg-icon m-r-10">alert_warning</i>
                            <span class="bold">Warning Notification</span>
                            <span class="fs-12 m-l-10">Buy Now</span>
                          </a>
                          <span class="pull-right time">yesterday</span>
                        </div>
                        <!-- START Notification Item Right Side-->
                        <div class="option">
                          <a href="#" class="mark"></a>
                        </div>
                        <!-- END Notification Item Right Side-->
                      </div>
                      <!-- END Notification Item-->
                      <!-- START Notification Item-->
                      <div class="notification-item unread clearfix">
                        <div class="heading">
                          <div class="thumbnail-wrapper d24 circular b-white m-r-5 b-a b-white m-t-10 m-r-10">
                            <img width="30" height="30" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" alt="" src="assets/img/profiles/1.jpg">
                          </div>
                          <a href="#" class="text-complete pull-left">
                            <span class="bold">Revox Design Labs</span>
                            <span class="fs-12 m-l-10">Owners</span>
                          </a>
                          <span class="pull-right time">11:00pm</span>
                        </div>
                        <!-- START Notification Item Right Side-->
                        <div class="option" data-toggle="tooltip" data-placement="left" title="mark as read">
                          <a href="#" class="mark"></a>
                        </div>
                        <!-- END Notification Item Right Side-->
                      </div>
                      <!-- END Notification Item-->
                    </div>
                    <!-- END Notification Body-->
                    <!-- START Notification Footer-->
                    <div class="notification-footer text-center">
                      <a href="#" class="">Read all notifications</a>
                      <a data-toggle="refresh" class="portlet-refresh text-black pull-right" href="#">
                        <i class="pg-refresh_new"></i>
                      </a>
                    </div>
                    <!-- START Notification Footer-->
                  </div>
                  <!-- END Notification -->
                </div>
                <!-- END Notification Dropdown -->
              </div>
            </li>
            <li class="p-r-5 inline">
              <a href="#" class="header-icon  btn-icon-link">
                <i class="pg-icon">link_alt</i>
              </a>
            </li>
            <li class="p-r-5 inline">
              <a href="#" class="header-icon  btn-icon-link">
                <i class="pg-icon">grid_alt</i>
              </a>
            </li>
          </ul>
          <!-- END NOTIFICATIONS LIST -->
          <a href="#" class="search-link d-lg-inline-block d-none" data-toggle="search"><i
      				class="pg-icon">search</i>Type anywhere to <span class="bold">search</span></a>
        </div>
        <div class="d-flex align-items-center">
          <!-- START User Info-->
          <div class="dropdown pull-right d-lg-block d-none">
            <button class="profile-dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" aria-label="profile dropdown">
              <span class="thumbnail-wrapper d32 circular inline">
      					<img src="assets/img/profiles/avatar.jpg" alt="" data-src="assets/img/profiles/avatar.jpg"
      						data-src-retina="assets/img/profiles/avatar_small2x.jpg" width="32" height="32">
      				</span>
            </button>
            <div class="dropdown-menu dropdown-menu-right profile-dropdown" role="menu">
              <a href="#" class="dropdown-item"><span>Signed in as <br /><b>Rahul Sawant</b></span></a>
              <div class="dropdown-divider"></div>
              <a href="#" class="dropdown-item">Your Profile</a>
              <a href="#" class="dropdown-item">Your Activity</a>
              <a href="#" class="dropdown-item">Your Archive</a>
              <div class="dropdown-divider"></div>
              <a href="#" class="dropdown-item">Features</a>
              <a href="#" class="dropdown-item">Help</a>
              <a href="#" class="dropdown-item">Settings</a>
              <a href="#" class="dropdown-item">Logout</a>
              <div class="dropdown-divider"></div>
              <span class="dropdown-item fs-12 hint-text">Last edited by David<br />on Friday at 5:27PM</span>
            </div>
          </div>
          <!-- END User Info-->
          <a href="#" class="header-icon m-l-5 sm-no-margin d-inline-block" data-toggle="quickview" data-toggle-element="#quickview">
            <i class="pg-icon btn-icon-link">menu_add</i>
          </a>
        </div>
      </div>
      <!-- END HEADER -->
      <!-- START PAGE CONTENT WRAPPER -->
      <div class="page-content-wrapper ">
        <!-- START PAGE CONTENT -->
        <div class="content sm-gutter">
          <!-- START CONTAINER FLUID -->
          <div class="container-fluid padding-25 sm-padding-10">
            <!-- START ROW -->
            <div class="row">
			
			
              <div class="col-lg-12 col-xlg-5">
               
                <div class="row">
                  <div class="col-sm-3 m-b-10">
                    <div class="ar-2-1">
                      <!-- START WIDGET widget_graphTile-->
                      <div class="widget-4 card   no-margin widget-loader-bar">
                        <div class="container-sm-height full-height d-flex flex-column">
                          <div class="card-header  ">
                            <div class="card-title text-black hint-text">
                              <span class="d-flex align-items-center"> 
						  <span class="font-montserrat fs-11 all-caps">Today's Entries </span>
                              <i class="pg-icon">chevron_right</i>
                              </span>
                            </div>
                            <div class="card-controls">
                              <ul>
                                <li><a href="#" class="card-refresh text-black" data-toggle="refresh"><i
								class="card-icon card-icon-refresh"></i></a>
                                </li>
                              </ul>
                            </div>
                          </div>
                          <div class="p-l-20 p-r-20">
                            <h5 class="no-margin p-b-5 pull-left text-success">BOXES</h5>
                            <p class="pull-right no-margin bold hint-text">2,563</p>
                            <div class="clearfix"></div>
                          </div>
                          <div class="widget-4-chart line-chart mt-auto" data-line-color="success" data-area-color="success-light" data-y-grid="false" data-points="false" data-stroke-width="2">
                            <svg></svg>
                          </div>
                        </div>
                      </div>
                      <!-- END WIDGET -->
                    </div>
                  </div>
                  <div class="col-sm-3 m-b-10">
				  
				  
                    <div class="ar-2-1">
                      <!-- START WIDGET widget_barTile-->
                      <div class="widget-5 card   widget-loader-bar">
                        <div class="card-header  pull-top top-right">
                          <div class="card-controls">
                            <ul>
                              <li><a data-toggle="refresh" class="card-refresh text-black" href="#"><i
							class="card-icon card-icon-refresh"></i></a>
                              </li>
                            </ul>
                          </div>
                        </div>
                        <div class="container-xs-height full-height">
                          <div class="row row-xs-height">
                            <div class="col-xs-5 col-xs-height col-middle relative">
                              <div class="padding-15 full-height d-flex flex-column justify-content-between">
                                <p class=" hint-text">Today's Invoices</p>
                                <div>
                                  <h3 class="hint-text no-margin text-ellipsis"><sup>₹</sup>9,534<sup>.58</sup></h3>
                                  <p class="text-success text-ellipsis">+₹423.5 (2.65%)</p>
                                </div>
                              </div>
                            </div>
                            <div class="col-xs-7 col-xs-height col-bottom relative widget-5-chart-container">
                              <div class="widget-5-chart"></div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- END WIDGET -->
                    </div>
                  </div>
				  
				  <div class="col-sm-3 m-b-10">
                    <!-- START WIDGET D3 widget_graphTileFlat-->
                    <div class="widget-8 card  bg-success no-margin widget-loader-bar">
                      <div class="container-xs-height full-height">
                        <div class="row-xs-height">
                          <div class="col-xs-height col-top">
                            <div class="card-header  top-left top-right">
                              <div class="card-title">
                                <span class="font-montserrat fs-11 all-caps">Weekly Sales </span>
                              </div>
                              <div class="card-controls">
                                <ul>
                                  <li>
                                    <a data-toggle="refresh" class="card-refresh" href="#"><i class="card-icon card-icon-refresh"></i></a>
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="row-xs-height ">
                          <div class="col-xs-height col-top relative">
                            <div class="row full-height">
                              <div class="col-sm-6">
                                <div class="p-l-20 full-height d-flex flex-column justify-content-between">
                                  <h3 class="no-margin p-b-5">₹14,000</h3>
                                  <p class="small m-t-5 m-b-20">
                                    <span class="label label-white hint-text font-montserrat m-r-5">60%</span><span class="fs-12">Higher</span>
                                  </p>
                                </div>
                              </div>
                              <div class="col-sm-6">
                              </div>
                            </div>
                            <div class='widget-8-chart line-chart' data-line-color="white" data-points="true" data-point-color="success" data-stroke-width="2">
                              <svg></svg>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
				  
				  <div class="col-sm-3 m-b-10">
                    <!-- START WIDGET widget_progressTileFlat-->
                    <div class="widget-8 card  bg-primary no-margin widget-loader-bar">
                      <div class="full-height d-flex flex-column">
                        <div class="card-header ">
                          <div class="card-title">
                            <span class="font-montserrat fs-11 all-caps">Weekly Sales </span>
                          </div>
                          <div class="card-controls">
                            <ul>
                              <li><a href="#" class="card-refresh" data-toggle="refresh"><i class="card-icon card-icon-refresh"></i></a>
                              </li>
                            </ul>
                          </div>
                        </div>
                        <div class="p-l-20">
                          <h3 class="no-margin p-b-5">₹23,000</h3>
                          <span class="d-flex align-items-center"> 
					<i class="pg-icon m-r-5">arrow_down</i>
					<span class="small hint-text">65% lower than last month</span>
                          </span>
                        </div>
                        <div class="mt-auto">
                          <div class="progress progress-small m-b-20">
                            <!-- START BOOTSTRAP PROGRESS (http://getbootstrap.com/components/#progress) -->
                            <div class="progress-bar progress-bar-white" style="width:45%"></div>
                            <!-- END BOOTSTRAP PROGRESS -->
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
				  
                </div>
              </div>
			
            
			  
			  
			  
			  
              <!-- Filler -->
              <div class="visible-xlg col-xlg-3">
                <div class="ar-2-3">
                  <!-- START WIDGET widget_tableWidget-->
                  <div class="widget-11 card   no-margin widget-loader-bar">
                    <div class="card-header">
                      <div class="card-title">Today's Table
                      </div>
                      <div class="card-controls">
                        <ul>
                          <li><a data-toggle="refresh" class="card-refresh" href="#"><i
							class="card-icon card-icon-refresh"></i></a>
                          </li>
                        </ul>
                      </div>
                    </div>
                    <div class="p-l-20 p-r-20 p-b-10 p-t-5">
                      <div class="pull-left">
                        <h3 class="text-primary no-margin">Pages</h3>
                      </div>
                      <h4 class="pull-right semi-bold no-margin"><sup>
				<small class="semi-bold">$</small>
			</sup> 102,967
			</h4>
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-11-table auto-overflow">
                      <table class="table table-condensed table-hover">
                        <tbody>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">janedrooler</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">dewdrops</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18">$27</span>
                            </td>
                          </tr>
                          <tr>
                            <td class=" fs-12">Purchase CODE #2345</td>
                            <td class="text-right">
                              <span class="hint-text small">johnsmith</span>
                            </td>
                            <td class="text-right b-r b-dashed b-grey">
                              <span class="hint-text small">Qty 1</span>
                            </td>
                            <td>
                              <span class="font-montserrat fs-18 text-primary">$1000</span>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <div class="p-t-15 p-b-15 p-l-20 p-r-20">
                      <p class="small no-margin">
                        <a href="#" class="btn-circle-arrow b-grey"><i class="pg-icon">chevron_down</i></a>
                        <span class="hint-text ">Show more details of <a href="#"> Revox pvt ltd </a></span>
                      </p>
                    </div>
                  </div>
                  <!-- END WIDGET -->
                </div>
              </div>
            </div>
            <!-- END ROW -->
            <div class="row">
              <div class="col-lg-4 col-xl-3 col-xlg-2 ">
                <div class="row">
                  <div class="col-md-12 m-b-10">
                    <!-- START WIDGET D3 widget_graphTileFlat-->
                    <div class="widget-8 card  bg-success no-margin widget-loader-bar">
                      <div class="container-xs-height full-height">
                        <div class="row-xs-height">
                          <div class="col-xs-height col-top">
                            <div class="card-header  top-left top-right">
                              <div class="card-title">
                                <span class="font-montserrat fs-11 all-caps">Weekly Sales </span>
                              </div>
                              <div class="card-controls">
                                <ul>
                                  <li>
                                    <a data-toggle="refresh" class="card-refresh" href="#"><i
											class="card-icon card-icon-refresh"></i></a>
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="row-xs-height ">
                          <div class="col-xs-height col-top relative">
                            <div class="row full-height">
                              <div class="col-sm-6">
                                <div class="p-l-20 full-height d-flex flex-column justify-content-between">
                                  <h3 class="no-margin p-b-5">$14,000</h3>
                                  <p class="small m-t-5 m-b-20">
                                    <span class="label label-white hint-text font-montserrat m-r-5">60%</span><span class="fs-12">Higher</span>
                                  </p>
                                </div>
                              </div>
                              <div class="col-sm-6">
                              </div>
                            </div>
                            <div class='widget-8-chart line-chart' data-line-color="white" data-points="true" data-point-color="success" data-stroke-width="2">
                              <svg></svg>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12 m-b-10">
                    <!-- START WIDGET widget_progressTileFlat-->
                    <div class="widget-9 card  bg-primary no-margin widget-loader-bar">
                      <div class="full-height d-flex flex-column">
                        <div class="card-header ">
                          <div class="card-title">
                            <span class="font-montserrat fs-11 all-caps">Weekly Sales </span>
                          </div>
                          <div class="card-controls">
                            <ul>
                              <li><a href="#" class="card-refresh" data-toggle="refresh"><i class="card-icon card-icon-refresh"></i></a>
                              </li>
                            </ul>
                          </div>
                        </div>
                        <div class="p-l-20">
                          <h3 class="no-margin p-b-5">$23,000</h3>
                          <span class="d-flex align-items-center"> 
					<i class="pg-icon m-r-5">arrow_down</i>
					<span class="small hint-text">65% lower than last month</span>
                          </span>
                        </div>
                        <div class="mt-auto">
                          <div class="progress progress-small m-b-20">
                            <!-- START BOOTSTRAP PROGRESS (http://getbootstrap.com/components/#progress) -->
                            <div class="progress-bar progress-bar-white" style="width:45%"></div>
                            <!-- END BOOTSTRAP PROGRESS -->
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12">
                    <!-- START WIDGET widget_statTile-->
                    <div class="widget-10 card  bg-white no-margin widget-loader-bar">
                      <div class="card-header  top-left top-right ">
                        <div class="card-title text-black hint-text">
                          <span class="font-montserrat fs-11 all-caps">Weekly Sales </span>
                        </div>
                        <div class="card-controls">
                          <ul>
                            <li><a data-toggle="refresh" class="card-refresh text-black" href="#"><i
							class="card-icon card-icon-refresh"></i></a>
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div class="card-body p-t-40">
                        <div class="row">
                          <div class="col-sm-12">
                            <h4 class="no-margin p-b-5 text-danger semi-bold">APPL 2.032</h4>
                            <div class="d-flex align-items-center pull-left small">
                              <span>WMHC</span>
                              <span class=" text-success"> <i class="pg-icon m-l-10">arrow_up</i> </span>
                              <span class="text-success font-montserrat"> 21% </span>
                            </div>
                            <div class="d-flex align-items-center pull-left m-l-20 small">
                              <span>HCRS</span>
                              <span class="text-danger"><i class="pg-icon m-l-10">arrow_down</i> </span>
                              <span class="text-danger font-montserrat"> 21% </span>
                            </div>
                            <div class="clearfix"></div>
                          </div>
                        </div>
                        <div class="p-t-5 full-width">
                          <a href="#" class="btn-circle-arrow b-grey"><i
						class="pg-icon">chevron_down</i></a>
                          <span class="hint-text small">Show more</span>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
                </div>
              </div>
              <div class="col-lg-8 col-xl-5 col-xlg-6 m-b-10">
                <div class="row">
                  <div class="col-md-12">
                    <!-- START WIDGET D3 widget_graphWidget-->
                    <div class="widget-12 card  widget-loader-circle no-margin">
                      <div class="row">
                        <div class="col-xlg-8 ">
                          <div class="card-header  pull-up top-right ">
                            <div class="card-controls">
                              <ul>
                                <li class="hidden-xlg">
                                  <div class="dropdown">
                                    <a data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
                                      <i class="card-icon card-icon-settings"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                      <li><a href="#">AAPL</a>
                                      </li>
                                      <li><a href="#">YHOO</a>
                                      </li>
                                      <li><a href="#">GOOG</a>
                                      </li>
                                    </ul>
                                  </div>
                                </li>
                                <li>
                                  <a data-toggle="refresh" class="card-refresh text-black" href="#"><i class="card-icon card-icon-refresh"></i></a>
                                </li>
                              </ul>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="card-body">
                        <div class="row">
                          <div class="col-xlg-8 col-lg-12">
                            <div class="p-l-5">
                              <h2 class="pull-left m-t-5 m-b-5">Apaar Infosystems</h2>
                              <h2 class="pull-right m-r-25 m-t-5 m-b-5 text-success">
							<i class="pg-icon m-r-5">arrow_up</i>
							<span class="">448.97</span>
							<span class="text-success fs-12">+318.24</span>
						</h2>
                              <div class="clearfix"></div>
                              <div class="full-width">
                                <ul class="list-inline m-t-10 p-b-10 m-b-0 b-b b-dashed b-grey">
                                  <li><a href="#" class="font-montserrat fs-12 text-color">1D</a>
                                  </li>
                                  <li class="active"><a href="#" class="font-montserrat fs-12   bg-contrast-low text-color">5D</a>
                                  </li>
                                  <li><a href="#" class="font-montserrat fs-12 text-color">1M</a>
                                  </li>
                                  <li><a href="#" class="font-montserrat fs-12 text-color">1Y</a>
                                  </li>
                                </ul>
                              </div>
                              <div class="nvd3-line line-chart text-center" data-x-grid="false">
                                <svg></svg>
                              </div>
                            </div>
                          </div>
                          <div class="col-xlg-4 visible-xlg p-l-15">
                            <div class="widget-12-search">
                              <p class="pull-left">Stocks list</p>
                              <button aria-label="" class="btn btn-default btn-rounded btn-icon pull-right">
                                <i class="pg-icon">add</i>
                              </button>
                              <div class="clearfix"></div>
                              <input type="text" placeholder="Search list" class="form-control m-t-5">
                            </div>
                            <div class="company-stat-boxes">
                              <div data-index="0" class="company-stat-box m-t-15 active p-l-5 p-r-5 p-t-10 p-b-10 b-b b-grey">
                                <div class="pull-left">
                                  <p class="company-name pull-left text-uppercase bold no-margin">
                                    <span class="text-success fs-11"></span> AAPL
                                  </p>
                                  <small class="hint-text m-l-10">Apple Inc.</small>
                                </div>
                                <div class="pull-right">
                                  <p class="small hint-text no-margin inline">325.73</p>
                                  <span class="label label-success m-l-5 inline">+ 12.09</span>
                                </div>
                                <div class="clearfix"></div>
                              </div>
                              <div data-index="1" class="company-stat-box active p-l-5 p-r-5 p-t-15 p-b-10 b-b b-grey">
                                <div class="pull-left">
                                  <p class="company-name pull-left text-uppercase bold no-margin">
                                    <span class="text-success fs-11"></span> GOOG
                                  </p>
                                  <small class="hint-text m-l-10">Alphabet Inc.</small>
                                </div>
                                <div class="pull-right">
                                  <p class="small hint-text no-margin inline">1407.73</p>
                                  <span class="label label-important m-l-5 inline">- 1.09</span>
                                </div>
                                <div class="clearfix"></div>
                              </div>
                              <div data-index="2" class="company-stat-box active p-l-5 p-r-5 p-t-15 p-b-10 b-b b-grey">
                                <div class="pull-left">
                                  <p class="company-name pull-left text-uppercase bold no-margin">
                                    <span class="text-success fs-11"></span> YHOO
                                  </p>
                                  <small class="hint-text m-l-10">Yahoo Inc.</small>
                                </div>
                                <div class="pull-right">
                                  <p class="small hint-text no-margin inline">37.73</p>
                                  <span class="label label-success m-l-5 inline">+ 0.09</span>
                                </div>
                                <div class="clearfix"></div>
                              </div>
                              <div data-index="3" class="company-stat-box active p-l-5 p-r-5 p-t-15 p-b-10 b-b b-grey">
                                <div class="pull-left">
                                  <p class="company-name pull-left text-uppercase bold no-margin">
                                    <span class="text-success fs-11"></span> NKE
                                  </p>
                                  <small class="hint-text m-l-10">Nike Inc.</small>
                                </div>
                                <div class="pull-right">
                                  <p class="small hint-text no-margin inline">100.02</p>
                                  <span class="label label-important m-l-5 inline">- 0.04</span>
                                </div>
                                <div class="clearfix"></div>
                              </div>
                              <div data-index="4" class="company-stat-box active p-l-5 p-r-5 p-t-15 p-b-10">
                                <div class="pull-left">
                                  <p class="company-name pull-left text-uppercase bold no-margin">
                                    <span class="text-success fs-11"></span> TSLA
                                  </p>
                                  <small class="hint-text m-l-10">Tesla Inc.</small>
                                </div>
                                <div class="pull-right">
                                  <p class="small hint-text no-margin inline">537.73</p>
                                  <span class="label label-success m-l-5 inline">+ 0.09</span>
                                </div>
                                <div class="clearfix"></div>
                              </div>
                            </div>
                            <span class="pull-bottom hint-text small">VIA YAHOO Finance (Stock market API)(800) MY-STOCKS (800-692-7753)</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
                </div>
              </div>
              <div class="col-lg-6 col-xl-4 m-b-10 hidden-xlg">
                <!-- START WIDGET widget_tableWidgetBasic-->
                <div class="widget-11-2 card  no-margin widget-loader-circle full-height d-flex flex-column">
                  <div class="card-header">
                    <div class="card-title">Today's Table
                    </div>
                    <div class="card-controls">
                      <ul>
                        <li><a data-toggle="refresh" class="card-refresh" href="#"><i
							class="card-icon card-icon-refresh"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="p-l-20 p-r-20 p-b-10 p-t-5">
                    <div class="pull-left">
                      <h3 class="text-primary no-margin">Pages</h3>
                    </div>
                    <h4 class="pull-right semi-bold no-margin"><sup>
				<small class="semi-bold">$</small>
			</sup> 102,967
			</h4>
                    <div class="clearfix"></div>
                  </div>
                  <div class="widget-11-table auto-overflow">
                    <table class="table table-condensed table-hover">
                      <tbody>
                        <tr>
                          <td class="fs-12 w-50">Purchase Pages Extended #2502</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$1000</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase Pages Support #2325</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$12</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase CODE #2345</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$27</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase CODE #2345</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$27</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase Pages Support #2325</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$12</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase Pages Extended #2502</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$1000</span>
                          </td>
                        </tr>
                        <tr>
                          <td class="fs-12 w-50">Purchase Pages Extended #2502</td>
                          <td class="text-right b-r b-dashed b-grey w-25">
                            <span class="hint-text small">Qty 1</span>
                          </td>
                          <td class="w-25">
                            <span class="font-montserrat fs-18">$1000</span>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="p-t-15 p-b-15 p-l-20 p-r-20 mt-auto">
                    <p class="small no-margin">
                      <a href="#" class="btn-circle-arrow b-grey"><i class="pg-icon">chevron_down</i></a>
                      <span class="hint-text ">Show more details of <a href="#"> Revox pvt ltd </a></span>
                    </p>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
              <div class="col-lg-6 visible-md visible-xlg col-xlg-4 m-b-10">
                <!-- START WIDGET D3 widget_stackedBarWidget-->
                <div class="widget-15 card no-margin  widget-loader-circle">
                  <div class="card-header top-right">
                    <div class="card-controls">
                      <ul>
                        <li><a href="#" class="card-refresh" data-toggle="refresh"><i
							class="card-icon card-icon-refresh"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="card-body no-padding">
                    <ul class="nav nav-tabs nav-tabs-simple p-t-5">
                      <li class="nav-item">
                        <a href="#" data-toggle="tab" class="active">
						APPL<br>
						22.23<br>
						<span class="text-success">+60.223%</span>
					</a>
                      </li>
                      <li class="nav-item"><a href="#" data-toggle="tab" class="">
					FB<br>
					45.97<br>
					<span class="text-danger">-06.56%</span>
				</a>
                      </li>
                      <li class="nav-item"><a href="#" data-toggle="tab" class="">
					GOOG<br>
					22.23<br>
					<span class="text-success">+60.223%</span>
				</a>
                      </li>
                    </ul>
                    <div class="tab-content p-l-10 p-r-10">
                      <div class="tab-pane no-padding active" id="widget-15-tab-1">
                        <div class="full-width">
                          <div class="full-width">
                            <div class="widget-15-chart rickshaw-chart"></div>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane no-padding" id="widget-15-tab-2">
                      </div>
                      <div class="tab-pane" id="widget-15-tab-3">
                      </div>
                    </div>
                    <div class="p-t-20 p-l-20 p-r-20 p-b-20">
                      <div class="row">
                        <div class="col-md-9">
                          <p class="fs-16">Apple’s Motivation - Innovation
                            <br>distinguishes between A leader and a follower.
                          </p>
                          <p class="small hint-text">VIA Apple Store (Consumer and Education Individuals)
                            <br>(800) MY-APPLE (800-692-7753)
                          </p>
                        </div>
                        <div class="col-md-3 text-right">
                          <p class="font-montserrat bold text-success m-r-20 fs-16 m-t-0">+0.94</p>
                          <p class="font-montserrat bold text-danger m-r-20 fs-16">-0.63</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
            </div>
            <div class="row">
              <div class="col-lg-8 m-b-10">
                <!-- START WIDGET widget_mapWidget-->
                <div class="widget-13 card   no-margin widget-loader-circle">
                  <div class="card-header  pull-up top-right ">
                    <div class="card-controls">
                      <ul>
                        <li><a href="#" class="card-refresh text-black" data-toggle="refresh"><i class="card-icon card-icon-refresh"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="container-sm-height no-overflow">
                    <div class="row row-sm-height">
                      <div class="col-sm-5 col-lg-4 col-xlg-3 col-sm-height col-top no-padding">
                        <div class="card-header  ">
                          <div class="card-title">Geolocation
                          </div>
                        </div>
                        <div class="card-body">
                          <ul class="nav nav-pills m-t-10 m-b-15" role="tablist">
                            <li class="active">
                              <a href="#tab1" data-toggle="tab" role="tab" class="b-a b-grey text-color">
                                            fb
                                        </a>
                            </li>
                            <li>
                              <a href="#tab2" data-toggle="tab" role="tab" class="b-a b-grey text-color">
                                            gl
                                        </a>
                            </li>
                            <li>
                              <a href="#tab3" data-toggle="tab" role="tab" class="b-a b-grey text-color">
                                            am
                                        </a>
                            </li>
                          </ul>
                          <div class="tab-content">
                            <div class="tab-pane active" id="tab1">
                              <h3 class="m-t-5 m-b-20">Facebook</h3>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Views</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">14,256</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Today</p>
                              <p class="all-caps font-montserrat  no-margin text-warning ">24</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Week</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">56</p>
                            </div>
                            <div class="tab-pane " id="tab2">
                              <h3 class="m-t-5 m-b-20">Google</h3>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Views</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">14,256</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Today</p>
                              <p class="all-caps font-montserrat  no-margin text-warning ">24</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Week</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">56</p>
                            </div>
                            <div class="tab-pane" id="tab3">
                              <h3 class="m-t-5 m-b-20">Amazon</h3>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Views</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">14,256</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Today</p>
                              <p class="all-caps font-montserrat  no-margin text-warning ">24</p>
                              <br>
                              <p class="hint-text all-caps font-montserrat small no-margin ">Week</p>
                              <p class="all-caps font-montserrat  no-margin text-success ">56</p>
                            </div>
                          </div>
                        </div>
                        <div class="p-l-20 p-r-20 p-t-10 p-b-10 pull-bottom full-width hidden-xs">
                          <p class="no-margin">
                            <a href="#" class="btn-circle-arrow b-grey"><i class="pg-icon">chevron_down</i></a>
                            <span class="hint-text">Super secret options</span>
                          </p>
                        </div>
                      </div>
                      <div class="col-sm-7 col-lg-8 col-xlg-9 col-sm-height col-top no-padding relative">
                        <div class="bg-success widget-13-map">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
              <div class="col-lg-4 m-b-10">
                <!-- START WIDGET widget_realtimeWidget-->
                <div class="widget-14 card   no-margin widget-loader-circle">
                  <div class="container-xs-height full-height">
                    <div class="row-xs-height">
                      <div class="col-xs-height">
                        <div class="card-header ">
                          <div class="card-title">Server load
                          </div>
                          <div class="card-controls">
                            <ul>
                              <li><a href="#" class="card-refresh text-black" data-toggle="refresh"><i
										class="card-icon card-icon-refresh"></i></a>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row-xs-height">
                      <div class="col-xs-height">
                        <div class="p-l-20 p-r-20">
                          <p>Server: www.revox.io</p>
                          <div class="row">
                            <div class="col-lg-3 col-md-12">
                              <h4 class="bold no-margin">5.2GB</h4>
                              <p class="small no-margin">Total usage</p>
                            </div>
                            <div class="col-lg-3 col-md-6">
                              <h5 class=" no-margin p-t-5">227.3KB</h5>
                              <p class="small no-margin">Currently</p>
                            </div>
                            <div class="col-lg-3 col-md-6">
                              <h5 class=" no-margin p-t-5">117.6MB</h5>
                              <p class="small no-margin">Average</p>
                            </div>
                            <div class="col-lg-3 visible-xlg">
                              <div class="widget-14-chart-legend bg-transparent text-black no-padding pull-right"></div>
                              <div class="clearfix"></div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row-xs-height">
                      <div class="col-xs-height relative bg-contrast-lowest">
                        <div class="widget-14-chart_y_axis"></div>
                        <div class="widget-14-chart rickshaw-chart top-left top-right bottom-left bottom-right"></div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
            </div>
            <div class="row">
              <div class="col-lg-4 visible-lg hidden-xlg sm-p-b-10 md-m-b-10">
                <!-- START WIDGET D3 widget_stackedBarWidgetBasic-->
                <div class="widget-15-2 card no-margin  widget-loader-circle">
                  <div class="card-header  top-right">
                    <div class="card-controls">
                      <ul>
                        <li><a href="#" class="card-refresh" data-toggle="refresh"><i
							class="card-icon card-icon-refresh"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <ul class="nav nav-tabs nav-tabs-simple">
                    <li>
                      <a href="#widget-15-2-tab-1" class="active">
					APPL<br>
					22.23<br>
					<span class="text-success">+60.223%</span>
				</a>
                    </li>
                    <li><a href="#widget-15-2-tab-2">
				FB<br>
				45.97<br>
				<span class="text-danger">-06.56%</span>
			</a>
                    </li>
                    <li><a href="#widget-15-2-tab-3">
				GOOG<br>
				22.23<br>
				<span class="text-success">+60.223%</span>
			</a>
                    </li>
                  </ul>
                  <div class="tab-content p-l-10 p-r-10">
                    <div class="tab-pane no-padding active" id="widget-15-2-tab-1">
                      <div class="full-width">
                        <div class="widget-15-chart2 rickshaw-chart full-height"></div>
                      </div>
                    </div>
                    <div class="tab-pane no-padding" id="widget-15-2-tab-2">
                    </div>
                    <div class="tab-pane" id="widget-15-2-tab-3">
                    </div>
                  </div>
                  <div class="p-t-10 p-l-20 p-r-20 p-b-20">
                    <div class="row">
                      <div class="col-md-9">
                        <p class="fs-16">Apple’s Motivation - Innovation distinguishes between A leader and a follower.
                        </p>
                        <p class="small hint-text">VIA Apple Store (Consumer and Education Individuals)
                          <br>(800) MY-APPLE (800-692-7753)
                        </p>
                      </div>
                      <div class="col-md-3 text-right">
                        <h5 class="font-montserrat bold text-success m-t-0">+0.94</h5>
                        <h5 class="font-montserrat bold text-danger">-0.63</h5>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
              <div class="col-md-4 col-lg-3 col-xlg-3 m-b-10">
                <!-- START WIDGET D3 widget_graphOptionsWidget-->
                <div class="widget-16 card   no-margin widget-loader-circle">
                  <div class="card-header ">
                    <div class="card-title">Page Options
                    </div>
                    <div class="card-controls">
                      <ul>
                        <li><a href="#" class="card-refresh text-black" data-toggle="refresh"><i
							class="card-icon card-icon-refresh"></i></a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="widget-16-header p-r-20 p-l-20 p-t-10 d-flex">
                    <span class="icon-thumbnail bg-contrast-low pull-left text-color pg-icon">ws</span>
                    <div class="flex-1 full-width overflow-ellipsis">
                      <p class="hint-text all-caps font-montserrat  small no-margin overflow-ellipsis ">Pages name
                      </p>
                      <h6 class="no-margin overflow-ellipsis ">Webarch Sales Analysis</h6>
                    </div>
                  </div>
                  <div class="p-l-20 p-r-45 p-t-25 p-b-25">
                    <ul class="list-inline no-margin">
                      <li class="p-r-25">
                        <p class="hint-text all-caps font-montserrat small no-margin ">Views</p>
                        <p class="all-caps font-montserrat  no-margin text-success ">14,256</p>
                      </li>
                      <li class="p-r-25">
                        <p class="hint-text all-caps font-montserrat small no-margin ">Today</p>
                        <p class="all-caps font-montserrat  no-margin text-warning ">24</p>
                      </li>
                      <li class="p-r-25">
                        <p class="hint-text all-caps font-montserrat small no-margin ">Week</p>
                        <p class="all-caps font-montserrat  no-margin text-success ">56</p>
                      </li>
                    </ul>
                  </div>
                  <div class="relative no-overflow">
                    <div class="widget-16-chart line-chart" data-line-color="success" data-points="true" data-point-color="white" data-stroke-width="2">
                      <svg></svg>
                    </div>
                  </div>
                  <div class="b-b b-t b-grey p-l-20 p-r-20 p-b-15 p-t-15">
                    <div class="form-check switch switch-lg success full-width right d-flex m-b-0">
                      <input type="checkbox" id="pagesSwitch1">
                      <label for="pagesSwitch1" class="full-width">Post is Public</label>
                    </div>
                  </div>
                  <div class="b-b b-grey p-l-20 p-r-20 p-b-15 p-t-15">
                    <div class="form-check switch switch-lg success full-width right d-flex m-b-0">
                      <input type="checkbox" id="pagesSwitch2" checked>
                      <label for="pagesSwitch2" class="full-width">Maintenance mode</label>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                  <div class="p-l-20 p-r-20 p-t-10 p-b-10 ">
                    <p class="pull-left no-margin hint-text">Super secret options</p>
                    <a href="#" class="btn-circle-arrow b-grey pull-right"><i class="pg-icon">chevron_down</i></a>
                    <div class="clearfix"></div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
              <div class="col-xlg-2 visible-xlg ">
                <!-- START WIDGET widget_socialImageTile-->
                <div class="widget-18 card   no-margin ">
                  <div class="padding-15">
                    <div class="item-header clearfix">
                      <div class="thumbnail-wrapper d32 circular">
                        <img width="40" height="40" src="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" data-src-retina="assets/img/profiles/3x.jpg" alt="">
                      </div>
                      <div class="inline m-l-10">
                        <p class="no-margin">
                          <strong>Anne Simons</strong>
                        </p>
                        <p class="no-margin hint-text fs-12 d-flex">Shared a link
                          <span class="location semi-bold d-flex"><i class="pg-icon">map</i> NY center</span>
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="relative">
                    <ul class="buttons pull-top top-right list-inline p-r-10 p-t-10">
                      <li>
                        <a class="text-white" href="#"><i class="pg-icon">expand</i></i>
					</a>
                      </li>
                      <li>
                        <a class="text-white" href="#"><i class="pg-icon">heart_outline</i></i>
					</a>
                      </li>
                    </ul>
                    <div class="widget-18-post bg-black no-overflow">
                    </div>
                  </div>
                  <div class="padding-15">
                    <div class="hint-text pull-left fs-13">few seconds ago</div>
                    <ul class="list-inline pull-right no-margin">
                      <li><a class="text-color hint-text fs-13 d-flex" href="#"><i class="pg-icon m-r-5">comment_alt</i> 5,345</a>
                      </li>
                      <li><a class="text-color hint-text fs-13 d-flex" href="#"><i class="pg-icon m-r-5">heart</i> 23K</a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
              <div class="col-xlg-2 visible-xlg ">
                <div class="row">
                  <div class="col-xlg-12">
                    <!-- START WIDGET widget_socialPostTile-->
                    <div class="card   no-margin">
                      <div class="padding-15">
                        <div class="item-header clearfix">
                          <div class="thumbnail-wrapper d32 circular">
                            <img width="40" height="40" src="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" data-src-retina="assets/img/profiles/3x.jpg" alt="">
                          </div>
                          <div class="inline m-l-10">
                            <p class="no-margin">
                              <strong>Anne Simons</strong>
                            </p>
                            <p class="no-margin hint-text fs-12 d-flex">Shared a link
                              <span class="location semi-bold d-flex"><i class="pg-icon">map</i> NY center</span>
                            </p>
                          </div>
                        </div>
                      </div>
                      <hr class="no-margin">
                      <div class="padding-15">
                        <p>Crafting Digital Products that merge Humans and Machines. Join the revolution.</p>
                        <div class="hint-text fs-12">via themeforest</div>
                      </div>
                      <div class="relative">
                        <ul class="buttons pull-top top-right list-inline p-r-10 p-t-10">
                          <li>
                            <a class="text-white" href="#"><i class="pg-icon">expand</i>
					</a>
                          </li>
                          <li>
                            <a class="text-white" href="#"><i class="pg-icon">comment</i>
					</a>
                          </li>
                        </ul>
                        <div class="widget-19-post no-overflow">
                          <img src="assets/img/social-post-image.png" class="block center-margin relative" alt="Post">
                        </div>
                      </div>
                      <div class="padding-15">
                        <div class="hint-text pull-left fs-13">few seconds ago</div>
                        <ul class="list-inline pull-right no-margin">
                          <li><a class="text-color hint-text fs-13 d-flex" href="#"><i class="pg-icon m-r-5">comment_alt</i> 5,345</a>
                          </li>
                          <li><a class="text-color hint-text fs-13 d-flex" href="#"><i class="pg-icon m-r-5">heart</i> 23K</a>
                          </li>
                        </ul>
                        <div class="clearfix"></div>
                      </div>
                    </div>
                    <!-- END WIDGET -->
                  </div>
                </div>
              </div>
              <div class="col-md-8 col-lg-5 col-xlg-5">
                <!-- START WIDGET widget_weatherWidget-->
                <div class="widget-17 card  no-border no-margin widget-loader-circle">
                  <div class="card-header ">
                    <div class="card-title">
                      <i class="pg-icon">map</i> Mumbai, India
                      <span class="caret"></span>
                    </div>
                    <div class="card-controls">
                      <ul>
                        <li class="">
                          <div class="dropdown">
                            <a data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
                              <i class="card-icon card-icon-settings"></i>
                            </a>
                            <ul class="dropdown-menu pull-right" role="menu">
                              <li><a href="#">AAPL</a>
                              </li>
                              <li><a href="#">YHOO</a>
                              </li>
                              <li><a href="#">GOOG</a>
                              </li>
                            </ul>
                          </div>
                        </li>
                        <li>
                          <a data-toggle="refresh" class="card-refresh text-black" href="#">
                            <i class="card-icon card-icon-refresh"></i>
                          </a>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="card-body">
                    <div class="p-l-5">
                      <div class="row">
                        <div class="col-lg-12 col-xlg-6">
                          <div class="row m-t-10">
                            <div class="col-lg-5">
                              <h4 class="no-margin">Monday</h4>
                              <p class="small hint-text">19th September 2022</p>
                            </div>
                            <div class="col-lg-7">
                              <div class="d-flex pull-right">
                                <canvas height="46" width="46" class="clear-day hint-text"></canvas>
                                <h2 class="text-danger bold no-margin p-l-10">32°
                	</h2>
                              </div>
                            </div>
                          </div>
                          <div class="m-t-25 p-b-10">
                            <p class="pull-left no-margin hint-text">Weather information</p>
                            <a href="#" class="btn-icon-link d-flex pull-right"><i class="pg-icon">more_horizontal</i></a>
                            <div class="clearfix"></div>
                          </div>
                          <div class="widget-17-weather b-t b-grey p-t-20">
                            <div class="weather-info row">
                              <div class="col-6 p-r-15">
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Wind</p>
                                    <p class="pull-right no-margin fs-13">11km/h</p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Sunrise</p>
                                    <p class="pull-right no-margin fs-13">05:20</p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Humidity</p>
                                    <p class="pull-right no-margin fs-13">20%</p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Precipitation</p>
                                    <p class="pull-right no-margin fs-13">60%</p>
                                  </div>
                                </div>
                              </div>
                              <div class="col-6 p-l-15">
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Sunset</p>
                                    <p class="pull-right no-margin fs-13">21:05</p>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-lg-12">
                                    <p class="pull-left no-margin hint-text fs-13">Visibility</p>
                                    <p class="pull-right no-margin fs-13">21km</p>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <div class="row m-t-20 timeslot">
                            <div class="col-2 p-t-10 text-center b-r b-dashed b-grey">
                              <p class="small">13:30</p>
                              <canvas height="25" width="25" class="partly-cloudy-day"></canvas>
                              <p class="text-danger bold">30°C</p>
                            </div>
                            <div class="col-2 p-t-10 text-center b-r b-dashed b-grey">
                              <p class="small">14:00</p>
                              <canvas height="25" width="25" class="cloudy"></canvas>
                              <p class="text-danger bold">30°C</p>
                            </div>
                            <div class="col-2 p-t-10 text-center b-r b-dashed b-grey">
                              <p class="small">14:30</p>
                              <canvas height="25" width="25" class="rain"></canvas>
                              <p class="text-danger bold">30°C</p>
                            </div>
                            <div class="col-2 p-t-10 text-center b-r b-dashed b-grey">
                              <p class="small">15:00</p>
                              <canvas height="25" width="25" class="sleet"></canvas>
                              <p class="text-success bold">27°C</p>
                            </div>
                            <div class="col-2 p-t-10 text-center b-r b-dashed b-grey">
                              <p class="small">15:30</p>
                              <canvas height="25" width="25" class="snow"></canvas>
                              <p class="text-success bold">16°C</p>
                            </div>
                            <div class="col-2 p-t-10 text-center">
                              <p class="small">16:00</p>
                              <canvas height="25" width="25" class="wind"></canvas>
                              <p class="text-success bold">21°C</p>
                            </div>
                          </div>
                        </div>
                        <div class="col-xlg-6 visible-xlg p-l-20">
                          <div class="row">
                            <div class="forecast-day col-lg-6 text-center m-t-10 ">
                              <div class="bg-contrast-lowest p-b-10 p-t-10">
                                <h5 class="p-t-10 no-margin">Tuesday</h5>
                                <p class="small hint-text m-b-20">11th Augest 2020</p>
                                <canvas class="rain" width="64" height="64"></canvas>
                                <h5 class="text-success">29°</h5>
                                <p>Feels like rainy </p>
                                <p class="small hint-text ">Wind
                                  <span class="f-13 p-l-20">11km/h</span>
                                </p>
                                <div class="m-t-20 block">
                                  <div class="padding-10">
                                    <div class="row">
                                      <div class="col-lg-6 text-center">
                                        <p class="hint-text small">Noon</p>
                                        <canvas class="sleet" width="25" height="25"></canvas>
                                        <p class="text-danger bold">30°C</p>
                                      </div>
                                      <div class="col-lg-6 text-center">
                                        <p class="hint-text small">Night</p>
                                        <canvas class="wind" width="25" height="25"></canvas>
                                        <p class="text-danger bold">30°C</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div class="col-lg-6 text-center m-t-10 m-t-10 b-l b-grey b-dashed">
                              <div class="bg-contrast-lowest p-b-10 p-t-10">
                                <h5 class="p-t-10 no-margin">Wednesday</h5>
                                <p class="small hint-text m-b-20">11th Augest 2020</p>
                                <canvas class="partly-cloudy-day" width="64" height="64"></canvas>
                                <h5 class="text-danger">32°</h5>
                                <p>Feels like cloudy </p>
                                <p class="hint-text small">Wind
                                  <span class="f-13 p-l-20">11km/h</span>
                                </p>
                                <div class="m-t-20 block">
                                  <div class="padding-10">
                                    <div class="row">
                                      <div class="col-lg-6 text-center">
                                        <p class="hint-text small">Noon</p>
                                        <canvas class="partly-cloudy-day" width="25" height="25"></canvas>
                                        <p class="text-danger bold">30°C</p>
                                      </div>
                                      <div class="col-lg-6 text-center">
                                        <p class="hint-text small">Night</p>
                                        <canvas class="wind" width="25" height="25"></canvas>
                                        <p class="text-danger bold">30°C</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END WIDGET -->
              </div>
            </div>
          </div>
          <!-- END CONTAINER FLUID -->
        </div>
        <!-- END PAGE CONTENT -->
        <!-- START COPYRIGHT -->
        <!-- START CONTAINER FLUID -->
        <!-- START CONTAINER FLUID -->
        <div class=" container-fluid  container-fixed-lg footer">
          <div class="copyright sm-text-center">
            <p class="small-text no-margin pull-left sm-pull-reset">
              ©2014-2020 All Rights Reserved. Pages® and/or its subsidiaries or affiliates are registered trademark of Revox Ltd.
              <span class="hint-text m-l-15">Pages v05.23 20201105.r.190</span>
            </p>
            <p class="small no-margin pull-right sm-pull-reset">
              Hand-crafted <span class="hint-text">&amp; made with Love</span>
            </p>
            <div class="clearfix"></div>
          </div>
        </div>
        <!-- END COPYRIGHT -->
      </div>
      <!-- END PAGE CONTENT WRAPPER -->
    </div>
    <!-- END PAGE CONTAINER -->
    <!--START QUICKVIEW -->
    <div id="quickview" class="quickview-wrapper" data-pages="quickview">
      <!-- Nav tabs -->
      <ul class="nav nav-tabs" role="tablist">
        <li class="">
          <a href="#quickview-notes" data-target="#quickview-notes" data-toggle="tab" role="tab">Notes</a>
        </li>
        <li>
          <a href="#quickview-alerts" data-target="#quickview-alerts" data-toggle="tab" role="tab">Alerts</a>
        </li>
        <li class="">
          <a class="active" href="#quickview-chat" data-toggle="tab" role="tab">Chat</a>
        </li>
      </ul>
      <a class="btn-icon-link invert quickview-toggle" data-toggle-element="#quickview" data-toggle="quickview"><i class="pg-icon">close</i></a>
      <!-- Tab panes -->
      <div class="tab-content">
        <!-- BEGIN Notes !-->
        <div class="tab-pane no-padding" id="quickview-notes">
          <div class="view-port clearfix quickview-notes" id="note-views">
            <!-- BEGIN Note List !-->
            <div class="view list" id="quick-note-list">
              <div class="toolbar clearfix">
                <ul class="pull-right ">
                  <li>
                    <a href="#" class="delete-note-link"><i class="pg-icon">trash_alt</i></a>
                  </li>
                  <li>
                    <a href="#" class="new-note-link" data-navigate="view" data-view-port="#note-views" data-view-animation="push"><i class="pg-icon">add</i></a>
                  </li>
                </ul>
                <button aria-label="" class="btn-remove-notes btn btn-xs btn-block hide"><i class="pg-icon">close</i>Delete</button>
              </div>
              <ul>
                <!-- BEGIN Note Item !-->
                <li data-noteid="1" class="d-flex justify-space-between">
                  <div class="left">
                    <!-- BEGIN Note Action !-->
                    <div class="form-check warning no-margin">
                      <input id="qncheckbox1" type="checkbox" value="1">
                      <label for="qncheckbox1"></label>
                    </div>
                    <!-- END Note Action !-->
                    <!-- BEGIN Note Preview Text !-->
                    <p class="note-preview">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                    <!-- BEGIN Note Preview Text !-->
                  </div>
                  <!-- BEGIN Note Details !-->
                  <div class="d-flex right justify-content-end">
                    <!-- BEGIN Note Date !-->
                    <span class="date">12/12/20</span>
                    <a href="#" class="d-flex align-items-center" data-navigate="view" data-view-port="#note-views" data-view-animation="push">
                      <i class="pg-icon">chevron_right</i>
                    </a>
                    <!-- END Note Date !-->
                  </div>
                  <!-- END Note Details !-->
                </li>
                <!-- END Note List !-->
                <!-- BEGIN Note Item !-->
                <li data-noteid="2" class="d-flex justify-space-between">
                  <div class="left">
                    <!-- BEGIN Note Action !-->
                    <div class="form-check warning no-margin">
                      <input id="qncheckbox2" type="checkbox" value="1">
                      <label for="qncheckbox2"></label>
                    </div>
                    <!-- END Note Action !-->
                    <!-- BEGIN Note Preview Text !-->
                    <p class="note-preview">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                    <!-- BEGIN Note Preview Text !-->
                  </div>
                  <!-- BEGIN Note Details !-->
                  <div class="d-flex right justify-content-end">
                    <!-- BEGIN Note Date !-->
                    <span class="date">12/12/20</span>
                    <a href="#" class="d-flex align-items-center" data-navigate="view" data-view-port="#note-views" data-view-animation="push"><i class="pg-icon">chevron_right</i></a>
                    <!-- END Note Date !-->
                  </div>
                  <!-- END Note Details !-->
                </li>
                <!-- END Note List !-->
                <!-- BEGIN Note Item !-->
                <li data-noteid="2" class="d-flex justify-space-between">
                  <div class="left">
                    <!-- BEGIN Note Action !-->
                    <div class="form-check warning no-margin">
                      <input id="qncheckbox3" type="checkbox" value="1">
                      <label for="qncheckbox3"></label>
                    </div>
                    <!-- END Note Action !-->
                    <!-- BEGIN Note Preview Text !-->
                    <p class="note-preview">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                    <!-- BEGIN Note Preview Text !-->
                  </div>
                  <!-- BEGIN Note Details !-->
                  <div class="d-flex right justify-content-end">
                    <!-- BEGIN Note Date !-->
                    <span class="date">12/12/20</span>
                    <a href="#" class="d-flex align-items-center" data-navigate="view" data-view-port="#note-views" data-view-animation="push"><i class="pg-icon">chevron_right</i></a>
                    <!-- END Note Date !-->
                  </div>
                  <!-- END Note Details !-->
                </li>
                <!-- END Note List !-->
                <!-- BEGIN Note Item !-->
                <li data-noteid="3" class="d-flex justify-space-between">
                  <div class="left">
                    <!-- BEGIN Note Action !-->
                    <div class="form-check warning no-margin">
                      <input id="qncheckbox4" type="checkbox" value="1">
                      <label for="qncheckbox4"></label>
                    </div>
                    <!-- END Note Action !-->
                    <!-- BEGIN Note Preview Text !-->
                    <p class="note-preview">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                    <!-- BEGIN Note Preview Text !-->
                  </div>
                  <!-- BEGIN Note Details !-->
                  <div class="d-flex right justify-content-end">
                    <!-- BEGIN Note Date !-->
                    <span class="date">12/12/20</span>
                    <a href="#" class="d-flex align-items-center" data-navigate="view" data-view-port="#note-views" data-view-animation="push"><i class="pg-icon">chevron_right</i></a>
                    <!-- END Note Date !-->
                  </div>
                  <!-- END Note Details !-->
                </li>
                <!-- END Note List !-->
                <!-- BEGIN Note Item !-->
                <li data-noteid="4" class="d-flex justify-space-between">
                  <div class="left">
                    <!-- BEGIN Note Action !-->
                    <div class="form-check warning no-margin">
                      <input id="qncheckbox5" type="checkbox" value="1">
                      <label for="qncheckbox5"></label>
                    </div>
                    <!-- END Note Action !-->
                    <!-- BEGIN Note Preview Text !-->
                    <p class="note-preview">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                    <!-- BEGIN Note Preview Text !-->
                  </div>
                  <!-- BEGIN Note Details !-->
                  <div class="d-flex right justify-content-end">
                    <!-- BEGIN Note Date !-->
                    <span class="date">12/12/20</span>
                    <a href="#" class="d-flex align-items-center" data-navigate="view" data-view-port="#note-views" data-view-animation="push"><i class="pg-icon">chevron_right</i></a>
                    <!-- END Note Date !-->
                  </div>
                  <!-- END Note Details !-->
                </li>
                <!-- END Note List !-->
              </ul>
            </div>
            <!-- END Note List !-->
            <div class="view note" id="quick-note">
              <div>
                <ul class="toolbar">
                  <li><a href="#" class="close-note-link"><i class="pg-icon">chevron_left</i></a>
                  </li>
                  <li><a href="#" data-action="Bold" class="fs-12"><i class="pg-icon">format_bold</i></a>
                  </li>
                  <li><a href="#" data-action="Italic" class="fs-12"><i class="pg-icon">format_italics</i></a>
                  </li>
                  <li><a href="#" class="fs-12"><i class="pg-icon">link</i></a>
                  </li>
                </ul>
                <div class="body">
                  <div>
                    <div class="top">
                      <span>21st april 2020 2:13am</span>
                    </div>
                    <div class="content">
                      <div class="quick-note-editor full-width full-height js-input" contenteditable="true"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- END Notes !-->
        <!-- BEGIN Alerts !-->
        <div class="tab-pane no-padding" id="quickview-alerts">
          <div class="view-port clearfix" id="alerts">
            <!-- BEGIN Alerts View !-->
            <div class="view bg-white">
              <!-- BEGIN View Header !-->
              <div class="navbar navbar-default navbar-sm">
                <div class="navbar-inner">
                  <!-- BEGIN Header Controler !-->
                  <a href="javascript:;" class="action p-l-10 link text-color" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                    <i class="pg-icon">more_horizontal</i>
                  </a>
                  <!-- END Header Controler !-->
                  <div class="view-heading">
                    Notications
                  </div>
                  <!-- BEGIN Header Controler !-->
                  <a href="#" class="action p-r-10 pull-right link text-color">
                    <i class="pg-icon">search</i>
                  </a>
                  <!-- END Header Controler !-->
                </div>
              </div>
              <!-- END View Header !-->
              <!-- BEGIN Alert List !-->
              <div data-init-list-view="ioslist" class="list-view boreded no-top-border">
                <!-- BEGIN List Group !-->
                <div class="list-view-group-container">
                  <!-- BEGIN List Group Header!-->
                  <div class="list-view-group-header text-uppercase">
                    Calendar
                  </div>
                  <!-- END List Group Header!-->
                  <ul>
                    <!-- BEGIN List Group Item!-->
                    <li class="alert-list">
                      <!-- BEGIN Alert Item Set Animation using data-view-animation !-->
                      <a href="javascript:;" class="align-items-center" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                        <p class="">
                          <span class="text-warning fs-10"><i class="pg-icon">circle_fill</i></span>
                        </p>
                        <p class="p-l-10 overflow-ellipsis fs-12">
                          <span class="text-color">David Nester Birthday</span>
                        </p>
                        <p class="p-r-10 ml-auto fs-12 text-right">
                          <span class="text-warning">Today <br></span>
                          <span class="text-color">All Day</span>
                        </p>
                      </a>
                      <!-- END Alert Item!-->
                      <!-- BEGIN List Group Item!-->
                    </li>
                    <!-- END List Group Item!-->
                    <!-- BEGIN List Group Item!-->
                    <li class="alert-list">
                      <!-- BEGIN Alert Item Set Animation using data-view-animation !-->
                      <a href="#" class="align-items-center" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                        <p class="">
                          <span class="text-warning fs-10"><i class="pg-icon">circle_fill</i></span>
                        </p>
                        <p class="p-l-10 overflow-ellipsis fs-12">
                          <span class="text-color">Meeting at 2:30</span>
                        </p>
                        <p class="p-r-10 ml-auto fs-12 text-right">
                          <span class="text-warning">Today</span>
                        </p>
                      </a>
                      <!-- END Alert Item!-->
                    </li>
                    <!-- END List Group Item!-->
                  </ul>
                </div>
                <!-- END List Group !-->
                <div class="list-view-group-container">
                  <!-- BEGIN List Group Header!-->
                  <div class="list-view-group-header text-uppercase">
                    Social
                  </div>
                  <!-- END List Group Header!-->
                  <ul>
                    <!-- BEGIN List Group Item!-->
                    <li class="alert-list">
                      <!-- BEGIN Alert Item Set Animation using data-view-animation !-->
                      <a href="javascript:;" class="p-t-10 p-b-10 align-items-center" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                        <p class="">
                          <span class="text-complete fs-10"><i class="pg-icon">circle_fill</i></span>
                        </p>
                        <p class="col overflow-ellipsis fs-12 p-l-10">
                          <span class="text-color link">Jame Smith commented on your status<br></span>
                          <span class="text-color">“Perfection Simplified - Company Revox"</span>
                        </p>
                      </a>
                      <!-- END Alert Item!-->
                    </li>
                    <!-- END List Group Item!-->
                    <!-- BEGIN List Group Item!-->
                    <li class="alert-list">
                      <!-- BEGIN Alert Item Set Animation using data-view-animation !-->
                      <a href="javascript:;" class="p-t-10 p-b-10 align-items-center" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                        <p class="">
                          <span class="text-complete fs-10"><i class="pg-icon">circle_fill</i></span>
                        </p>
                        <p class="col overflow-ellipsis fs-12 p-l-10">
                          <span class="text-color link">Jame Smith commented on your status<br></span>
                          <span class="text-color">“Perfection Simplified - Company Revox"</span>
                        </p>
                      </a>
                      <!-- END Alert Item!-->
                    </li>
                    <!-- END List Group Item!-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <!-- BEGIN List Group Header!-->
                  <div class="list-view-group-header text-uppercase">
                    Sever Status
                  </div>
                  <!-- END List Group Header!-->
                  <ul>
                    <!-- BEGIN List Group Item!-->
                    <li class="alert-list">
                      <!-- BEGIN Alert Item Set Animation using data-view-animation !-->
                      <a href="#" class="p-t-10 p-b-10 align-items-center" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                        <p class="">
                          <span class="text-danger fs-10"><i class="pg-icon">circle_fill</i></span>
                        </p>
                        <p class="col overflow-ellipsis fs-12 p-l-10">
                          <span class="text-color link">12:13AM GTM, 10230, ID:WR174s<br></span>
                          <span class="text-color">Server Load Exceeted. Take action</span>
                        </p>
                      </a>
                      <!-- END Alert Item!-->
                    </li>
                    <!-- END List Group Item!-->
                  </ul>
                </div>
              </div>
              <!-- END Alert List !-->
            </div>
            <!-- EEND Alerts View !-->
          </div>
        </div>
        <!-- END Alerts !-->
        <div class="tab-pane active no-padding" id="quickview-chat">
          <div class="view-port clearfix" id="chat">
            <div class="view bg-white">
              <!-- BEGIN View Header !-->
              <div class="navbar navbar-default">
                <div class="navbar-inner">
                  <!-- BEGIN Header Controler !-->
                  <a href="javascript:;" class="action p-l-10 link text-color" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                    <i class="pg-icon">add</i>
                  </a>
                  <!-- END Header Controler !-->
                  <div class="view-heading">
                    Chat List
                    <div class="fs-11">Show All</div>
                  </div>
                  <!-- BEGIN Header Controler !-->
                  <a href="#" class="action p-r-10 pull-right link text-color">
                    <i class="pg-icon">more_horizontal</i>
                  </a>
                  <!-- END Header Controler !-->
                </div>
              </div>
              <!-- END View Header !-->
              <div data-init-list-view="ioslist" class="list-view boreded no-top-border">
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">
                    a</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" src="assets/img/profiles/1x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">ava flores</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">b</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/2x.jpg" data-src="assets/img/profiles/2.jpg" src="assets/img/profiles/2x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">bella mccoy</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" src="assets/img/profiles/3x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">bob stephens</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">c</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/4x.jpg" data-src="assets/img/profiles/4.jpg" src="assets/img/profiles/4x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">carole roberts</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/5x.jpg" data-src="assets/img/profiles/5.jpg" src="assets/img/profiles/5x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">christopher perez</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">d</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/6x.jpg" data-src="assets/img/profiles/6.jpg" src="assets/img/profiles/6x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">danielle fletcher</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/7x.jpg" data-src="assets/img/profiles/7.jpg" src="assets/img/profiles/7x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">david sutton</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">e</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/8x.jpg" data-src="assets/img/profiles/8.jpg" src="assets/img/profiles/8x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">earl hamilton</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/9x.jpg" data-src="assets/img/profiles/9.jpg" src="assets/img/profiles/9x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">elaine lawrence</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" src="assets/img/profiles/1x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">ellen grant</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/2x.jpg" data-src="assets/img/profiles/2.jpg" src="assets/img/profiles/2x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">erik taylor</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" src="assets/img/profiles/3x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">everett wagner</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">f</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/4x.jpg" data-src="assets/img/profiles/4.jpg" src="assets/img/profiles/4x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">freddie gomez</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">g</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/5x.jpg" data-src="assets/img/profiles/5.jpg" src="assets/img/profiles/5x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">glen jensen</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/6x.jpg" data-src="assets/img/profiles/6.jpg" src="assets/img/profiles/6x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">gwendolyn walker</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">j</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/7x.jpg" data-src="assets/img/profiles/7.jpg" src="assets/img/profiles/7x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">janet romero</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">k</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/8x.jpg" data-src="assets/img/profiles/8.jpg" src="assets/img/profiles/8x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">kim martinez</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">l</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/9x.jpg" data-src="assets/img/profiles/9.jpg" src="assets/img/profiles/9x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">lawrence white</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" src="assets/img/profiles/1x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">leroy bell</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/2x.jpg" data-src="assets/img/profiles/2.jpg" src="assets/img/profiles/2x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">letitia carr</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" src="assets/img/profiles/3x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">lucy castro</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">m</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/4x.jpg" data-src="assets/img/profiles/4.jpg" src="assets/img/profiles/4x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">mae hayes</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/5x.jpg" data-src="assets/img/profiles/5.jpg" src="assets/img/profiles/5x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">marilyn owens</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/6x.jpg" data-src="assets/img/profiles/6.jpg" src="assets/img/profiles/6x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">marlene cole</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/7x.jpg" data-src="assets/img/profiles/7.jpg" src="assets/img/profiles/7x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">marsha warren</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/8x.jpg" data-src="assets/img/profiles/8.jpg" src="assets/img/profiles/8x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">marsha dean</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/9x.jpg" data-src="assets/img/profiles/9.jpg" src="assets/img/profiles/9x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">mia diaz</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">n</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" src="assets/img/profiles/1x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">noah elliott</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">p</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/2x.jpg" data-src="assets/img/profiles/2.jpg" src="assets/img/profiles/2x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">phyllis hamilton</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">r</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" src="assets/img/profiles/3x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">raul rodriquez</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/4x.jpg" data-src="assets/img/profiles/4.jpg" src="assets/img/profiles/4x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">rhonda barnett</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/5x.jpg" data-src="assets/img/profiles/5.jpg" src="assets/img/profiles/5x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">roberta king</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">s</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/6x.jpg" data-src="assets/img/profiles/6.jpg" src="assets/img/profiles/6x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">scott armstrong</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/7x.jpg" data-src="assets/img/profiles/7.jpg" src="assets/img/profiles/7x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">sebastian austin</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/8x.jpg" data-src="assets/img/profiles/8.jpg" src="assets/img/profiles/8x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">sofia davis</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">t</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/9x.jpg" data-src="assets/img/profiles/9.jpg" src="assets/img/profiles/9x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">terrance young</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/1x.jpg" data-src="assets/img/profiles/1.jpg" src="assets/img/profiles/1x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">theodore woods</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/2x.jpg" data-src="assets/img/profiles/2.jpg" src="assets/img/profiles/2x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">todd wood</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/3x.jpg" data-src="assets/img/profiles/3.jpg" src="assets/img/profiles/3x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">tommy jenkins</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
                <div class="list-view-group-container">
                  <div class="list-view-group-header text-uppercase">w</div>
                  <ul>
                    <!-- BEGIN Chat User List Item  !-->
                    <li class="chat-user-list clearfix">
                      <a data-view-animation="push-parrallax" data-view-port="#chat" data-navigate="view" class="" href="#">
                        <span class="thumbnail-wrapper d32 circular bg-success">
                            <img width="34" height="34" alt="" data-src-retina="assets/img/profiles/4x.jpg" data-src="assets/img/profiles/4.jpg" src="assets/img/profiles/4x.jpg" class="col-top">
                        </span>
                        <p class="p-l-10 ">
                          <span class="text-color">wilma hicks</span>
                          <span class="block text-color hint-text fs-12">Hello there</span>
                        </p>
                      </a>
                    </li>
                    <!-- END Chat User List Item  !-->
                  </ul>
                </div>
              </div>
            </div>
            <!-- BEGIN Conversation View  !-->
            <div class="view chat-view bg-white clearfix">
              <!-- BEGIN Header  !-->
              <div class="navbar navbar-default">
                <div class="navbar-inner">
                  <a href="javascript:;" class="link text-color action p-l-10 p-r-10" data-navigate="view" data-view-port="#chat" data-view-animation="push-parrallax">
                    <i class="pg-icon">chevron_left</i>
                  </a>
                  <div class="view-heading">
                    John Smith
                    <div class="fs-11 hint-text">Online</div>
                  </div>
                  <a href="#" class="link text-color action p-r-10 pull-right ">
                    <i class="pg-icon">more_horizontal</i>
                  </a>
                </div>
              </div>
              <!-- END Header  !-->
              <!-- BEGIN Conversation  !-->
              <div class="chat-inner" id="my-conversation">
                <!-- BEGIN From Me Message  !-->
                <div class="message clearfix">
                  <div class="chat-bubble from-me">
                    Hello there
                  </div>
                </div>
                <!-- END From Me Message  !-->
                <!-- BEGIN From Them Message  !-->
                <div class="message clearfix">
                  <div class="profile-img-wrapper m-t-5 inline">
                    <img class="col-top" width="30" height="30" src="assets/img/profiles/avatar_small.jpg" alt="" data-src="assets/img/profiles/avatar_small.jpg" data-src-retina="assets/img/profiles/avatar_small2x.jpg">
                  </div>
                  <div class="chat-bubble from-them">
                    Hey
                  </div>
                </div>
                <!-- END From Them Message  !-->
                <!-- BEGIN From Me Message  !-->
                <div class="message clearfix">
                  <div class="chat-bubble from-me">
                    Did you check out Pages framework ?
                  </div>
                </div>
                <!-- END From Me Message  !-->
                <!-- BEGIN From Me Message  !-->
                <div class="message clearfix">
                  <div class="chat-bubble from-me">
                    Its an awesome chat
                  </div>
                </div>
                <!-- END From Me Message  !-->
                <!-- BEGIN From Them Message  !-->
                <div class="message clearfix">
                  <div class="profile-img-wrapper m-t-5 inline">
                    <img class="col-top" width="30" height="30" src="assets/img/profiles/avatar_small.jpg" alt="" data-src="assets/img/profiles/avatar_small.jpg" data-src-retina="assets/img/profiles/avatar_small2x.jpg">
                  </div>
                  <div class="chat-bubble from-them">
                    Yea
                  </div>
                </div>
                <!-- END From Them Message  !-->
              </div>
              <!-- BEGIN Conversation  !-->
              <!-- BEGIN Chat Input  !-->
              <div class="b-t b-grey bg-white clearfix p-l-10 p-r-10">
                <div class="row">
                  <div class="col-1 p-t-15">
                    <a href="#" class="link text-color"><i class="pg-icon">add</i></a>
                  </div>
                  <div class="col-8 no-padding">
                    <label class="d-none">Reply</label>
                    <input type="text" class="form-control chat-input" data-chat-input="" data-chat-conversation="#my-conversation" placeholder="Say something">
                  </div>
                  <div class="col-2 link text-color m-l-10 m-t-15 p-l-10 b-l b-grey col-top">
                    <a href="#" class="link text-color"><i class="pg-icon">camera</i></a>
                  </div>
                </div>
              </div>
              <!-- END Chat Input  !-->
            </div>
            <!-- END Conversation View  !-->
          </div>
        </div>
      </div>
    </div>
    <!-- END QUICKVIEW-->
    <!-- START OVERLAY -->
    <div class="overlay hide" data-pages="search">
      <!-- BEGIN Overlay Content !-->
      <div class="overlay-content has-results m-t-20">
        <!-- BEGIN Overlay Header !-->
        <div class="container-fluid">
          <!-- BEGIN Overlay Logo !-->
          <img class="overlay-brand" src="assets/img/logo.png" alt="logo" data-src="assets/img/logo.png" data-src-retina="assets/img/logo_2x.png" width="78" height="22">
          <!-- END Overlay Logo !-->
          <!-- BEGIN Overlay Close !-->
          <a href="#" class="close-icon-light btn-link btn-rounded  overlay-close text-black">
            <i class="pg-icon">close</i>
          </a>
          <!-- END Overlay Close !-->
        </div>
        <!-- END Overlay Header !-->
        <div class="container-fluid">
          <!-- BEGIN Overlay Controls !-->
          <input id="overlay-search" class="no-border overlay-search bg-transparent" placeholder="Search..." autocomplete="off" spellcheck="false">
          <br>
          <div class="d-flex align-items-center">
            <div class="form-check right m-b-0">
              <input id="checkboxn" type="checkbox" value="1">
              <label for="checkboxn">Search within page</label>
            </div>
            <p class="fs-13 hint-text m-l-10 m-b-0">Press enter to search</p>
          </div>
          <!-- END Overlay Controls !-->
        </div>
        <!-- BEGIN Overlay Search Results, This part is for demo purpose, you can add anything you like !-->
        <div class="container-fluid p-t-20">
          <span class="hint-text">
                suggestions :
            </span>
          <span class="overlay-suggestions"></span>
          <br>
          <div class="search-results m-t-30">
            <p class="bold">Pages Search Results: <span class="overlay-suggestions"></span></p>
            <div class="row">
              <div class="col-md-6">
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular bg-success text-white ">
                    <img width="36" height="36" src="assets/img/profiles/avatar.jpg" data-src="assets/img/profiles/avatar.jpg" data-src-retina="assets/img/profiles/avatar2x.jpg" alt="">
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin "><span class="semi-bold result-name">ice cream</span> on pages</h5>
                    <p class="small-text hint-text">via john smith</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular bg-success text-white ">
                    <div>T</div>
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin "><span class="semi-bold result-name">ice cream</span> related topics</h5>
                    <p class="small-text hint-text">via pages</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular bg-success text-white ">
                    <div>M
                    </div>
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin "><span class="semi-bold result-name">ice cream</span> music</h5>
                    <p class="small-text hint-text">via pagesmix</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
              </div>
              <div class="col-md-6">
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular bg-info text-white d-flex align-items-center">
                    <i class="pg-icon">facebook</i>
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin "><span class="semi-bold result-name">ice cream</span> on facebook</h5>
                    <p class="small-text hint-text">via facebook</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular bg-complete text-white d-flex align-items-center">
                    <i class="pg-icon">twitter</i>
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin ">Tweats on<span class="semi-bold result-name"> ice cream</span></h5>
                    <p class="small-text hint-text">via twitter</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
                <!-- BEGIN Search Result Item !-->
                <div class="d-flex m-t-15">
                  <!-- BEGIN Search Result Item Thumbnail !-->
                  <div class="thumbnail-wrapper d48 circular text-white bg-danger d-flex align-items-center">
                    <i class="pg-icon">google_plus</i>
                  </div>
                  <!-- END Search Result Item Thumbnail !-->
                  <div class="p-l-10">
                    <h5 class="no-margin ">Circles on<span class="semi-bold result-name"> ice cream</span></h5>
                    <p class="small-text hint-text">via google plus</p>
                  </div>
                </div>
                <!-- END Search Result Item !-->
              </div>
            </div>
          </div>
        </div>
        <!-- END Overlay Search Results !-->
      </div>
      <!-- END Overlay Content !-->
    </div>
    <!-- END OVERLAY -->

      <script src="assets/plugins/pace/pace.min.js" type="text/javascript"></script>
    <!--  A polyfill for browsers that don't support ligatures: remove liga.js if not needed-->
    <script src="assets/plugins/liga.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="assets/plugins/modernizr.custom.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
    <script src="assets/plugins/popper/umd/popper.min.js" type="text/javascript"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery/jquery-easy.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-unveil/jquery.unveil.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-ios-list/jquery.ioslist.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-actual/jquery.actual.min.js"></script>
    <script src="assets/plugins/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <script type="text/javascript" src="assets/plugins/select2/js/select2.full.min.js"></script>
    <script type="text/javascript" src="assets/plugins/classie/classie.js"></script>
    <script src="assets/plugins/nvd3/lib/d3.v3.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/nv.d3.min.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/utils.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/tooltip.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/interactiveLayer.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/models/axis.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/models/line.js" type="text/javascript"></script>
    <script src="assets/plugins/nvd3/src/models/lineWithFocusChart.js" type="text/javascript"></script>
    <script src="assets/plugins/mapplic/js/hammer.min.js"></script>
    <script src="assets/plugins/mapplic/js/jquery.mousewheel.js"></script>
    <script src="assets/plugins/mapplic/js/mapplic.js"></script>
    <script src="assets/plugins/rickshaw/rickshaw.min.js"></script>
    <script src="assets/plugins/jquery-metrojs/MetroJs.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="assets/plugins/skycons/skycons.js" type="text/javascript"></script>
    <script src="assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <!-- END VENDOR JS -->
    <!-- BEGIN CORE TEMPLATE JS -->
    <!-- BEGIN CORE TEMPLATE JS -->
    <script src="pages/js/pages.js"></script>
    <!-- END CORE TEMPLATE JS -->
    <!-- BEGIN PAGE LEVEL JS -->
    <script src="assets/js/scripts.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS -->
    <!-- END CORE TEMPLATE JS -->
    <!-- BEGIN PAGE LEVEL JS -->
    <script src="assets/js/dashboard.js" type="text/javascript"></script>
    <script src="assets/js/scripts.js" type="text/javascript"></script>
</body>
</html>
