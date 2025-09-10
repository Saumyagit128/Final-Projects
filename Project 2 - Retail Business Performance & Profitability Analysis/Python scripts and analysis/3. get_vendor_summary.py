import sqlite3
import pandas as pd
import logging
import time
from ingestion_db import ingest_db


logging.basicConfig(
    filename = "logs/get_vendor_summary.log",
    level = logging.DEBUG,
    format = "%(asctime)s - %(levelname)s - %(message)s",
    filemode = "a"
)

def create_vendor_summary (conn):
    '''this function will merge different tables to create overall vendor summary and add new columns in the resultant data'''
    vendor_sales_summary = pd.read_sql("""WITH FreightSummary as (
        SELECT 
            VendorNumber,
            sum(Freight) as FreightCost 
        FROM vendor_invoice 
        GROUP BY VendorNumber
    ),

    PurchaseSummary as (
        SELECT
            p.VendorNumber, 
            p.VendorName, 
            p.Brand,
            p.Description,
            p.PurchasePrice,
            pp.price as ActualPrice,
            pp.volume,
            sum(p.Quantity) as TotalPurchaseQuantity, 
            sum(p.Dollars) as TotalPurchaseDollars
        FROM purchases p
        JOIN purchase_prices pp
            ON p.Brand = pp.Brand
        WHERE p.PurchasePrice > 0
        GROUP BY  p.VendorNumber, p.VendorName, p.Brand, p.Description, p.PurchasePrice, pp.price, pp.volume 
    ),
    
    SalesSummary as (
        SELECT
            VendorNo, VendorName, Brand,
            sum(SalesDollars) as TotalSalesDollars,
            sum(SalesPrice) as TotalSalesPrice,
            sum(SalesQuantity) as TotalSalesQuantity,
            sum(ExciseTax) as TotalExciseTax
        FROM sales
        GROUP BY VendorNo, VendorName, Brand
    )
    
    SELECT
        ps.VendorNumber, 
        ps.VendorName, 
        ps.Brand,
        ps.Description,
        ps.PurchasePrice,
        ps.ActualPrice,
        ps.volume,
        ps.TotalPurchaseQuantity, 
        ps.TotalPurchaseDollars,
        ss.TotalSalesDollars,
        ss.TotalSalesPrice,
        ss.TotalSalesQuantity,
        ss.TotalExciseTax,
        fs.FreightCost
    FROM PurchaseSummary ps
    JOIN SalesSummary ss
        ON ps.VendorNumber = ss.VendorNo
        AND ps.Brand = ss.Brand
    JOIN FreightSummary fs
        ON ps.VendorNumber = fs.VendorNumber
    ORDER BY ps.TotalPurchaseDollars DESC""", conn)

    return vendor_sales_summary

def clean_data (df):
    '''this function will clean the data'''
    # changing the data type to float
    df['volume'] = df['volume'].astype('float64')
    #Removing spaces from categorical columns
    df['VendorName'] = df['VendorName'].str.strip()
    df['Description'] = df['Description'].str.strip()

    #creating new columns for better analytics
    df['GrossProfit'] = df['TotalSalesDollars'] - df['TotalPurchaseDollars']
    df['ProfitMargin'] = df['GrossProfit']/df['TotalSalesDollars']
    df['SalestoPurchaseRatio'] = df['TotalSalesDollars']/df['TotalPurchaseDollars']
    df['StockTurnover'] = df['TotalSalesQuantity']/df['TotalPurchaseQuantity']

    return df

if __name__ == '__main__':
    #creating database connection
    conn = sqlite3.connect('inventory.db')

    logging.info('Creating Vendor Summary table.....')
    summary_df = create_vendor_summary(conn)
    logging.info(summary_df.head())

    logging.info('Cleaning Data.....')
    clean_df = clean_data(summary_df)
    logging.info(clean_df.head())

    logging.info('Ingesting data...')
    ingest_db(clean_df, 'vendor_sales_summary', conn)
    logging.info('Completed')