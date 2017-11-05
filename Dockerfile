FROM kaggle/python

RUN pip install pymorphy2[fast] tqdm pymystem3
RUN python -c "import pymystem3.mystem ; pymystem3.mystem.autoinstall()"
RUN wget https://s3-us-west-1.amazonaws.com/fasttext-vectors/wiki.ru.vec -O wiki.ru.vec
RUN wget https://github.com/ilyenkov/sdsj2017_docker/raw/master/make_vectors_txt.py
RUN python make_vectors_txt.py
RUN rm wiki.ru.vec