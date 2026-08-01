#!/usr/bin/env python3
"""
Chapter 12, Script 1 -- Vanilla Version
Literature mining: searching PubMed for gene information.

Concept: API access, structured queries, data extraction
"""

import urllib.request
import json
import xml.etree.ElementTree as ET


def search_pubmed(query: str, max_results: int = 5) -> list:
    """Search PubMed and return PMIDs."""
    base = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"
    url = f"{base}/esearch.fcgi?db=pubmed&term={query}&retmax={max_results}&retmode=json"
    response = urllib.request.urlopen(url)
    data = json.loads(response.read())
    return data.get("esearchresult", {}).get("idlist", [])


def fetch_abstracts(pmids: list) -> list:
    """Fetch abstracts for a list of PMIDs."""
    if not pmids:
        return []
    base = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"
    ids = ",".join(pmids)
    url = f"{base}/efetch.fcgi?db=pubmed&id={ids}&retmode=xml"
    response = urllib.request.urlopen(url)
    xml_data = response.read().decode()

    # Parse XML
    root = ET.fromstring(xml_data)
    abstracts = []
    for article in root.findall(".//PubmedArticle"):
        title = article.findtext(".//ArticleTitle", "No title")
        abstract = article.findtext(".//AbstractText", "No abstract")
        pmid = article.findtext(".//PMID", "Unknown")
        abstracts.append({"pmid": pmid, "title": title, "abstract": abstract[:200]})
    return abstracts


# --- Main program ---
gene = "BRCA1"
query = f"{gene}+AND+cancer+AND+therapy"

print(f"Searching PubMed for: {gene} cancer therapy")
print(f"Query: {query}\n")

pmids = search_pubmed(query, max_results=5)
print(f"Found {len(pmids)} results: {pmids}")

if pmids:
    print(f"\nFetching abstracts...")
    abstracts = fetch_abstracts(pmids)

    for i, ab in enumerate(abstracts, 1):
        print(f"\n--- Result {i} (PMID: {ab['pmid']}) ---")
        print(f"Title: {ab['title']}")
        print(f"Abstract: {ab['abstract']}...")
