using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;
/// <summary>
/// Summary description for PageBase
/// </summary>
public class PageBase : System.Web.UI.Page
{
	public PageBase()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Get the service catgegoryid
    /// </summary>
    public enum Service
    {
      Destruction       = 1,	
     InHousemanagement  = 2,	 
     Otherservices      = 3	,
     PermanentReturn     = 4,	
     FilePickUp          = 5 ,	
     Retrieval           = 6	  
    }

    /// <summary>
    /// 
    /// 
    /// </summary>
    /// <param name="ServiceCategoryId">
    ///  Destruction       = 1,	
    /// InHousemanagement  = 2,	 
    /// Otherservices      = 3	,
    /// PermanentReturn     = 4,	
   ///  FilePickUp          = 5 ,	
   ///  Retrieval           = 6	
    ///  -1 -All Other Sevices(Destruction,InHousemanagement,Otherservices)
    ///  0 -All service categories
    /// </param>
    /// <returns></returns>
    public string GetServiceCategories(Int16 ServiceCategoryId)
    { string strxml = "<NewDataSet> <Root> <ServiceCategoryId>4</ServiceCategoryId> ";
        switch (ServiceCategoryId)
        {
            case 0 :
                strxml ="";
                break;
            case -1:     strxml = "<NewDataSet>" ;
                for (int i = 1; i <= 3; i++)
                {
                    strxml += "<Root> <ServiceCategoryId>"+i+"</ServiceCategoryId> </Root> ";
                }
                strxml += "</NewDataSet>";
                break;
            default:
                  strxml = "<NewDataSet>" ;
                  strxml += "<Root> <ServiceCategoryId>" + ServiceCategoryId + "</ServiceCategoryId> </Root> ";
                  strxml += "</NewDataSet>";
                break;
        }
       
        return strxml ;    
    }


    public int RoleId
    {
        get
        {
            
            int RoleId = 0;
            if (Session["RoleId"] != null)
            {
                RoleId = Convert.ToInt32(Session["RoleId"]);
            }
            return RoleId;
        }
        set
        {
            Session["RoleId"] = value;
        }
    }

