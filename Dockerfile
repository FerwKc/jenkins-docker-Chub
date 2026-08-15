# Imagen ligera de Nginx basada en Alpine
FROM nginx:alpine

# Copiar la página web al directorio público correspondiente de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto del servidor web
EXPOSE 80

# Ejecutar Nginx automáticamente al iniciar el contenedor
CMD ["nginx", "-g", "daemon off;"]