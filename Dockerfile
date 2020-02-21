FROM adham/conda-base:latest

USER root

RUN conda install --quiet --yes \
    pandas \
    matplotlib \
    bokeh \
    seaborn \
    openpyxl \
    xlrd \
    scikit-learn \
    nodejs \
    joblib \
    flask \
    gunicorn \
    conda-forge::jupyterlab \
    conda-forge::tqdm \
    conda-forge::ipympl \
    conda-forge::gensim \
    conda-forge::xgboost \
    conda-forge::catboost \
    conda-forge::conda-pack

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install jupyter-matplotlib \
    && jupyter nbextension enable --py widgetsnbextension

RUN conda update --all --yes \
    && conda clean --all -f -y \
    && jupyter lab build 

EXPOSE 8888
ENTRYPOINT [ "jupyter", "lab", "--ip=0.0.0.0" ]

USER jovyan
