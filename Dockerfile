from vllm/vllm-openai:v0.9.1

RUN pip3 install flash_attn==2.8.0.post2
RUN pip3 install transformers==4.51.3

RUN cd /tmp && \
  git clone https://github.com/rednote-hilab/dots.ocr.git && \
  mv dots.ocr dotsocr && \
  cd dotsocr && \
  pip install -e . && \
  python3 tools/download_model.py
COPY gradio.py /tmp/dotsocr/demo/gradio_.py
WORKDIR /tmp/dotsocr

USER root

ENTRYPOINT []
CMD ["python3", "demo/gradio_.py"]