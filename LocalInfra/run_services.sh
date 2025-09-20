#!/bin/bash

echo "Deploying MCABank locally..."

echo "Deploying infra..."
docker-compose -f docker/docker-compose.yaml up -d 

echo "Creating queues..."
chmod +x ./create_queues.sh
./create_queues.sh

SERVICES=("MCABankAuth" "MCABankCustomer" "MCABankPayment" "MCABankGateway" "MCABankFrontEnd")

for SERVICE in "${SERVICES[@]}"; do
  echo "Running $SERVICE..."
  cd ../$SERVICE
  make run &   
  cd - > /dev/null
done

wait  

echo ""
echo "Services endpoints:"
echo " - Auth:       http://localhost:5001"
echo " - Customer:   http://localhost:5002"
echo " - Payment:    http://localhost:5003"
echo " - Gateway:    http://localhost:5004"
echo " - FrontEnd:   http://localhost:4200"

