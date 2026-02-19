import mysql.connector
from dotenv import load_dotenv
import os


load_dotenv()

def get_conn():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",                     
        password=os.getenv("DB_PASSWORD"),  
        database=os.getenv("DB_NAME")    
    )
    return conn

