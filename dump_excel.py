import pandas as pd
df = pd.read_excel('AI_Orchestration_Backlog_5Sprints.xlsx')
with open('excel_dump.txt', 'w', encoding='utf-8') as f:
    f.write(df.to_string())
