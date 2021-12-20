# --------------- #
# build container #
# --------------- #

FROM python:3.9-alpine as builder

# Mostly Pillow dependencies + ffmpeg.
RUN apk add build-base ffmpeg jpeg-dev zlib-dev

COPY PixivUtil2/requirements.txt /

RUN pip install --no-cache-dir -r requirements.txt

# ----------------- #
# runtime container #
# ----------------- #

FROM python:3.9-alpine

RUN apk add ffmpeg

WORKDIR /

COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY PixivUtil2/ /

ENTRYPOINT ["python", "/PixivUtil2.py"]
#CMD ["run.py"]
