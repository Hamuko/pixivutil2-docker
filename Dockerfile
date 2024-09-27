# --------------- #
# build container #
# --------------- #

FROM python:3.11-alpine AS builder

# Mostly Pillow dependencies + ffmpeg.
RUN apk add build-base ffmpeg jpeg-dev zlib-dev

COPY PixivUtil2/requirements.txt /

RUN pip install --no-cache-dir -r requirements.txt

# ----------------- #
# runtime container #
# ----------------- #

FROM python:3.11-alpine

RUN apk add ffmpeg

WORKDIR /

COPY --from=builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY PixivUtil2/ /

ENTRYPOINT ["python", "/PixivUtil2.py"]
