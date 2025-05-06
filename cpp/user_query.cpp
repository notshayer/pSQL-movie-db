#include <iostream>
#include <libpq-fe.h>
#include <vector>
#include <string>
#include <sstream>
#include <iomanip>

void exitWithError(PGconn* conn, const std::string& message) {
    std::cerr << message << ": " << PQerrorMessage(conn) << std::endl;
    PQfinish(conn);
    exit(1);
}

int main() {
    const std::string conninfo = "host=localhost port=5432 dbname=movie_db user=postgres password=";

    PGconn* conn = PQconnectdb(conninfo.c_str());
    if (PQstatus(conn) != CONNECTION_OK) {
        exitWithError(conn, "Connection to database failed");
    }

    // Get available dates
    PGresult* res = PQexec(conn, "SELECT DISTINCT Show_Date FROM Showing ORDER BY Show_Date;");
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        PQclear(res);
        exitWithError(conn, "Failed to get available dates");
    }

    std::vector<std::string> dates;
    int rows = PQntuples(res);
    std::cout << "Available Showing Dates:\n";
    for (int i = 0; i < rows; ++i) {
        std::string date = PQgetvalue(res, i, 0);
        dates.push_back(date);
        std::cout << date << std::endl;
    }
    PQclear(res);

    // Get user input
    std::string inputDate;
    std::cout << "Enter date from one of the above options: ";
    std::getline(std::cin, inputDate);

    // Check if valid date
    bool valid = false;
    for (const auto& d : dates) {
        if (d == inputDate) {
            valid = true;
            break;
        }
    }

    if (!valid) {
        std::cout << "No data found for the given date.\n";
        PQfinish(conn);
        return 0;
    }

    // Prepare and execute revenue query
    std::ostringstream query;
    query << "SELECT t.Company_Name, SUM(tk.Price) AS Total_Revenue "
          << "FROM Theatre t "
          << "JOIN Screens s ON t.Theatre_ID = s.Theatre_ID "
          << "JOIN Showing sh ON s.Screen_ID = sh.Screen_ID "
          << "JOIN Ticket tk ON sh.Showing_ID = tk.Showing_ID "
          << "WHERE sh.Show_Date = '" << inputDate << "' "
          << "GROUP BY t.Theatre_ID "
          << "ORDER BY Total_Revenue DESC "
          << "LIMIT 1;";

    res = PQexec(conn, query.str().c_str());
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        PQclear(res);
        exitWithError(conn, "Failed to execute revenue query");
    }

    if (PQntuples(res) > 0) {
        std::string name = PQgetvalue(res, 0, 0);
        double revenue = std::stod(PQgetvalue(res, 0, 1));
        std::cout << "Theatre: " << name << ", Total Revenue: $" << std::fixed << std::setprecision(2) << revenue << std::endl;
    } else {
        std::cout << "No results found.\n";
    }

    PQclear(res);
    PQfinish(conn);
    return 0;
}