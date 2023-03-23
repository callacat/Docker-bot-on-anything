FROM python:3.10-alpine

ENV LANG C.UTF-8 \
    TZ 'Asia/Shanghai'

WORKDIR /app

ADD bot-on-anything /app
ADD sleep.sh /app/sleep.sh

RUN apk update && apk add --no-cache tzdata && cd /tmp \
    && pip3 install --upgrade pip && pip3 install --upgrade openai \
    && pip3 install aiocqhttp && pip install pyTelegramBotAPI \
    && pip3 install EdgeGPT --upgrade \
    && pip3 install itchat-uos==1.5.0.dev0 && sh /app/sleep.sh \
    && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["python3", "app.py"]