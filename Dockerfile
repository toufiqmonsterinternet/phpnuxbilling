# PHP runtime হিসেবে অফিসিয়াল ছবি ব্যবহার
FROM php:8.1-apache

# গিটহাব থেকে ফাইলগুলো কনটেইনারে কপি করা
COPY . /var/www/html/

# মেইন জিপ ফাইলটি আনজিপ করা এবং ফাইল সাজানো
RUN unzip -o phpnuxbill-master.zip && \
    mv phpnuxbill-master/* . && \
    rm -rf phpnuxbill-master phpnuxbill-master.zip

# ফাইল পারমিশন সেট করা
RUN chown -R www-data:www-data /var/www/html/

# Apache সার্ভার চালু করা
CMD ["apache2-foreground"]
