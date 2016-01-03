FROM ubuntu-debootstrap:14.04.3

ENV PATH /opt/conda/bin:$PATH
ENV LANG C.UTF-8
ENV MINICONDA Miniconda3-latest-Linux-x86_64.sh
RUN apt-get update --fix-missing && apt-get install -y \
    ca-certificates wget bzip2 fonts-ipaexfont && \
    apt-get clean && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget -q https://repo.continuum.io/miniconda/$MINICONDA \
            https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip \
            https://raw.githubusercontent.com/Tsutomu-KKE/scientific-python-3.5/master/notebook.json \
    bash /$MINICONDA -b -p /opt/conda && \
    conda install -y matplotlib networkx scikit-learn jupyter blist bokeh blaze \
                  statsmodels ncurses seaborn dask flask markdown sympy && \
    pip install pulp pyjade && \
    ln -s /usr/share/fonts/opentype/ipaexfont-gothic/ipaexg.ttf \
        /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data/fonts/ttf/
    unzip -q master.zip && \
    mkdir -p /root/.local/share/jupyter /root/.jupyter/nbconfig && \
    mv notebook.json /root/.jupyter/nbconfig/ && \
    cd IPython-notebook-extensions-master && \
    python setup.py install && \
    rm -rf /var/lib/apt/lists/* /$MINICONDA /IPython-notebook-extensions-master \
           /master.zip /opt/conda/pkgs/*
CMD ["/bin/bash"]
