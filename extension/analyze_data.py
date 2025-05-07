import pandas as pd
import psycopg2
import matplotlib.pyplot as plt

# Database config
db_params = {
    "dbname": "box_office_db",
    "user": "postgres",
    "host": "localhost",
    "port": "5432"
}

def load_full_theatre_data():
    conn = psycopg2.connect(**db_params)

    # Load all tables
    theatre     = pd.read_sql("SELECT * FROM Theatre", conn)
    screens     = pd.read_sql("SELECT * FROM Screens", conn)
    showtimes   = pd.read_sql("SELECT * FROM Showing", conn)
    movies      = pd.read_sql("SELECT * FROM Movie", conn)
    tickets     = pd.read_sql("SELECT * FROM Ticket", conn)

    full_data = {
        "theatres": theatre,
        "screens" : screens,
        "movies"  : movies,
        "tickets" : tickets,
        "showtimes": showtimes
    }

    return full_data

grouped_theatre_data = load_full_theatre_data()

# Step 1: Load all relevant tables
movies_df = grouped_theatre_data['movies']
showtimes_df = grouped_theatre_data['showtimes']
tickets_df = grouped_theatre_data['tickets']

# Step 2: Create a dictionary to hold total revenue per movie
movie_revenue = {}

# Step 3: Iterate through each movie
for _, movie_row in movies_df.iterrows():
    movie_id = movie_row['movie_id']
    title = movie_row['title']
    
    # Step 4: Find showings for this movie
    showing_ids = showtimes_df[showtimes_df['movie_id'] == movie_id]['showing_id']
    
    # Step 5: Filter tickets sold for those showings
    movie_tickets = tickets_df[tickets_df['showing_id'].isin(showing_ids)]
    
    # Step 6: Sum revenue from those tickets
    total_revenue = movie_tickets['price'].sum()
    
    movie_revenue[title] = total_revenue

# Step 7: Convert to Series and plot
revenue_series = pd.Series(movie_revenue).sort_values(ascending=False)

plt.figure(figsize=(10,6))
revenue_series.plot(kind='bar', color='steelblue')
plt.title('Total Ticket Revenue by Movie')
plt.xlabel('Movie Title')
plt.ylabel('Total Revenue ($)')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()

# Merge tickets → showtimes → screens → theatres (only what's needed)
merged = grouped_theatre_data['tickets'].merge(
    grouped_theatre_data['showtimes'][['showing_id', 'show_date', 'screen_id']],
    on='showing_id'
).merge(
    grouped_theatre_data['screens'][['screen_id', 'theatre_id']],
    on='screen_id'
).merge(
    grouped_theatre_data['theatres'][['theatre_id', 'company_name']],
    on='theatre_id'
)

# Group by date and theatre, then sum revenue
daily_revenue = merged.groupby(['show_date', 'company_name'])['price'].sum().unstack(fill_value=0)

# Plot
daily_revenue.plot(figsize=(10,6), marker='o')
plt.title('Daily Revenue per Theatre')
plt.xlabel('Date')
plt.ylabel('Revenue ($)')
plt.grid(True)
plt.tight_layout()
plt.show()