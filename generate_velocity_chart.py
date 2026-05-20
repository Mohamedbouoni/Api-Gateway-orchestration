import matplotlib.pyplot as plt
import numpy as np
import os

# New 5-Sprint Data
sprints = ['Sprint 1', 'Sprint 2', 'Sprint 3', 'Sprint 4', 'Sprint 5']
sp = [63, 70, 37, 55, 27]

# Create figure
fig, ax = plt.subplots(figsize=(10, 6))

# Colors
horizonblue = '#0054A6'
highlight = '#003D7A'  # Darker blue for peak
colors = [horizonblue if val != max(sp) else highlight for val in sp]

# Bars
bars = ax.bar(sprints, sp, color=colors, width=0.5, zorder=3)

# Average line
avg_sp = np.mean(sp)
ax.axhline(y=avg_sp, color='#FFC107', linestyle='--', linewidth=2, zorder=2, label=f'Average Velocity ({avg_sp:.1f} SP)')

# Labels and Title
ax.set_ylabel('Story Points (SP)', fontsize=12, fontweight='bold', color='#333333')
ax.set_title('Sprint Velocity Distribution (5-Sprint Roadmap)', fontsize=14, fontweight='bold', pad=20, color='#333333')

# Value annotations on top of bars
for bar in bars:
    height = bar.get_height()
    ax.annotate(f'{height}',
                xy=(bar.get_x() + bar.get_width() / 2, height),
                xytext=(0, 3),
                textcoords="offset points",
                ha='center', va='bottom',
                fontsize=12, fontweight='bold', color='#333333')

# Grid and styling
ax.grid(axis='y', linestyle='-', alpha=0.3, zorder=0)
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['left'].set_color('#CCCCCC')
ax.spines['bottom'].set_color('#CCCCCC')

# Legend
ax.legend(loc='upper right', frameon=True, facecolor='white', edgecolor='#CCCCCC')

# Layout and save
plt.tight_layout()
os.makedirs('images', exist_ok=True)
plt.savefig('images/sprint_velocity.png', dpi=300, bbox_inches='tight')
print("Successfully generated images/sprint_velocity.png")
