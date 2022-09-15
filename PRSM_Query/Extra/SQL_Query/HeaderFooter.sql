
Create Table S_HeaderFooter
(
HeaderFooter_ID Int Primary key identity(1,1),
Title Varchar(100),
Header Varchar(1000),
Footer Varchar(Max),
Logo  Image,
Address Varchar(5000)
)

--Truncate table S_HeaderFooter

Insert into S_HeaderFooter(Title,Header,Footer,Address) Values(
'Quotation','PANORAMIC TOUR & TRAVELS LTD.',
'<table style="1px solid black;border-collapse: collapse;font-family: Times New Roman;font-size:16px;width:100%;"> 

<tr>
<td style="width:38%;text-align: left"><b>Terms of Payment</b></td>
<td style="width:78%;text-align: left"></td>
</tr>

<tr>
<td style="width:38%;text-align: left">Cheque/DD :</td>
<td style="width:78%;text-align: left"> All Cheques or Demand Drafts in Payment of bill should be drawn in favour of PANORAMIC TOUR & TRAVELS LTD. and Should be Crossed "A/c Payee Only".</td>
</tr>

<tr>
<td style="width:38%;text-align: left">Receipts :</td>
<td style="width:78%;text-align: left">Only our official receipt from duly signed by our cashier will be considered valid.</td>
</tr>

<tr>
<td style="width:38%;text-align: left">Outstandings :</td>
<td style="width:78%;text-align: left">Interrest @24% per annum will be Charged on bill not paid within 15 days</td>
</tr>

<tr>
<td style="width:38%;text-align: left">Service Tax Reg. :</td>
<td style="width:78%;text-align: left">AAACH3926MST001</td>
</tr>
</table>',
'PLOT NO 410/411 ')


