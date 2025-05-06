brew install libpq
g++ -std=c++11 -I/opt/homebrew/opt/libpq/include -L/opt/homebrew/opt/libpq/lib -lpq user_query.cpp -o app
./app
