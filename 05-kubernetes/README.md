# Kubernetes · 쿠버네티스 실습 정리

쿠버네티스의 워크로드 배포, 서비스 연결, 스토리지와 스케줄링을 학습한 기록.
공개 범위는 학습 항목과 확인한 상태를 정리한 README로 제한한다.

## 동작 원리

쿠버네티스는 선언한 목표 상태에 맞추어 컨테이너 워크로드를 관리한다.

- Pod: 컨테이너를 배치하고 실행하는 기본 단위
- 컨트롤러: 복제본 수와 배포 상태 등을 관리
- Service: Pod에 접근할 수 있는 네트워크 연결 제공
- ConfigMap·Secret: 애플리케이션 설정과 민감정보를 구분하여 관리
- PV·PVC: 스토리지 자원과 사용 요청을 분리
- 스케줄러: 조건과 자원 상황에 따라 Pod를 배치할 노드 선택

Secret의 Base64 인코딩은 암호화가 아니므로 원문을 공개하지 않는다.

## 실습 자료에서 확인한 범위

아래 항목은 실습 디렉터리와 파일 이름을 기준으로 분류했다.
각 파일의 내용 검토나 실행 성공 여부를 의미하지 않는다.

| 분야 | 확인한 실습 자료 |
| --- | --- |
| 기본 구성 | Pod, Namespace |
| Pod 설정 | 다중 컨테이너, Init Container, Liveness Probe, 자원 요청·제한, 환경변수 |
| 워크로드 | RC, ReplicaSet, Deployment, DaemonSet, StatefulSet, Job, CronJob |
| 서비스 연결 | ClusterIP, NodePort, LoadBalancer, Headless Service |
| 외부 접근 | Ingress, Gateway API |
| 배포 방식 | Rolling Update, Canary, Blue-Green |
| 설정 관리 | ConfigMap, Secret을 이용한 애플리케이션 구성 |
| 스토리지 | emptyDir, hostPath, NFS, PV·PVC |
| 자동 확장 | HPA |
| 스케줄링 | Node Selector, Affinity·Anti-Affinity, Taint·Toleration, Cordon·Drain |
| 접근 제어 | 사용자 인증, ServiceAccount, RBAC |

## 확인한 환경

- kubectl 클라이언트 버전: v1.36.2
- kubectl에 포함된 Kustomize 버전: v5.8.1
- 조회된 노드: 4개
- 조회된 노드의 kubelet 버전: 모두 v1.36.2
- Ready 조건: True 1개, Unknown 3개
- 실습 디렉터리에서 발견한 YAML 파일: 109개

클라이언트 버전과 kubelet 버전은 각각 조회한 값이며,
API 서버 버전은 별도로 확인하지 않았다.

Unknown 상태의 원인은 이번 조회만으로 확정하지 않았다.
워크로드 실행, 서비스 응답, 스토리지 연결과 자동 확장 동작도 이번 정리에서 재검증하지 않았다.

## 공개 범위

- 포함: README.md
- 제외: 실습 YAML 원문, 설치 스크립트와 클러스터 설정
- 제외: 계정 정보, 비밀번호, 토큰, Secret, kubeconfig, 인증서와 개인키
- 제외: 구체적인 내부 주소·도메인·저장 경로
- 제외: 환경변수 파일, 로그, 명령 기록, 애플리케이션 데이터와 백업

실제 환경의 구성 파일을 그대로 재현하거나 배포하기 위한 자료가 아닌 학습 요약이다.
