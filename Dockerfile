# PHP runtime হিসেবে অফিশিয়াল ইমেজ ব্যবহার
FROM php:8.1-apache

# সার্ভারের ভেতরের প্যাকেজ লিস্ট আপডেট করা, unzip এবং ডেটাবেজ লাইব্রেরি ইনস্টল করা
RUN apt-get update && apt-get install -y \
    unzip \
    libpq-dev \
    libsqlite3-dev

# প্রয়োজনীয় পিএইচপি এক্সটেনশন ইনস্টল ও অ্যাক্টিভ করা
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pdo_sqlite

# গিটহাব থেকে সব ফাইল কনটেইনারে কপি করা
COPY . /var/www/html/

# মেইন জিপ ফাইলটি আনজিপ করা এবং ফাইল সাজানো
RUN unzip -o phpnuxbill-master.zip && \
    mv phpnuxbill-master/* . && \
    rm -rf phpnuxbill-master phpnuxbill-master.zip

# ডাটাবেজ ফাইল রাখার জন্য একটি ফাঁকা ফাইল তৈরি ও পারমিশন দেওয়া
RUN touch /var/www/html/system/storage/database.sqlite && \
    chown -R www-data:www-data /var/www/html/

# Apache সার্ভার চালু করা
CMD ["apache2-foreground"]
