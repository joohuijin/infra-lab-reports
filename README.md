# Infra Lab Reports

IT 아카데미 인프라 실습 정리. 과제별로 폴더 분리.

## 목차

| No | 과제 | 요약 |
|----|------|------|
| 01 | [Forwarding DNS 서버 구축](./01-forwarding-dns/) | 내부 존 해석 + 외부 8.8.8.8 포워딩 |
| 02 | [FTP 온프레미스 서버 구축](./02-ftp-server/) | vsftpd 커스텀 포트(2121) + Rich Rules 대역 제한 |
| 03 | [Private Infrastructure (Ansible)](./03-private-infrastructure/) | Ansible roles로 DNS/WEB/MAIL 자동 구성 |
| 04 | [Docker 기반 WEB 서버 (NFS 연동)](./04-docker-web-nfs/) | httpd + NFS compose, healthcheck 레이스 컨디션 해결 |

## 환경

- 방화벽 경계로 분리된 3개 서브넷 (30 / 40 / 50 대역)
- 각 대역: Firewall(NAT) + DNS + WEB 구성
