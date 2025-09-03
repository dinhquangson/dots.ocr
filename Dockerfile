FROM vllm/vllm-openai:v0.9.1

RUN pip3 install flash_attn==2.8.0.post2
RUN pip3 install transformers==4.51.3

# Clone and set up the repository
RUN cd /tmp && \
  git clone https://github.com/rednote-hilab/dots.ocr.git dotsocr && \
  cd dotsocr && \
  pip install -e . && \
  python3 tools/download_model.py

# Copy gradio.py from the host build context to the container
COPY gradio.py /tmp/dotsocr/gradio.py

# Verify the file was copied
RUN ls -la /tmp/dotsocr/gradio.py

WORKDIR /tmp/dotsocr

USER root

ENTRYPOINT []
CMD ["python3", "gradio.py"]
