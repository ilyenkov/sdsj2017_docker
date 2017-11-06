from gensim.models.keyedvectors import KeyedVectors
import numpy as np

w2v = KeyedVectors.load_word2vec_format("wiki.ru.vec")

word_vecs = {}
for word in w2v.vocab:
    if len(word.split()) == 1:
        vec = w2v[word]
        word_vecs[word] = vec

with open("wiki.ru.vec.txt", "wt") as outfile:
    for word, vec in word_vecs.items():
        vec = " ".join([str(i) for i in vec])
        wordvec = " ".join([word, vec])
        outfile.write(wordvec + "\n")

char_vecs = {}
for word in w2v.vocab:
    vec = w2v[word]
    if len(word.split()) == 1:
        for char in word:
            if char in char_vecs:
                char_vecs[char] = (char_vecs[char][0] + vec, char_vecs[char][1] + 1)
            else:
                char_vecs[char] = (vec, 1)

with open("wiki.ru.vec_char_emb.txt", "wt") as outfile:
    for char, vec in char_vecs.items():
        avg_vector = np.round((vec[0] / vec[1]), 6).tolist()
        avg_vector = " ".join([str(i) for i in avg_vector])
        charvec = " ".join([char, avg_vector])
        outfile.write(charvec + "\n")
