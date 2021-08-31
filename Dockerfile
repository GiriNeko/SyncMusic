FROM php:7.3.8-alpine
WORKDIR /var/www/run/
RUN cd /tmp && \
    wget https://api.ineko.cc/gh/https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz -O /tmp/swoole.tgz && \
    mkdir -p /usr/src/php/ext/swoole && \
    tar xzf /tmp/swoole.tgz --strip-components=1 -C /usr/src/php/ext/swoole && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add libstdc++ python3 tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    touch /usr/local/etc/php/conf.d/timezone.ini && \
    echo "date.timezone = Asia/Shangha" > /usr/local/etc/php/conf.d/timezone.ini && \
    docker-php-ext-install swoole && \
    docker-php-ext-enable swoole && \
    pip3 install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple mutagen
CMD ["php", "/var/www/run/server.php"]
