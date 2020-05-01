docker build -t laurentgilcast/multi-client:latest -t laurentgilcast/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t laurentgilcast/multi-server:latest -t laurentgilcast/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t laurentgilcast/multi-worker:latest -t laurentgilcast/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push laurentgilcast/multi-client:latest
docker push laurentgilcast/multi-server:latest
docker push laurentgilcast/multi-worker:latest

docker push laurentgilcast/multi-client:$SHA
docker push laurentgilcast/multi-server:$SHA
docker push laurentgilcast/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=laurentgilcast/multi-server:$SHA
kubectl set image deployments/client-deployment client=laurentgilcast/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=laurentgilcast/multi-worker:$SHA
