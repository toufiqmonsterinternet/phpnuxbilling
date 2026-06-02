# PHP runtime হিসেবে অফিশিয়াল ইমেজ ব্যবহার
FROM php:8.1-apache

# সার্ভারের ভেতরের প্যাকেজ লিস্ট আপডেট করা এবং unzip টুলটি ইনস্টল করা
RUN apt-get update && apt-get install -y unzip

# গিটহাব থেকে সব ফাইল কনটেইনারে কপি করা
COPY . /var/www/html/

# মেইন জিপ ফাইলটি আনজিপ করা এবং ফাইল সাজানো
RUN unzip -o phpnuxbill-master.zip && \
    mv phpnuxbill-master/* . && \
    rm -rf phpnuxbill-master phpnuxbill-master.zip

# ফাইল পারমিশন সেট করা
RUN chown -R www-data:www-data /var/www/html/

# Apache সার্ভার চালু করা
CMD ["apache2-foreground"]
