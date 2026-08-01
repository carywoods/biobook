# Appendix F: API Keys and Environment Setup

## Getting Your AI API Key

This book uses AI to help interpret biological results. You need an API key to use the AI features. Several providers offer free API keys -- no credit card required.

We recommend **Google Gemini** because most students already have a Google account.

### Option 1: Google Gemini (Recommended)

1. Go to [Google AI Studio](https://aistudio.google.com/)
2. Sign in with your Google account
3. Click "Get API Key"
4. Copy the key

Set your environment variables:

```bash
export OPENAI_API_KEY="your-key-here"
export OPENAI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
export OPENAI_MODEL="gemini-2.5-flash"
```

**Free tier:** 1,500 requests per day, 15 requests per minute. More than enough for this course.

### Option 2: Groq

1. Go to [console.groq.com](https://console.groq.com/)
2. Create an account
3. Go to API Keys and create one
4. Copy the key

```bash
export OPENAI_API_KEY="your-key-here"
export OPENAI_BASE_URL="https://api.groq.com/openai/v1"
export OPENAI_MODEL="llama-3.3-70b-versatile"
```

**Free tier:** 1,000 requests per minute. Very fast inference.

### Option 3: OpenRouter (Access to Many Models)

1. Go to [openrouter.ai](https://openrouter.ai)
2. Create an account and add credits (pay-as-you-go)
3. Get your API key

```bash
export OPENAI_API_KEY="sk-or-v1-your-key-here"
export OPENAI_BASE_URL="https://openrouter.ai/api/v1"
export OPENAI_MODEL="google/gemini-2.5-flash"
```

OpenRouter gives you access to dozens of models with one key. Useful if you want to try different models or if the free tiers have rate limits you need to work around.

## Making It Permanent

Add the export lines to your shell configuration:

**Linux/Mac:** Add to `~/.bashrc` or `~/.zshrc`:
```bash
export OPENAI_API_KEY="your-key-here"
export OPENAI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
export OPENAI_MODEL="gemini-2.5-flash"
```

Then run `source ~/.bashrc` or open a new terminal.

**Windows:** Search for "Environment Variables" in the Start menu.

**Jupyter Notebook:** Run this in a cell before your scripts:
```python
import os
os.environ["OPENAI_API_KEY"] = "your-key-here"
```

## Running Without AI

Every AI script in this book works without an API key. If the key is not set, the script will:
1. Run the vanilla (non-AI) portion normally
2. Print a note that AI features are unavailable
3. Skip the AI interpretation

You can complete the entire course using only the vanilla scripts.

## Python Setup

Install Python 3.8+ from [python.org](https://www.python.org/), then:

```bash
pip install biopython pandas numpy matplotlib openai
```

Verify your setup:

```bash
python ch01_vanilla_02.py
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `No module named 'openai'` | `pip install openai` |
| `No module named 'Bio'` | `pip install biopython` |
| `AI not available` | Check: `echo $OPENAI_API_KEY` |
| `Rate limit exceeded` | Wait one minute, or switch to Groq |
| `Model not found` | Check model name format (e.g., `gemini-2.5-flash`) |
