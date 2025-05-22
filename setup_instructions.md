
# ⚙️ Project Setup Instructions (From Scratch)

Follow these steps to set up and run the Big Data project in a Hadoop–Hive–Zeppelin environment. This guide is beginner-friendly and works for both **Linux/macOS** and **Windows (via WSL or Cygwin)**.

---

## 1️⃣ Prerequisites

Ensure the following are **installed and configured**:

- ✅ Java 8 (recommended)  
  [Download Java 8 JDK](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)

- ✅ Apache Hadoop  
  [Download Hadoop](https://hadoop.apache.org/releases.html)

- ✅ Apache Hive  
  [Download Hive](https://hive.apache.org/downloads.html)

- ✅ Apache Zeppelin (optional for visualization)  
  [Download Zeppelin](https://zeppelin.apache.org/download.html)

- ✅ HDFS user: `hadoop`

- ✅ Dataset file: `omid_dataset.csv`

### 🔧 Environment Variables (Add to `.bashrc`, `.zshrc`, or System Settings)

| Variable       | Description                 |
|----------------|-----------------------------|
| `JAVA_HOME`    | Java JDK installation path  |
| `HADOOP_HOME`  | Hadoop installation path    |
| `HIVE_HOME`    | Hive installation path      |
| `PATH`         | Add `bin/` folders to PATH  |

Check that they are set with:

```bash
echo $JAVA_HOME
echo $HADOOP_HOME
echo $HIVE_HOME
```

---

## 2️⃣ Step-by-Step Setup

### 📂 A. HDFS Data Ingestion

#### 🔹 1. Start Hadoop Services

**Linux/macOS/WSL:**
```bash
start-dfs.sh
```

**Windows (via WSL):**
```bash
bash -c "start-dfs.sh"
```

🔍 **Verify services running:**
```bash
hdfs dfsadmin -report
```

#### 🔹 2. Create Directory in HDFS

```bash
hdfs dfs -mkdir -p /user/hadoop/data/
```

#### 🔹 3. Navigate to Dataset Folder

**Linux/macOS:**
```bash
cd ~/Projects/BigData/Dataset
```

**Windows (via WSL):**
```bash
cd /mnt/d/UlsterProjects/BigData/Dataset
```

> Ensure Windows `D:` is mounted as `/mnt/d/` in WSL

#### 🔹 4. Upload Dataset to HDFS

```bash
hdfs dfs -put omid_dataset.csv /user/hadoop/data
```

#### 🔹 5. Verify Upload

```bash
hdfs dfs -du /user/hadoop/data
```

---

### 🐝 B. Hive Table Creation

#### 🔹 1. Start Hive Shell

```bash
hive
```

#### 🔹 2. (Only First Time) Initialize Hive Metastore

```bash
schematool -dbType derby -initSchema
```

#### 🔹 3. Create External Table in Hive

**If OpenCSVSerde is available:**
```sql
CREATE EXTERNAL TABLE omid_dataset (
  YearStart INT,
  YearEnd INT,
  LocationAbbr STRING,
  LocationDesc STRING,
  Class STRING,
  Topic STRING,
  Question STRING,
  Data_Value_Unit DOUBLE,
  Data_Value_Type STRING,
  Data_Value DOUBLE,
  Data_Value_Alt DOUBLE,
  Low_Confidence_Limit DOUBLE,
  High_Confidence_Limit DOUBLE,
  Sample_Size DOUBLE,
  Education STRING,
  Sex STRING,
  GeoLocation STRING,
  ClassID STRING,
  TopicID STRING,
  QuestionID STRING,
  LocationID INT,
  StratificationCategory1 STRING,
  Stratification1 STRING,
  StratificationCategoryId1 STRING,
  StratificationID1 STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION '/user/hadoop/data'
TBLPROPERTIES ("skip.header.line.count"="1");
```

**If OpenCSVSerde is not available**, use:
```sql
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
```

#### 🔹 4. Run a Sample Query

```sql
SELECT COUNT(*) FROM omid_dataset;
```

---

### 📈 C. Zeppelin Setup and Visualization

#### 🔹 1. Start Zeppelin

```bash
cd $ZEPPELIN_HOME
bin/zeppelin-daemon.sh start
```

#### 🔹 2. Open Zeppelin in Browser

```
http://localhost:8080/
```

#### 🔹 3. Create a New Notebook

- Click **+Notebook**
- Name it (e.g., `HealthData`)
- Set **Hive** as the default interpreter

#### 🔹 4. Configure Hive Interpreter (if needed)

Go to `Interpreter` → `Edit` `hive`:

- **JDBC URL**: `jdbc:hive2://localhost:10000`
- **Driver Class**: `org.apache.hive.jdbc.HiveDriver`
- **Dependencies**: Add Hive JDBC JARs from `$HIVE_HOME/lib` or [Hive Maven](https://mvnrepository.com/artifact/org.apache.hive/hive-jdbc)

Click **Save** and **Restart** the interpreter.

#### 🔹 5. Write Hive Queries

Start each paragraph with:

```hive
%hive
SELECT * FROM omid_dataset LIMIT 10;
```

#### 🔹 6. Visualize Data

Use Zeppelin’s built-in chart options to create:

- 📊 Bar charts: Physical activity by education
- 📈 Line charts: Trends by year
- 🌡️ Heatmaps: Vegetable intake by region and education

---

## 🛑 Stop Services

#### 🔹 Stop Hadoop:

```bash
stop-dfs.sh
```

#### 🔹 Stop Zeppelin:

```bash
bin/zeppelin-daemon.sh stop
```

---

## ✅ You’re Done!

You now have a fully working pipeline:
- Dataset ingested into HDFS
- Hive table set up for analysis
- Zeppelin used for interactive insights
