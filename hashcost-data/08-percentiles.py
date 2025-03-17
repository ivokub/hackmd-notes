import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

# Load the CSV data
file_path = '08-proving_speed.csv'
data = pd.read_csv(file_path)

# Compute statistics
median = data.median()
mean = data.mean()
percentiles = data.quantile([0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95])

print("all")
# Print statistics
print("Median:\n", median)
print("Mean:\n", mean)
print("Percentiles:\n", percentiles)

# Plot the data
plt.figure(figsize=(10, 6))

# Plot gas proven per ms
plt.hist(data['gas proven per ms'], bins=30, color='red', alpha=0.7)
plt.title('Gas Proven per ms')
plt.xlabel('Gas Proven per ms')
plt.ylabel('Frequency')

# Show the plots
plt.tight_layout()
plt.savefig('08-percentiles_all.png')
print("saved")

# Load the CSV data
file_path = '08-proving_speed_prove_core.csv'
data = pd.read_csv(file_path)

# Compute statistics
median = data.median()
mean = data.mean()
percentiles = data.quantile([0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95])

print("prove_core")
# Print statistics
print("Median:\n", median)
print("Mean:\n", mean)
print("Percentiles:\n", percentiles)

# Plot the data
plt.figure(figsize=(10, 6))

# Plot gas proven per ms
plt.hist(data['gas proven per ms'], bins=30, color='red', alpha=0.7)
plt.title('Gas Proven per ms')
plt.xlabel('Gas Proven per ms')
plt.ylabel('Frequency')

# Show the plots
plt.tight_layout()
plt.savefig('08-percentiles_core.png')
print("saved")