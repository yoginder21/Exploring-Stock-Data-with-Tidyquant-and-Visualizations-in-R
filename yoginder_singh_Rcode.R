install.packages(c("tidyquant", "dplyr", "tidyr", 'ggplot2','zoo'))

library(tidyquant)
library(dplyr)
library(tidyr)
library(ggplot2)
library(zoo)

symbols <- c("GOOG", "AAPL", "MSFT", 'TSLA')

end_date = Sys.Date()

start_date = end_date-365


stock_data <- tq_get(symbols, from = start_date, to = end_date)

# BOXPLOT 

box_plot <- ggplot(stock_data,aes(factor(symbol), close)) +
            geom_boxplot(aes (fill = factor(symbol))) +  
            xlab('SHARES') + ylab('PRICE')
box_plot

# Chart
apple_stock <- stock_data %>%
               filter ( symbol == "GOOG") %>%
               mutate(moving_average = zoo:: rollmean(close, k = 20 ,fill = NA, align = 'right'))

apple_stock

candle_chart <- ggplot (apple_stock, aes(x = date))+
                geom_candlestick(aes(open = open, high = high, low = low, close = close) )+
                geom_line(aes(y = moving_average), color ='black')+
                ylab('Price')
                
candle_chart
                                                 
# SCATTER PLOT TO FIND THE LINEAR RELATIONSHIP BETWEEN AAP & GOOG STOCK 

scatter_plot <- stock_data %>%
              select(date, close, symbol) %>% 
              spread(symbol, close)
point_graph <- ggplot(scatter_plot, aes(x = AAPL, y = GOOG)) +
                geom_point()+
                geom_smooth(method = 'lm', se = FALSE)
                  
  
point_graph            







