/*	Evaluating Different forms of investing in gold(SGB,Physical Gold,Index Fund) as an investment with 5,6,7,8 years time horizon	*/
/*	Data set taken form NSE Website from 5/Jun/2005 to 30/Nov/2021 as Gold-MCX Spot price Bhaav Copy */
/*	Assumptions made that SGB,Physical Gold,Index Fund were bought and sold on each possible date 	*/
/*	Further Assumptions are explained as we further calculate the returns	*/
/*	After Data cleaning we named the final raw data table Gold_Hist	 having 2 column Date and Spot_Price	*/

Select 	* 
From 	Gold_Hist;

/*	Create a table SGB Data from raw data Table to Calculate SGB returns using the table  		*/
/*	Do not run this query more than once as This has insert query and will lead to duplicates	*/

Create table if not exists SGB_Data
(
	Date date,
    Spot_Price Float (10),
    SGB_Issue_Price Float (10),
    SGB_Redemption_Price Float (10)
);

Insert Into SGB_Data (Date,Spot_Price,SGB_Issue_Price,SGB_Redemption_Price)
Select 		
		date,
		Spot_Price,
		avg(Spot_Price) OVER(ORDER BY Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ),
		avg(Spot_Price) OVER(ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
From 	Gold_Hist;

select 	* 
From 	SGB_data
Order By date; 								/*	SGB data is ready for calculation Performing  */

/* 5 Year SGB Calculation */

Select	* 
From 	SGB_Data where date < '2016-12-01';


Create Table if not exists Return_SGB5
As(
with SGB_5 as
(
Select 	 Row_Number() Over(Partition By A.Date Order by A.date) as RowNumber,
		 A.Date As Issue_Date,
		 A.SGB_Issue_Price as Issue_Price,
		 B.Date As Redemption_Date,
		 B.SGB_Redemption_Price as Redemption_Price,
		 Round(0.025*5*A.SGB_Issue_Price,2) as Interest_Earned,
		 B.SGB_Redemption_Price + Round(0.025*5*A.SGB_Issue_Price,2) as Final_Amt
		 From SGB_Data A 
         inner join SGB_Data B
		 ON (A.Date+Interval 5 year ) = B.Date Or (A.Date+Interval 5 year + Interval 1 day) = B.Date Or (A.Date+Interval 5 year + Interval 2 day) = B.Date or (A.Date+Interval 5 year + Interval 3 day) = B.Date or (A.Date+Interval 5 year + Interval 4 day) = B.Date
Where	 A.Date > '2005-06-07'
Order by A.Date
)

Select 	Issue_Date,
		Issue_Price,
		Redemption_Date,
        Redemption_Price,
        Interest_Earned,
        Final_Amt,
		Round((Power((Final_amt/Issue_Price),(1/5))-1)*100,2) as CAGR
From 	SGB_5
Where 	RowNumber=1

);

Select 	*
From	 Return_SGB5;

/* 6 Year SGB Calculation */

Select	* 
From 	SGB_Data 
where 	date < '2015-12-01';

Create Table if not exists Return_SGB6
As
(
with SGB_6 as
(
Select 	 Row_Number() Over(Partition By A.Date Order by A.date) as RowNumber,
		 A.Date As Issue_Date,
		 A.SGB_Issue_Price as Issue_Price,
		 B.Date As Redemption_Date,
		 B.SGB_Redemption_Price as Redemption_Price,
		 Round(0.025*6*A.SGB_Issue_Price,2) as Interest_Earned,
		 B.SGB_Redemption_Price + Round(0.025*6*A.SGB_Issue_Price,2) as Final_Amt
		 From SGB_Data A 
         inner join SGB_Data B
		 ON (A.Date+Interval 6 year ) = B.Date Or (A.Date+Interval 6 year + Interval 1 day) = B.Date Or (A.Date+Interval 6 year + Interval 2 day) = B.Date or (A.Date+Interval 6 year + Interval 3 day) = B.Date or (A.Date+Interval 6 year + Interval 4 day) = B.Date
Where	 A.Date > '2005-06-07'
Order by A.Date
)
Select 	Issue_Date,
		Issue_Price,
		Redemption_Date,
        Redemption_Price,
        Interest_Earned,
        Final_Amt,
		Round((Power((Final_amt/Issue_Price),(1/6))-1)*100,2) as CAGR
From 	SGB_6
Where 	RowNumber=1
);

Select 	* 
From 	Return_SGB6;

/* 7 Year SGB Calculation */

Select	* 
From 	SGB_Data where date < '2014-12-01';

Create Table if not exists Return_SGB7
As
(
with SGB_7 as
(
Select 	 Row_Number() Over(Partition By A.Date Order by A.date) as RowNumber,
		 A.Date As Issue_Date,
		 A.SGB_Issue_Price as Issue_Price,
		 B.Date As Redemption_Date,
		 B.SGB_Redemption_Price as Redemption_Price,
		 Round(0.025*7*A.SGB_Issue_Price,2) as Interest_Earned,
		 B.SGB_Redemption_Price + Round(0.025*7*A.SGB_Issue_Price,2) as Final_Amt
		 From SGB_Data A 
         inner join SGB_Data B
		 ON (A.Date+Interval 7 year ) = B.Date Or (A.Date+Interval 7 year + Interval 1 day) = B.Date Or (A.Date+Interval 7 year + Interval 2 day) = B.Date or (A.Date+Interval 7 year + Interval 3 day) = B.Date or (A.Date+Interval 7 year + Interval 4 day) = B.Date
Where	 A.Date > '2005-06-07'
Order by A.Date
)
Select 	Issue_Date,
		Issue_Price,
		Redemption_Date,
        Redemption_Price,
        Interest_Earned,
        Final_Amt,
		Round((Power((Final_amt/Issue_Price),(1/7))-1)*100,2) as CAGR
From 	SGB_7
Where 	RowNumber=1
);

Select	 *
From	 Return_SGB7;

/* 8 Year SGB Calculation */

Select	* 
From 	SGB_Data where date < '2013-12-01';

Create Table if not exists Return_SGB8
As
(
with SGB_8 as
(
Select 	 Row_Number() Over(Partition By A.Date Order by A.date) as RowNumber,
		 A.Date As Issue_Date,
		 A.SGB_Issue_Price as Issue_Price,
		 B.Date As Redemption_Date,
		 B.SGB_Redemption_Price as Redemption_Price,
		 Round(0.025*8*A.SGB_Issue_Price,2) as Interest_Earned,
		 B.SGB_Redemption_Price + Round(0.025*8*A.SGB_Issue_Price,2) as Final_Amt
		 From SGB_Data A 
         inner join SGB_Data B
		 ON (A.Date+Interval 8 year ) = B.Date Or (A.Date+Interval 8 year + Interval 1 day) = B.Date Or (A.Date+Interval 8 year + Interval 2 day) = B.Date or (A.Date+Interval 8 year + Interval 3 day) = B.Date or (A.Date+Interval 8 year + Interval 4 day) = B.Date
Where	 A.Date > '2005-06-07'
Order by A.Date
)
Select 	Issue_Date,
		Issue_Price,
		Redemption_Date,
        Redemption_Price,
        Interest_Earned,
        Final_Amt,
		Round((Power((Final_amt/Issue_Price),(1/8))-1)*100,2) as CAGR
From 	SGB_8
Where 	RowNumber=1
);

Select 	*
From	Return_SGB8;

/*		Physical Gold Calculation assuming Standard making of 8%	*/

Select 	Distinct * 
From 	Gold_Hist;

/* Creating another table for physical gold */
/* Do Not create this query twice as it will create duplicates	*/

Create table if not exists Phy_data 
(
	Date date,
    Spot_Price Float(10),
    Making_charges Float (10)
);

Select		*
From		Phy_Data
Order by	date; 

/* Do Not run this query twice as it will create duplicates	*/

Insert Into Phy_data (Date,Spot_price,Making_Charges)
(
	Select	Date,Spot_price,Round(0.08*Spot_price,2)
    From	Gold_Hist
);

Select		*
From		Phy_Data
Order by	date;

/*	Calculating for Physical Gold*/

/*	5 Year Physical Gold Returns	*/

Create Table if not exists Return_Phy5
as
(
With Phy_data5 as
(
	Select			A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
					A.Making_charges as Making_Charges,
                    Abs((B.Spot_price - A.Making_charges)) as Final_Amt,
                    Row_Number() Over(Partition by A.date Order by A.date) as RowNumber
	From			Phy_data A
    Inner Join  	Phy_data B
    On				A.date + Interval 5 Year  = B.Date Or A.date + Interval 5 Year + Interval 1 day = B.Date Or A.date + Interval 5 Year + Interval 2 day = B.Date Or A.date + Interval 5 Year + Interval 3 day = B.Date Or A.date + Interval 5 Year + Interval 4 day = B.Date
    Order by 		A.date
)


Select	*,
		Round((Power((Final_amt/Buy_Price),(1/5))-1)*100,2) as CAGR
From			Phy_data5
where 			RowNumber = '1'
);

Select 	*
From	Return_Phy5;

/*	6 Year Physical Gold Returns	*/

Create Table if not exists Return_Phy6
as
(
With Phy_data6 as
(
	Select			A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
					A.Making_charges as Making_Charges,
                    Abs((B.Spot_price - A.Making_charges)) as Final_Amt,
                    Row_Number() Over(Partition by A.date Order by A.date) as RowNumber
	From			Phy_data A
    Inner Join  	Phy_data B
    On				A.date + Interval 6 Year  = B.Date Or A.date + Interval 6 Year + Interval 1 day = B.Date Or A.date + Interval 6 Year + Interval 2 day = B.Date Or A.date + Interval 6 Year + Interval 3 day = B.Date Or A.date + Interval 6 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Round((Power((Final_amt/Buy_Price),(1/6))-1)*100,2) as CAGR
From			Phy_data6
where 			RowNumber = '1'
);

Select 	*
From	Return_Phy6;

/*	7 Year Physical Gold Returns	*/

Create Table if not exists Return_Phy7
as
(
With Phy_data7 as
(
	Select			A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
					A.Making_charges as Making_Charges,
                    Abs((B.Spot_price - A.Making_charges)) as Final_Amt,
                    Row_Number() Over(Partition by A.date Order by A.date) as RowNumber
	From			Phy_data A
    Inner Join  	Phy_data B
    On				A.date + Interval 7 Year  = B.Date Or A.date + Interval 7 Year + Interval 1 day = B.Date Or A.date + Interval 7 Year + Interval 2 day = B.Date Or A.date + Interval 7 Year + Interval 3 day = B.Date Or A.date + Interval 7 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Round((Power((Final_amt/Buy_Price),(1/7))-1)*100,2) as CAGR
From			Phy_data7
where 			RowNumber = '1'
);

Select 	*
From	Return_Phy7;

/*	8 Year Physical Gold Returns	*/

Create Table if not exists Return_Phy8
as
(
With Phy_data8 as
(
	Select			A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
					A.Making_charges as Making_Charges,
                    Abs((B.Spot_price - A.Making_charges)) as Final_Amt,
                    Row_Number() Over(Partition by A.date Order by A.date) as RowNumber
	From			Phy_data A
    Inner Join  	Phy_data B
    On				A.date + Interval 8 Year  = B.Date Or A.date + Interval 8 Year + Interval 1 day = B.Date Or A.date + Interval 8 Year + Interval 2 day = B.Date Or A.date + Interval 8 Year + Interval 3 day = B.Date Or A.date + Interval 8 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Round((Power((Final_amt/Buy_Price),(1/8))-1)*100,2) as CAGR
From	Phy_data8
where 	RowNumber = '1'
);


Select 	*
From	Return_Phy8;

/*	Calculating the CAGR for Gold Index Fund	*/
/*	We have assumed Total Expense Ratio, Impact Cost and Tracking Error by taking average the respective values 
	for the 3 of India's biggest Gold Index Funds - Nippon Gold Bees,SBI Gold ETF and HDFC Gold ETF			
*/
/*	The values for TER,Impact Cost and Tracking error are - 	
	Here are the links to refer data sources - For Impact cost only - https://www.moneycontrol.com/news/photos/business/personal-finance/this-gold-etf-scores-on-impact-costs-and-volumes-7280551.html
    https://www.sbimf.com/en-us/other-schemes/sbi-etf-gold#Performance
    https://etf.nipponindiaim.com/Funds/details/13#funds_bascis
    https://www.hdfcsec.com/productpage/gold-etf
*/

Select 	*
From	Gold_Hist;

/*	Calculation for 5 Years	*/

Create Table if not exists Return_Indx5
as
(
With Index_data5 as
(
	Select			Row_Number() Over(Partition by A.date Order by A.date) as RowNumber,
					A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
                    Round(0.4/100 * Abs((B.Spot_price - A.Spot_Price)),2) as TER,	/*	Divided by 100 for representing % */
					Round(0.04/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Impact_Cost,
					Round(0.16/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Track_error_cost
	From			Gold_Hist A
    Inner Join  	Gold_Hist B
    On				A.date + Interval 5 Year  = B.Date Or A.date + Interval 5 Year + Interval 1 day = B.Date Or A.date + Interval 5 Year + Interval 2 day = B.Date Or A.date + Interval 5 Year + Interval 3 day = B.Date Or A.date + Interval 5 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Sell_Price - TER - Impact_Cost - Track_error_cost as Final_Amt,
		Round((Power(((Sell_Price- TER - Impact_Cost - Track_error_cost)/Buy_Price),(1/5))-1)*100,2) as CAGR
From	Index_data5
where	RowNumber = '1'
);

Select 	*
From	Return_Indx5;


/*	Calculation for 6 Years	*/

Create Table if not exists Return_Indx6
as
(
With Index_data6 as
(
	Select			Row_Number() Over(Partition by A.date Order by A.date) as RowNumber,
					A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
                    Round(0.4/100 * Abs((B.Spot_price - A.Spot_Price)),2) as TER,	/*	Divided by 100 for representing % */
					Round(0.04/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Impact_Cost,
					Round(0.16/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Track_error_cost                    
	From			Gold_Hist A
    Inner Join  	Gold_Hist B
    On				A.date + Interval 6 Year  = B.Date Or A.date + Interval 6 Year + Interval 1 day = B.Date Or A.date + Interval 6 Year + Interval 2 day = B.Date Or A.date + Interval 6 Year + Interval 3 day = B.Date Or A.date + Interval 6 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Sell_Price - TER - Impact_Cost - Track_error_cost as Final_Amt,
		Round((Power(((Sell_Price- TER - Impact_Cost - Track_error_cost)/Buy_Price),(1/6))-1)*100,2) as CAGR
From	Index_data6
where	RowNumber = '1'
);

Select 	*
From	Return_Indx6;

/*	Calculation for 7 Years	*/

Create Table if not exists Return_Indx7
as
(
With Index_data7 as
(
	Select			Row_Number() Over(Partition by A.date Order by A.date) as RowNumber,
					A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
                    Round(0.4/100 * Abs((B.Spot_price - A.Spot_Price)),2) as TER,	/*	Divided by 100 for representing % */
					Round(0.04/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Impact_Cost,
					Round(0.16/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Track_error_cost
	From			Gold_Hist A
    Inner Join  	Gold_Hist B
    On				A.date + Interval 7 Year  = B.Date Or A.date + Interval 7 Year + Interval 1 day = B.Date Or A.date + Interval 7 Year + Interval 2 day = B.Date Or A.date + Interval 7 Year + Interval 3 day = B.Date Or A.date + Interval 7 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Sell_Price - TER - Impact_Cost - Track_error_cost as Final_Amt,
		Round((Power(((Sell_Price- TER - Impact_Cost - Track_error_cost)/Buy_Price),(1/7))-1)*100,2) as CAGR
From	Index_data7
where	RowNumber = '1'
);

Select 	*
From	Return_Indx7;

/*	Calculation for 8 Years	*/

Create Table if not exists Return_Indx8
as
(
With Index_data8 as
(
	Select			Row_Number() Over(Partition by A.date Order by A.date) as RowNumber,
					A.Date as Buy_Date,
					A.Spot_price as Buy_Price,
					B.Date as Sell_Date,
					B.Spot_price as Sell_Price,
                    Round(0.4/100 * Abs((B.Spot_price - A.Spot_Price)),2) as TER,	/*	Divided by 100 for representing % */
					Round(0.04/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Impact_Cost,
					Round(0.16/100 * Abs((B.Spot_price - A.Spot_Price)),2) as Track_error_cost
	From			Gold_Hist A
    Inner Join  	Gold_Hist B
    On				A.date + Interval 8 Year  = B.Date Or A.date + Interval 8 Year + Interval 1 day = B.Date Or A.date + Interval 8 Year + Interval 2 day = B.Date Or A.date + Interval 8 Year + Interval 3 day = B.Date Or A.date + Interval 8 Year + Interval 4 day = B.Date
    Order by 		A.date
)

Select	*,
		Sell_Price - TER - Impact_Cost - Track_error_cost as Final_Amt,
		Round((Power(((Sell_Price- TER - Impact_Cost - Track_error_cost)/Buy_Price),(1/8))-1)*100,2) as CAGR
From	Index_data8
where	RowNumber = '1'
);


Select 	*
From	Return_Indx8;

/*	Creating Final Output	*/
/*	Two Outputs - 
	1. 5,6,7,8 year Rolling Returns Average	
    2. GOld as an investment as per returns
*/   
select Round(AVG(Return_SGB6.CAGR),2) From Return_SGB6;

                    Select 		'SGB Returns' as Instrument_Year,
								Round(AVG(Return_SGB5.CAGR),2) as CAGR_5, Round(AVG(Return_SGB6.CAGR),2) as CAGR_6,
								Round(AVG(Return_SGB7.CAGR),2)as CAGR_7, Round(AVG(Return_SGB8.CAGR),2) as CAGR_8
                    From 		Return_SGB5 
					Join		Return_SGB6 
                    On			Return_SGB5.Issue_Date = Return_SGB6.Issue_Date
					Join		Return_SGB7
                    On			Return_SGB6.Issue_Date = Return_SGB7.Issue_Date
                    Join		Return_SGB8
                    On			Return_SGB7.Issue_Date = Return_SGB8.Issue_Date
                    
                    UNION All
                    
                    Select 		'Physical Gold Returns' as Instrument_Year,
								Round(AVG(Return_Phy5.CAGR),2) as CAGR_5, Round(AVG(Return_Phy6.CAGR),2) as CAGR_6,
								Round(AVG(Return_Phy7.CAGR),2)as CAGR_7, Round(AVG(Return_Phy8.CAGR),2) as CAGR_8
                    From 		Return_Phy5 
					Join		Return_Phy6 
                    On			Return_Phy5.Buy_Date = Return_Phy6.Buy_Date
					Join		Return_Phy7
                    On			Return_Phy6.Buy_Date = Return_Phy7.Buy_Date
                    Join		Return_Phy8
                    On			Return_Phy7.Buy_Date = Return_Phy8.Buy_Date
                    
                    UNION All
                    
                    Select 		'Index Fund Returns' as Instrument_Year,
								Round(AVG(Return_Indx5.CAGR),2) as CAGR_5, Round(AVG(Return_Indx6.CAGR),2) as CAGR_6,
								Round(AVG(Return_Indx7.CAGR),2)as CAGR_7, Round(AVG(Return_Indx8.CAGR),2) as CAGR_8
                    From 		Return_Indx5
					Join		Return_Indx6
                    On			Return_Indx5.Buy_Date = Return_Indx6.Buy_Date
					Join		Return_Indx7
                    On			Return_Indx6.Buy_Date = Return_Indx7.Buy_Date
                    Join		Return_Indx8
                    On			Return_Indx7.Buy_Date = Return_Indx8.Buy_Date;
                    
/*	Probability of gold returns being negative, below bank interest rates, 
above bank interest rates and beating inflation	
*/

/*	5 Years	*/

Select		'SGB',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_SGB5
                    
UNION All

Select		'Physical Gold',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Phy5
                    
UNION All

Select		'Index Fund',				
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Indx5;

/*	6 Years	*/

Select		'SGB',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_SGB6
                    
UNION All

Select		'Physical Gold',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Phy6
                    
UNION All

Select		'Index Fund',				
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Indx6;

/*	7 Years	*/

Select		'SGB',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_SGB7
                    
UNION All

Select		'Physical Gold',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Phy7
                    
UNION All

Select		'Index Fund',				
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Indx7;

/*	8 Years	*/

Select		'SGB',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_SGB8
                    
UNION All

Select		'Physical Gold',		
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Phy8
                    
UNION All

Select		'Index Fund',				
			Round(Count(Case	When CAGR <= '0'					Then 	'abc'	End)/Count(*)*100,2) as 'Negative returns Probability',
			Round(Count(Case	When CAGR > '0' and CAGR < '3'		Then 	'abc'	End)/Count(*)*100,2) as 'Below Bank Interest Probability',        
			Round(Count(Case	When CAGR >= '3' and CAGR < '6'		Then 	'abc'	End)/Count(*)*100,2) as 'Above Bank Interest Probability',
			Round(Count(Case	When CAGR >= '6'					Then 	'abc'	End)/Count(*)*100,2) as 'Beating Inflation Probability'
From		Return_Indx8;

