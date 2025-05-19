#!/bin/bash

UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
URL="https://www.tiktok.com/"

echo "⏳ 正在测试 TikTok 是否解锁..."

# 第一次请求（不带特殊 header）
raw_result=$(curl -sL -m 10 --user-agent "$UA_Browser" "$URL")

# 判断是否返回 curl 错误或空内容
if [[ $raw_result == "curl"* || -z "$raw_result" ]]; then
    echo "❌ 无法访问 TikTok（连接失败）"
    exit 1
fi

# 尝试提取 "region" 字段
region=$(echo "$raw_result" | grep '"region":' | sed 's/.*"region":"\([^"]*\)".*/\1/')

if [[ -n "$region" ]]; then
    echo "✅ TikTok 已解锁，区域：$region"
    exit 0
fi

# 第二次请求（模拟更真实浏览器访问，带 Accept-Encoding gzip 等 header）
compressed_result=$(curl -sL -m 10 --user-agent "$UA_Browser" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" \
  -H "Accept-Encoding: gzip" \
  -H "Accept-Language: en" "$URL" | gunzip 2>/dev/null)

region2=$(echo "$compressed_result" | grep '"region":' | sed 's/.*"region":"\([^"]*\)".*/\1/')

if [[ -n "$region2" ]]; then
    echo "🟡 TikTok 可访问但可能为 IDC 地址，区域：$region2"
    exit 0
else
    echo "❌ 当前 IP 未能解锁 TikTok 或被封锁"
    exit 1
fi