    public void IsLoggedIn()
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/User/Login.aspx", false);   
        }
    }
    public string GetQuerstringValue(string strQueryString)
    {
        string strValue = string.Empty;
        if (Convert.ToString(Request.QueryString[strQueryString]) != null)
        {
            strValue = Request.QueryString[strQueryString];
        }
        return strValue;
    }
    public int UserId
    {
        get
        {
            int UserId = 0;
            if (Session["UserId"] != null)
            {
                UserId = Convert.ToInt32(Session["UserId"]);
            }
            return UserId;
        }
        set
        {
            Session["UserId"] = value;
        }
    }

    public string UserName
    {
        get
        {
            string UserName = "";
            if (Session["UserName"] != null)
            {
                UserName = Convert.ToString(Session["UserName"]);
            }
            return UserName;
        }
        set
        {
            Session["UserName"] = value;
        }
    }
    public string RoleName
    {
        get
        {
            string RoleName = "";
            if (Session["RoleName"] != null)
            {
                RoleName = Convert.ToString(Session["RoleName"]);
            }
            return RoleName;
        }
        set
        {
            Session["RoleName"] = value;
        }
    }
    public virtual string PageName { get; set; }

    public System.Globalization.CultureInfo CultureInfo
    {
        get
        {
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            return enGB;
        }
    }

    #region Temp
    public static  List<WorkOrder> LstWorkOrder()
    {
        List<WorkOrder> lstworkOrder = new List<WorkOrder>()
        {
             new WorkOrder {WorkorderNo = 201400001,WoDate= Convert.ToDateTime("12-07-2014"),
                                CustomerId = 1, Remark = "A" , Customer = "ABCX", wareHouseId = 1 ,
                                Status = "Open" , StatuseId  = 1, lstActivity =
                                new List<WoActivites>(){ new WoActivites{WorkorderNo = 201400001,Remark ="Act1",CustomerId = 1,ActivityStatus="Open", ActivityStatuseId=1   } }       },

        new WorkOrder {WorkorderNo = 201400002,WoDate= Convert.ToDateTime("13-07-2014"),
                            CustomerId = 2, Remark = "AA" , Customer = "Zindal", wareHouseId = 1 ,
                            Status = "Open" , StatuseId  = 1, lstActivity =
                            new List<WoActivites>(){ new WoActivites{WorkorderNo = 201400002,Remark ="Act1",CustomerId = 2,ActivityStatus="Open", ActivityStatuseId=1   } }       },

        new WorkOrder {WorkorderNo = 201400003,WoDate= Convert.ToDateTime("14-07-2014"),
                            CustomerId = 3, Remark = "AA" , Customer = "VVGroup", wareHouseId = 1 ,
                            Status = "Open" , StatuseId  = 1, lstActivity =
                            new List<WoActivites>(){ new WoActivites{WorkorderNo = 201400003,Remark ="Act1",CustomerId = 3,ActivityStatus="Open", ActivityStatuseId=1   } }       },

        new WorkOrder {WorkorderNo = 201400004,WoDate= Convert.ToDateTime("14-07-2014"),
                            CustomerId = 4, Remark = "AA" , Customer = "VVGroup", wareHouseId = 1 ,
                            Status = "Open" , StatuseId  = 1, lstActivity =
                            new List<WoActivites>(){ new WoActivites{WorkorderNo = 201400004,Remark ="Act1",CustomerId = 4,ActivityStatus="Open", ActivityStatuseId=1   } }       }


        };
        return lstworkOrder;                                                             
    }

    public List<ServiceRequest> LstserviceRequest()
    {
        List<ServiceRequest> lstservicerequest = new List<ServiceRequest>() { 
            new ServiceRequest {SRId = 1, ServiceNo = "PRSM-SR-0001", SRDate =Convert.ToDateTime("12-07-2014"),
                                CGid = 1, CGName = "A" , Customer = "ABCX", CustomerId = 1, ServiceCategoryId = 1 ,
                                SCName="ACX", NoofBoxes = 12, NoofFiles = 12 , 
                                Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                    = "SC", ServiceCategoryId = 1,
                                                                    IsEdit=0, Remark = "ASa", UserId = 1  }  }         },

            new ServiceRequest {SRId = 2, ServiceNo = "PRSM-SR-0002", SRDate =Convert.ToDateTime("14-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "vikas verma", CustomerId = 1, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }         },
            new ServiceRequest {SRId = 3, ServiceNo = "PRSM-SR-0003", SRDate =Convert.ToDateTime("15-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "Ashish dixit", CustomerId = 3, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }  ,
            },
            new ServiceRequest {SRId = 4, ServiceNo = "PRSM-SR-0004", SRDate =Convert.ToDateTime("15-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "Ashish dixit", CustomerId = 3, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }  ,
            }
            ,
              new ServiceRequest {SRId = 5, ServiceNo = "PRSM-SR-0005", SRDate =Convert.ToDateTime("14-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "Ashish dixit", CustomerId = 3, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }  ,
            },
             new ServiceRequest {SRId = 6, ServiceNo = "PRSM-SR-0006", SRDate =Convert.ToDateTime("18-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "Ashish dixit", CustomerId = 3, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }  ,
            }
            ,
             new ServiceRequest {SRId = 7, ServiceNo = "PRSM-SR-0007", SRDate =Convert.ToDateTime("22-07-2014"),
                                        CGid = 2, CGName = "AA" , Customer = "Ashish dixit", CustomerId = 3, ServiceCategoryId = 1 ,
                                        SCName="ACX", NoofBoxes = 10, NoofFiles = 200 , 
                                        Remark="Reemrak",  ServiceStatus = "New " , ServiceStatusid = 1, lstActivity =
                                        new List<Activity>(){new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                            = "SC", ServiceCategoryId = 1,
                                                                            IsEdit=0, Remark = "ASa", UserId = 1  },
                                                            new Activity{ActivityId = 1, ActivityName = "ActivityName", SCName
                                                                             = "SC", ServiceCategoryId = 1,
                                                                             IsEdit=0, Remark = "ASa", UserId = 1  }  }  ,
            }
        };
        return lstservicerequest;
    }
    #endregion


}

