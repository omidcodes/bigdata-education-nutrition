# 📊 Big Data Analysis of Educational Attainment and Nutritional Quality

This project explores the relationship between **educational attainment** and **nutritional quality** using large-scale health and education data from the U.S. government. It uses big data tools—**Hadoop**, **Hive**, and **Zeppelin**—to process, query, and visualize insights from over 100,000 records across 13 years.

---
---

## 🚀 Getting Started

To set up and run this project locally, see the full step-by-step guide:  
📖 [Setup Instructions →](setup_instructions.md)


## 📂 Project Structure

```
bigdata-education-nutrition/
├── data/
│   └── omid_dataset.csv
├── hive_queries/
│   └── queries.hql
├── slides/
│   └── presentation.pptx
├── screenshots/
│   └── *.png (Zeppelin charts)
├── README.md
└── setup_instructions.md
```

---

## 📈 Dataset Overview

- **Source**: [Data.gov - Nutrition, Physical Activity, and Obesity](https://catalog.data.gov/dataset/nutrition-physical-activity-and-obesity-behavioral-risk-factor-surveillance-system)
- **Years Covered**: 2011–2023
- **Records**: 104,273
- **Features**:
  - Educational Level
  - Fruit & Vegetable Intake
  - Obesity Status
  - Physical Activity
  - U.S. States & Regions

---

## 🧱 Technology Stack

| Tool      | Purpose                                     |
|-----------|---------------------------------------------|
| **HDFS**  | Distributed data storage                    |
| **Hive**  | SQL-like query processing                   |
| **Zeppelin** | Data visualization and dashboard creation |
| **CSV**   | Tabular data format used for ingestion      |

---

## ⚙️ System Architecture Flowchart

The project follows a four-stage big data pipeline:


1. Upload `.csv` to HDFS
2. Create Hive table to mirror dataset schema
3. Run HiveQL queries for analysis
4. Visualize data using Apache Zeppelin


```
📁 Dataset
   └── csv file
        ↓
🗄️ Collect & Storage
   └── Apache HDFS
        ↓
🧠 Analysing & Querying
   └── Apache Hive
        ↓
📊 Visualisation
   └── Apache Zeppelin
```

Each stage builds on the previous one to ensure scalable storage, analysis, and reporting of large-scale health and education data.



---

## 🧠 Key Hive Queries

### 1. 📊 Physical Activity by Education Level
```sql
SELECT Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_physical_activity
FROM omid_dataset
WHERE Class = 'Physical Activity' AND Data_Value IS NOT NULL
GROUP BY Education;
```
**Insight**: College graduates show the highest levels of physical activity (~31.23%).

---

### 2. ⚖️ Obesity Rates by Education Level
```sql
SELECT Education, Question, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_obesity_rate
FROM omid_dataset
WHERE Class = 'Obesity / Weight Status' AND Data_Value IS NOT NULL
GROUP BY Education, Question;
```
**Insight**: Obesity is more prevalent in lower education groups (~36.8% vs. 23.9%).

---

### 3. 🥦 Vegetable Intake by State and Education
```sql
SELECT LocationDesc, Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_low_veg_intake
FROM omid_dataset
WHERE Class = 'Fruits and Vegetables' AND Data_Value IS NOT NULL
GROUP BY LocationDesc, Education;
```
**Insight**: Poor nutrition (low vegetable intake) is common in states with lower education.

---

### 4. 📉 Trend: Physical Activity Over Time
```sql
SELECT YearStart, Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_physical_activity
FROM omid_dataset
WHERE Class = 'Physical Activity' AND Data_Value IS NOT NULL
GROUP BY YearStart, Education;
```
**Insight**: The education–activity gap persists over time.

---

### 5. 🥗 Low Vegetable Intake by Education Level
```sql
SELECT Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_low_veg_intake
FROM omid_dataset
WHERE Class = 'Fruits and Vegetables' AND Data_Value IS NOT NULL
GROUP BY Education;
```
**Insight**: Those with less than a high school education show the highest rates of low vegetable intake (~38.16%).

---

## 📊 Visualization Examples

Screenshots from Zeppelin (place in `/screenshots/`):

- Bar chart: Physical Activity by Education
- Bar chart: Obesity by Education
- Line chart: Trends over years
- Heatmap: Low veg intake by year & education

---

## 🎯 Key Takeaways

- **Education level strongly predicts** healthier behavior.
- More education → higher physical activity, lower obesity, better nutrition.
- Big data tools enable scalable, reproducible public health analytics.

---

## 📚 References

1. Centers for Disease Control and Prevention (2025). *Nutrition, Physical Activity, and Obesity - BRFSS*. [data.gov](https://catalog.data.gov/dataset/nutrition-physical-activity-and-obesity-behavioral-risk-factor-surveillance-system)
2. Apache Hive: [https://hive.apache.org](https://hive.apache.org)
3. Apache Zeppelin: [https://zeppelin.apache.org](https://zeppelin.apache.org)

---

## 🛡️ License

- 🔓 **Source code, queries, and documentation**: Licensed under [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html)
- 🖼️ **Slides and visual materials** (e.g., `.pptx`, images): Licensed under [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

---

## ✍️ Author

**Omid Hashemzadeh**  
