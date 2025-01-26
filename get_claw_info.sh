#!/bin/bash

# Base URL for metadata
BASE_URL="http://100.100.100.200/latest/meta-data"

# Function to check if a command is valid and retrieve metadata
check_metadata() {
    local path="$1"
    local description="$2"
    
    # Execute curl and capture output and error
    output=$(curl -s -S "$BASE_URL/$path" 2>&1)
    
    # Check if the output contains 404 error
    if [[ "$output" == *"404 - Not Found"* ]]; then
      #  echo "404 - Not Found: $path"
      echo " "
    else
        # If no 404, print the description and result
        echo "项目：$description"
        echo "结果：$output"
        echo "---"
    fi
}

# Array of metadata paths and descriptions
declare -A metadata=(
    ["dns-conf/nameservers"]="实例的DNS配置"
    ["hostname"]="实例的主机名"
    ["instance/instance-type"]="实例规格"
    ["instance/instance-name"]="实例名称"
    ["image-id"]="创建实例时所使用的镜像ID"
    ["image/market-place/product-code"]="云市场镜像的商品码"
    ["image/market-place/charge-type"]="云市场镜像的计费方式"
    ["instance-id"]="实例ID"
    ["mac"]="实例的MAC地址"
    ["network-type"]="网络类型"
    ["private-ipv4"]="实例主网卡的私网IPv4地址"
    ["public-ipv4"]="实例主网卡的公网IPv4地址"
    ["eipv4"]="实例的固定公网IPv4地址"
    ["region-id"]="实例所属地域"
    ["zone-id"]="实例所属可用区"
    ["vpc-id"]="实例所属VPC ID"
    ["vpc-cidr-block"]="实例所属VPC CIDR段"
)

# Iterate through metadata and check each entry
for path in "${!metadata[@]}"; do
    check_metadata "$path" "${metadata[$path]}"
done
