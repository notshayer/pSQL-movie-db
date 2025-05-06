import psycopg2
from datetime import datetime

# Database connection parameters
DB_NAME = "movie_db"
DB_USER = "postgres"
DB_PASSWORD = ""  # Add your password if needed
DB_HOST = "localhost"
DB_PORT = "5432"

available_dates = []
query = """
SELECT 
    t.Company_Name,
    SUM(tk.Price) AS Total_Revenue
FROM 
    Theatre t
JOIN 
    Screens s ON t.Theatre_ID = s.Theatre_ID
JOIN 
    Showing sh ON s.Screen_ID = sh.Screen_ID
JOIN 
    Ticket tk ON sh.Showing_ID = tk.Showing_ID
WHERE 
    sh.Show_Date = '{}'
GROUP BY 
    t.Theatre_ID
ORDER BY 
    Total_Revenue DESC
LIMIT 1;
"""

try:
    # Connect to the database
    conn = psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT
    )
    cursor = conn.cursor()

    # Query distinct dates from Showing
    cursor.execute("SELECT DISTINCT Show_Date FROM Showing ORDER BY Show_Date;")

    dates = cursor.fetchall()
    print("Available Showing Dates:")
    for date_row in dates:
        available_dates.append(date_row[0].strftime("%Y-%m-%d"))
        print(available_dates[-1])
        
    user_input_date = input('Enter date from one of the above options: ')
    if user_input_date in available_dates:
        query = query.format(user_input_date)
        cursor.execute(query)
        result = cursor.fetchone()
        if result:
            print(f"Theatre: {result[0]}, Total Revenue: {result[1]:.2f}")
        else:
            print("Program Error: Bad Query")
    else:
        print("No data found for the given date.")

except Exception as e:
    print("Error:", e)

finally:
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()