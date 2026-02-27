import mysql.connector
from dotenv import load_dotenv
import os

# Load .env from the same folder as db.py
dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
load_dotenv(dotenv_path)

def get_conn():
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST","mysql"),
        user=os.getenv("DB_USER"),                    
        password=os.getenv("DB_PASSWORD"),  
        database=os.getenv("DB_NAME"),
        port=3306   
    )
    return conn
print("DB_USER:", os.getenv("DB_USER"))
print("DB_PASSWORD:", os.getenv("DB_PASSWORD"))
print("DB_NAME:", os.getenv("DB_NAME"))
