FROM node:8.10.0 as nodejs
WORKDIR /usr/src/app
COPY package.json /usr/src/app
# RUN yarn
COPY . ./
# RUN yarn build
RUN mkdir build
RUN mkdir x
FROM nginx
COPY --from=nodejs /usr/src/app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY build /usr/share/nginx/html
RUN chown -R nginx /usr/share/nginx/html/ # grant to user nginx
# ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
