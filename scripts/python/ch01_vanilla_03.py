#!/usr/bin/env python3
"""
Chapter 1, Script 3 -- Vanilla Version
The Iris Dataset: your first real biological data analysis.

Concept: classification, real data, pandas basics, biological measurement
"""

import pandas as pd

# The Iris dataset: 150 flowers, 4 measurements, 3 species
# Measurements are in centimeters
# We'll build it from scratch so you see every value

# Load from UCI (or use sklearn)
try:
    from sklearn.datasets import load_iris
    iris = load_iris()
    df = pd.DataFrame(iris.data, columns=iris.feature_names)
    df["species"] = [iris.target_names[i] for i in iris.target]
except ImportError:
    # Fallback: load from UCI URL
    url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
    df = pd.read_csv(url, header=None, names=[
        "sepal length (cm)", "sepal width (cm)",
        "petal length (cm)", "petal width (cm)", "species"
    ])

print("The Iris Dataset")
print("=" * 50)
print(f"Introduced by Ronald Fisher in 1936")
print(f"150 flowers, 4 measurements, 3 species\n")

# Basic info
print(f"Shape: {df.shape[0]} rows x {df.shape[1]} columns")
print(f"\nSpecies distribution:")
for species, count in df["species"].value_counts().items():
    print(f"  {species}: {count} flowers")

# Show first few rows
print(f"\nFirst 5 flowers:")
print(df.head().to_string(index=False))

# Summary statistics
print(f"\nSummary statistics (all measurements in cm):")
print(df.describe().round(2).to_string())

# Classification by petal length
print(f"\n\nSimple classification rule:")
print(f"If petal length < 2.5 cm -> likely setosa")
print(f"If petal length 2.5-5.0 cm -> likely versicolor")
print(f"If petal length > 5.0 cm -> likely virginica")

# Test this rule
correct = 0
for _, row in df.iterrows():
    pl = row["petal length (cm)"]
    actual = row["species"]
    if pl < 2.5:
        predicted = "Iris-setosa"
    elif pl < 5.0:
        predicted = "Iris-versicolor"
    else:
        predicted = "Iris-virginica"
    if predicted == actual:
        correct += 1

accuracy = correct / len(df) * 100
print(f"\nAccuracy of this simple rule: {correct}/{len(df)} ({accuracy:.1f}%)")
