#!/usr/bin/env python3
"""
Chapter 1, Script 3 -- AI Version
The Iris Dataset + AI classifies flowers and explains the biology.

Same data as vanilla, but AI explains what the measurements mean.
"""

import os
import pandas as pd

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features\n")

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

# Load Iris dataset
try:
    from sklearn.datasets import load_iris
    iris = load_iris()
    df = pd.DataFrame(iris.data, columns=iris.feature_names)
    df["species"] = [iris.target_names[i] for i in iris.target]
except ImportError:
    url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
    df = pd.read_csv(url, header=None, names=[
        "sepal length (cm)", "sepal width (cm)",
        "petal length (cm)", "petal width (cm)", "species"
    ])

print("The Iris Dataset (1936)")
print(f"150 flowers, 4 measurements, 3 species\n")

# Species stats
for species in df["species"].unique():
    subset = df[df["species"] == species]
    print(f"{species}: {len(subset)} flowers, "
          f"petal length {subset['petal length (cm)'].mean():.1f} +/- "
          f"{subset['petal length (cm)'].std():.1f} cm")

# Simple rule accuracy
correct = 0
for _, row in df.iterrows():
    pl = row["petal length (cm)"]
    actual = row["species"]
    predicted = "Iris-setosa" if pl < 2.5 else ("Iris-versicolor" if pl < 5.0 else "Iris-virginica")
    if predicted == actual:
        correct += 1
print(f"\nSimple rule accuracy: {correct}/{len(df)} ({correct/len(df)*100:.1f}%)")

# --- AI: Explain the biology ---
print("\n--- AI: What are these flowers? ---\n")
result = ask_ai(
    "I'm analyzing the Iris dataset (Fisher 1936). It has 150 flowers from 3 species:\n"
    "  - Iris setosa: petal length mean ~1.5 cm\n"
    "  - Iris versicolor: petal length mean ~4.3 cm\n"
    "  - Iris virginica: petal length mean ~5.5 cm\n\n"
    "A simple rule (petal length thresholds) achieves 96% accuracy.\n\n"
    "Please explain:\n"
    "1. What are sepal and petal? Why measure both?\n"
    "2. Why did Ronald Fisher choose iris flowers for this dataset?\n"
    "3. What does it mean that setosa is so easy to separate from the other two?\n"
    "4. How is this related to what we do in bioinformatics? (Think: classifying cells, viruses, etc.)\n"
    "5. What would a more sophisticated classifier do that our simple rule can't?\n\n"
    "Explain for a college freshman who has never taken a statistics class."
)
print(result)

# --- AI: Classification as a concept ---
print("\n--- AI: Why does classification matter in biology? ---\n")
result = ask_ai(
    "I just classified iris flowers using a simple measurement threshold.\n"
    "In bioinformatics, we classify:\n"
    "  - DNA sequences as coding or non-coding\n"
    "  - Mutations as harmful or benign\n"
    "  - Cells as cancerous or normal\n"
    "  - Viruses as known strain or new variant\n\n"
    "Explain in 3 sentences: why is classification one of the most important "
    "things scientists do with data? Make it sound exciting."
)
print(result)
