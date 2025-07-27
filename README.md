# dbt-project

📦 Outputs 
GitHub Repository – Includes dbt project with models, tests, documentation, and macros
Superset dashboard screenshot

✅ Completed
 Structured dbt models (stg_, int_, fct_, dim_, mart_), including macros for data cleaning and transformation
 Implemented basic dbt tests (e.g., unique keys, not null, valid values)
 Basic dbt documentation (description: and docs: blocks)
 Superset dashboard with visual insights and summary metrics

🧠 Areas for Improvement
Time constraints limited full development in the following areas (wanted to get this done in 4 hours). I've outlined these to reflect on my process and where enhancements are possible:
1. Documentation is incomplete – variable calculations need clearer explanations, commenting could be much better, marts don’t have proper documentation (not a lot of thought was put into the marts, because the dataset was fairly limited)
2. Limited scalability – for eg, date field macros may not handle future entries that fall outside current criteria
3. Manual workaround was done during cleaning – had to remove the first 3 rows before flattening data in the intermediate table
4. Data organization – unsure if the current mart structure and tables created are optimal
5. Insufficient testing – time constraints prevented comprehensive tests; for example, the gender column lacks an "other" option since none were reported in the dataset
6. Validation gap – component-level sales values haven't been verified against totals (in this case component would be equal to total)
7. Data structure considerations – while order ID uniqueness is checked, the flattened data structure should better accommodate multiple rows per order if needed (linked to previous point)