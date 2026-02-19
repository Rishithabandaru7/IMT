import mysql.connector


def get_conn():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",              
        password="root@123",
        database="incident_db"
    )
    return conn

