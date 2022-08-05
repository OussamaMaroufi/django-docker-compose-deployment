# django-docker-compose-deployment

uWsgi for serving static files 

setup reverse proxy 
url start /static the request forworded to shared static volume 

uwsgi_params file used by the proxy to map some request headers to the request if we don't do that the request headers will be the proxy infos 