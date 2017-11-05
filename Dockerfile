FROM kaggle/python

RUN pip install pymorphy2[fast] tqdm pymystem3
RUN python -c "import pymystem3.mystem ; pymystem3.mystem.autoinstall()"
RUN wget "https://s3-us-west-1.amazonaws.com/fasttext-vectors/wiki.ru.vec -O wikiru.vec"
RUN python -c "from gensim.models.keyedvectors import KeyedVectors ; w2v = KeyedVectors.load_word2vec_format("wikiru.vec") ; word_vecs = {} ; for word in w2v.vocab: ; vec = w2v[word]; word_vecs[word] = vec ; with open("wikiru.vec.txt", "wt") as outfile: ; for word, vec in word_vecs.items(): ; vec = " ".join([str(i) for i in vec]) ; wordvec = " ".join([word, vec]) ; outfile.write(wordvec + "\n")"