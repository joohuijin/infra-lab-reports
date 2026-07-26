# Forwarding DNS 서버 구축

## 목차
1. 개요
2. Firewall Server 설정 (192.168.50.10)
3. Server2 (WEB Server) 설정 (192.168.50.12)
4. Server1 (DNS Server) 설정 (192.168.50.11)
5. 서비스 기동 및 확인

---

## 1. 개요

가상 환경 내에서 방화벽을 경계로 분리된 서브넷 구조를 이해하고, 내부 도메인 해석과 외부 도메인 포워딩을 동시에 수행하는 Forwarding DNS 서버를 구축한다. 본 구축은 50 대역(192.168.50.0/24)을 기준으로 진행한다.

## 1.2 Forwarding DNS란?

Forwarding DNS는 자신이 관리하는 영역(Zone)에 대한 질의는 직접 응답하고, 관리하지 않는 외부 도메인(예: google.com)에 대한 질의는 상위 DNS 서버(Forwarder, 예: 8.8.8.8)로 전달하여 결과를 대신 받아오는 서버를 말한다.

---

## 2. Firewall Server 설정 (192.168.50.10)

내부 서버들의 외부 통신을 위해 마스커레이딩(NAT)을 설정하고 DNS 패킷 통과를 허용한다.

    firewall-cmd --permanent --add-masquerade
    firewall-cmd --permanent --add-service=dns
    firewall-cmd --reload

## 3. Server2 (WEB Server) 설정 (192.168.50.12)

    yum -y install httpd mod_ssl
    systemctl enable --now httpd
    cat << END > /var/www/html/index.html
    jhj.com
    END

## 4. Server1 (DNS Server) 설정 (192.168.50.11)

BIND 패키지를 이용하여 메인 DNS 서비스를 구성한다.

    yum install -y bind bind-utils

named.conf 에서 allow-query { any; }, forwarders { 8.8.8.8; }, forward only; 를 설정하고, named.rfc1912.zones 에 50/40/30 대역의 정방향/역방향 존을 선언한 뒤 존 파일을 작성한다.

정방향(A 레코드): www.jhj.com→192.168.50.12, www.pjs.com→192.168.40.11, www.cyj.com→192.168.30.12
역방향(PTR 레코드): 각 대역 IP → ns1.도메인.

## 5. 서비스 기동 및 확인

    systemctl enable --now named

nslookup 으로 내부 도메인이 정확한 IP로 해석되는지, google.com 조회 시 Non-authoritative answer 로 포워딩이 동작하는지, 역방향 조회로 ns1.도메인 이 반환되는지 확인한다.
