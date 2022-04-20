### Schema for gaming data
Databases are an essential aspect of game development, so this project is to design and create a database to retain data about the players that have played on the various games that were designed for our robotic therapy device. This is the first draft of the entity-relational diagram (ERD) showing relationships between entities. 

![ERD draft](https://github.com/doscsy12/hman_database/blob/main/hman_database_v1.drawio.png)


However, given the amount of time-series metrics that we have to track, a conventional relational database might not be suitable for easy extraction of the required metrics for analysis. Chances are we would have to design and create a time series database (TSDB), which is a database optimized for recording/ measuring time-stamped or time series data. 

Before I figure out the TSDB for better handling of metrics/ events/ measurements that are time-stamped, the current draft of our ERD will provide an overall guide as to how our database (and the required entities) should be in this project. 
