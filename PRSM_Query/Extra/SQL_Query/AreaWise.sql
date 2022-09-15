
declare @StartTime Datetime = '2016-08-30 00:00:00'
declare @EndTime Datetime = '2016-08-30 23:59:59'
declare @AreaID int = 2


select EM.EmployeeName,PM.InTime,PM.OutTime from punchingdetails PM 
inner join ReaderDeviceMaster RDM on  RDM.ReaderDeviceNo = PM.ReaderDeviceNo
inner join ReaderAreaMapping RAM on RAM.ReaderDeviceId = RDM.ReaderDeviceId
inner join CardMaster CM on CM.CardNo = PM.CardId
inner join EmployeeMaster EM on EM.Card_Id = CM.CardId
Where InTime >= @StartTime 
and InTime <= @EndTime 
and RAM.AreaId = @AreaID

order by EM.EmployeeName,PM.InTime

