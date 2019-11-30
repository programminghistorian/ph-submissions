#! /usr/bin/env python3

import pandas as pd
from scipy.spatial.distance import pdist, squareform

tfidf_results = pd.read_csv('1666_tfidf.csv', index_col=0)

euclidean_distances = pd.DataFrame(squareform(pdist(tfidf_results)), index=tfidf_results.index, columns=tfidf_results.index)

print(euclidean_distances.nsmallest(6, 'A53049')['A53049'])

cityblock_distances = pd.DataFrame(squareform(pdist(tfidf_results, metric='cityblock')), index=tfidf_results.index, columns=tfidf_results.index)

print(cityblock_distances.nsmallest(6, 'A53049')['A53049'])

cosine_distances = pd.DataFrame(squareform(pdist(tfidf_results, metric='cosine')), index=tfidf_results.index, columns=tfidf_results.index)

print(cosine_distances.nsmallest(6, 'A53049')['A53049'])
