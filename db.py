import mysql.connector
from dotenv import load_dotenv
import os


load_dotenv()

def get_conn():
    conn = mysql.connector.connect(
        host="localhost",
        user=os.getenv("DB_USER"),                    
        password=os.getenv("DB_PASSWORD"),  
        database=os.getenv("DB_NAME")    
    )
    return conn

