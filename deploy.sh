docker build -t eksmo/multi-client:latest -t eksmo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eksmo/multi-server:latest -t eksmo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eksmo/multi-worker:latest -t eksmo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eksmo/multi-client:latest
docker push eksmo/multi-server:latest
docker push eksmo/multi-worker:latest

docker push eksmo/multi-client:$SHA
docker push eksmo/multi-server:$SHA
docker push eksmo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eksmo/multi-server:$SHA
kubectl set image deployments/client-deployment client=eksmo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eksmo/multi-worker:$SHA