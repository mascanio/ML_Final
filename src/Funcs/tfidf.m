function tfidf = tfidf(term, document, Collection)		
		tfidf = tfLog(term, document).* idf(term, Collection);
endfunction
