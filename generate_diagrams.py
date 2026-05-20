import zlib
import base64
import urllib.request
import string
import os

def plantuml_encode(plantuml_text):
    zlibbed_str = zlib.compress(plantuml_text.encode('utf-8'))
    compressed_string = zlibbed_str[2:-4]
    
    b64_str = base64.b64encode(compressed_string).decode('utf-8')
    
    b64_alphabet = string.ascii_uppercase + string.ascii_lowercase + string.digits + '+/'
    plantuml_alphabet = string.digits + string.ascii_uppercase + string.ascii_lowercase + '-_'
    
    translation_table = str.maketrans(b64_alphabet, plantuml_alphabet)
    return b64_str.translate(translation_table)

def generate_diagram(name, puml_content):
    encoded = plantuml_encode(puml_content)
    url = f"http://www.plantuml.com/plantuml/png/{encoded}"
    output_path = os.path.join("images", f"{name}.png")
    
    print(f"Generating {name}...")
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response, open(output_path, 'wb') as out_file:
            out_file.write(response.read())
        print(f"Saved {output_path}")
    except Exception as e:
        print(f"Error generating {name}: {e}")

diagrams = {
    "system_architecture_styled": """@startuml
!theme plain
skinparam defaultFontName Arial
skinparam defaultFontSize 14
skinparam shadowing false

skinparam package {
    BackgroundColor transparent
    BorderColor #1976D2
    BorderThickness 1.5
    BorderStyle dashed
    FontColor #000000
    FontSize 15
}

skinparam rectangle {
    BackgroundColor #FFFFFF
    BorderColor #42A5F5
    BorderThickness 1.5
    RoundCorner 15
    FontColor #0D47A1
    FontSize 13
}

skinparam component {
    BackgroundColor #F8F9FA
    BorderColor #90CAF9
    RoundCorner 15
    FontColor #333333
}

package "Enterprise Orchestration Network" as Network {
    
    rectangle "Frontend Cluster" as FrontCluster {
        component "Instance 1\\n(Port 5173)" as F1
        component "Instance 2\\n(Port 5173)" as F2
    }
    
    rectangle "Kong Gateway Array" as KongCluster {
        component "Instance 1\\n(Port 8000)" as K1
        component "Instance 2\\n(Port 8000)" as K2
    }
    
    rectangle "FastAPI Orchestrators" as BackCluster {
        component "Instance 1\\n(Port 3000)" as B1
        component "Instance 2\\n(Port 3000)" as B2
        component "Instance 3\\n(Port 3000)" as B3
    }
    
    rectangle "Public Edge Router" as KongSvc
    rectangle "Internal API Mesh" as BackSvc
    
    FrontCluster -[hidden]right- KongCluster
    KongCluster -[hidden]right- BackCluster
    
    KongCluster -[hidden]down- KongSvc
    BackCluster -[hidden]down- BackSvc
}

rectangle "Keycloak Server\\n(Identity Broker)" as Keycloak #F5F5F5
rectangle "PostgreSQL & Redis\\n(State & Quota)" as DB #F5F5F5

Network -right-> Keycloak : " OAuth 2.0"
Network -down-> DB : " Persistence"

@enduml""",

    "system_architecture": """@startuml
!theme plain
skinparam BackgroundColor #FDFDFD
skinparam DefaultFontName "Arial"
skinparam DefaultFontSize 14
skinparam RoundCorner 8
skinparam Shadowing 1

skinparam node {
    BackgroundColor #F2F4F8
    BorderColor #D0D4DC
    FontColor #111827
    FontSize 16
    FontStyle bold
    Padding 20
}

skinparam component {
    BackgroundColor #2563EB
    BorderColor #1D4ED8
    FontColor #FFFFFF
    FontSize 14
    Padding 10
}

skinparam database {
    BackgroundColor #059669
    BorderColor #047857
    FontColor #FFFFFF
    FontSize 14
    Padding 10
}

skinparam actor {
    BackgroundColor #DC2626
    BorderColor #B91C1C
}

skinparam ArrowColor #6B7280
skinparam ArrowThickness 2

node "Entry Layer" {
  [WAF\\n(ModSecurity)] as waf
  [Kong Gateway] as kong
}

node "Application Layer" {
  [FastAPI Backend] as fastapi
  [Keycloak SSO] as keycloak
  [Open Policy Agent] as opa
  [Vault Secrets] as vault
}

node "Data Layer" {
  database "Platform DB\\n(PostgreSQL)" as pg_platform
  database "Kong DB\\n(PostgreSQL)" as pg_kong
  database "Keycloak DB\\n(PostgreSQL)" as pg_keycloak
  database "Redis Quotas" as redis
}

node "AI Execution Layer" {
  [Ollama Local LLM] as ollama
}

actor "User" as user

user -right-> waf : HTTPS Requests
waf -right-> kong : Traffic
kong -down-> keycloak : Authenticate
kong -down-> fastapi : Route AI Request

fastapi -right-> opa : Evaluate Policy
fastapi -down-> redis : Check Quota
fastapi -right-> vault : Fetch Secrets
fastapi -down-> pg_platform : Log / Verify
fastapi -down-> ollama : Execute Prompt

kong -down-> pg_kong
keycloak -down-> pg_keycloak
@enduml""",

    "cicd_pipeline": """@startuml
!theme plain
skinparam backgroundColor white
skinparam ActivityBackgroundColor #D9EAD3
skinparam ActivityBorderColor #38761D

start
:Developer commits code;
:Push to GitHub main branch;
partition "GitHub Actions CI" {
  :Run Pre-flight Checks;
  :Build Docker Images;
  :Push Images to Registry;
}
partition "Deployment (Kubernetes)" {
  :Apply K8s ConfigMaps;
  :Deploy ai-data Namespace;
  :Deploy ai-application Namespace;
  :Deploy ai-gateway Namespace;
  :Sync Kong Config (decK);
}
:Platform Ready;
stop
@enduml""",

    "sprint1_sequence": """@startuml
!theme plain
actor User
participant "Kong Gateway" as Kong
participant Keycloak
participant "FastAPI" as API

User -> Kong: Request with JWT
Kong -> API: Forward Request
API -> Keycloak: Fetch JWKS
Keycloak --> API: JWKS Keys
API -> API: Verify Signature (RS256)
API -> API: Extract tenant_id & roles
API -> API: Verify Kong Correlation-ID
alt Authentication Failed
    API --> Kong: 401 Unauthorized
    Kong --> User: 401 Unauthorized
else Authentication Success
    API --> Kong: 200 OK
    Kong --> User: Success Response
end
@enduml""",

    "sprint2_class": """@startuml
!theme plain
skinparam classAttributeIconSize 0

class ApplicationFactory {
  +create_app(): FastAPI
  +register_routers()
  +setup_middlewares()
}

class AIRequestService {
  +process_request(req): Response
  -run_pre_flight_pipeline()
}

class IntentCacheService {
  -cache: dict
  +resolve_intent(intent): ServiceID
  +refresh_cache_bg_task()
}

class OutputGuardService {
  -buffer: str
  +redact_stream_chunk(chunk): str
}

ApplicationFactory --> AIRequestService : initializes
AIRequestService --> IntentCacheService : uses
AIRequestService --> OutputGuardService : uses
@enduml""",

    "sprint2_sequence_sse": """@startuml
!theme plain
actor Frontend
participant "FastAPI" as API
participant "OutputGuard" as Guard
participant "Ollama" as Ollama

Frontend -> API: POST /api/ai/request
API -> API: Run Pre-flight Checks
API -> Ollama: POST /api/generate
loop Every Token
    Ollama --> API: JSON Chunk
    API -> Guard: redact_stream_chunk
    Guard -> Guard: Check PII in buffer
    Guard --> API: Redacted Content
    API --> Frontend: SSE Event
end
Ollama --> API: Done Event
API --> Frontend: SSE Event: [DONE]
@enduml""",

    "sprint3_sequence": """@startuml
!theme plain
actor FastAPI
participant "PolicyService" as Policy
participant "OPA" as OPA
participant "Redis" as Redis

FastAPI -> Policy: evaluate_request()
Policy -> OPA: POST /v1/data/allow
OPA --> Policy: {"result": true}
alt Policy Denied
    FastAPI --> User: 403 Forbidden
else Policy Allowed
    FastAPI -> Redis: INCRBY quota
    Redis --> FastAPI: New Usage Value
    alt Quota Exceeded
        FastAPI --> User: 429 Too Many Requests
    else Quota Valid
        FastAPI -> FastAPI: Proceed
    end
end
@enduml""",

    "sprint4_sequence": """@startuml
!theme plain
actor FastAPI
participant "ContentInspector" as Inspector
participant "spaCy NER" as NER
participant "Regex Rules" as Regex
participant "OutputGuard" as Guard

== Input Inspection ==
FastAPI -> Inspector: scan_prompt(text)
Inspector -> Regex: check_patterns(text)
Regex --> Inspector: matches
Inspector -> NER: get_entities(text)
NER --> Inspector: entities
alt PII Detected
    Inspector -> Inspector: Escalate Sensitivity
end

== Output Redaction ==
FastAPI -> Guard: redact_response(text)
Guard -> Guard: replace PII
Guard --> FastAPI: Safe text
@enduml""",

    "plugin_pipeline_styled": """@startuml
!theme plain
skinparam defaultFontName Arial
skinparam defaultFontSize 13

skinparam ArrowColor #FF6D00
skinparam ArrowThickness 1.5

skinparam package {
    BackgroundColor #E8F5E9
    BorderColor #2E7D32
    FontColor #1B5E20
    BorderThickness 1.5
}

skinparam node {
    BackgroundColor #E3F2FD
    BorderColor #1976D2
    FontColor #0D47A1
    BorderThickness 1.5
}

skinparam actor {
    BorderColor #2E7D32
    BackgroundColor #4CAF50
}

actor "User" as Client

package "Kong API Gateway" {
    node "WAF\\n(ModSecurity)" as WAF
    node "Correlation ID\\n(Tracing)" as CID
    node "JWT Plugin\\n(Auth)" as JWT
    node "OPA Plugin\\n(Governance)" as OPA
    node "Rate Limiting\\n(Quota)" as Rate
    
    node "Prometheus\\n(Metrics)" as Prom
    node "HTTP Log\\n(Audit)" as Log
}

package "Application Layer" {
    node "FastAPI\\n(Backend)" as API
}

Client -down-> WAF : " Interacts with API"
WAF -right-> CID : " Clean Payload"
CID -right-> JWT : " Inject Request-ID"
JWT -right-> OPA : " Verified Token"
OPA -down-> Rate : " Allowed Policy"
Rate -right-> API : " Validated Request"

Rate .down.> Prom : " Record Latency/Status"
Rate .down.> Log : " Async Request Log"

@enduml""",

    "ldm_sprint2": """@startuml
!theme plain
hide circle
skinparam linetype ortho

entity "Tenant" as tenant {
  * tenant_id : UUID
  --
  name : VARCHAR
  quota_limit : INT
}

entity "AIRequestRecord" as request {
  * request_id : UUID
  --
  tenant_id : UUID <<FK>>
  status : VARCHAR
}

entity "AIService" as service {
  * service_id : UUID
  --
  name : VARCHAR
  provider : VARCHAR
}

entity "IntentRouting" as intent {
  * intent_id : UUID
  --
  intent_name : VARCHAR
  service_id : UUID <<FK>>
}

tenant ||--o{ request
service ||--o{ intent
request }o--|| service
@enduml""",

    "end_to_end_orchestration": """@startuml
!theme plain
skinparam BackgroundColor #FFFFFF
skinparam DefaultFontName "Arial"
skinparam DefaultFontSize 14
skinparam RoundCorner 8
skinparam Shadowing 1
skinparam maxMessageSize 150

skinparam sequence {
    ArrowColor #2563EB
    ActorBorderColor #1D4ED8
    LifeLineBorderColor #9CA3AF
    LifeLineBackgroundColor #F3F4F6
    
    ParticipantBorderColor #1D4ED8
    ParticipantBackgroundColor #EBF5FF
    ParticipantFontColor #1E3A8A
    ParticipantFontSize 14
    ParticipantFontName Arial
    ParticipantPadding 20
    
    BoxBorderColor #D1D5DB
    BoxBackgroundColor #F9FAFB
}

actor "User Application\\n(Frontend)" as Client

box "Perimeter / Zero-Trust Layer (Kong Gateway)" #F0FDF4
participant "WAF\\n(ModSecurity)" as WAF
participant "JWT Auth\\n(Keycloak)" as Auth
participant "OPA Policy\\n(Governance)" as OPA
participant "Redis\\n(Rate Limit)" as Rate
end box

box "Orchestration Layer (FastAPI)" #EFF6FF
participant "AI Request\\nService" as FastAPI
participant "Intent\\nClassifier" as Intent
participant "Output\\nGuard" as Guard
end box

box "Execution Layer" #FEF2F2
participant "Ollama\\n(LLM)" as LLM
end box

== 1. Request Ingestion & Perimeter Defense ==
Client -> WAF: POST /api/v1/ai/request\\n(Prompt + JWT)
activate WAF
WAF -> WAF: Scan for Malicious Payloads\\n(SQLi, XSS)
WAF -> Auth: Forward Clean Payload
deactivate WAF

activate Auth
Auth -> Auth: Verify RS256 Signature\\n(via Keycloak JWKS)
Auth -> OPA: Forward (tenant_id injected)
deactivate Auth

activate OPA
OPA -> OPA: Evaluate Rego Policies\\n(Is tenant allowed?)
OPA -> Rate: Forward if Authorized
deactivate OPA

activate Rate
Rate -> Rate: INCRBY Tenant Quota
Rate -> FastAPI: Route to Upstream Backend
deactivate Rate

== 2. Cognitive Routing & Orchestration ==
activate FastAPI
FastAPI -> FastAPI: Validate Request Schema
FastAPI -> Intent: Classify Prompt Semantic Intent
activate Intent
Intent -> Intent: Cache Check / LLM Eval
Intent --> FastAPI: Intent Identified (e.g., "Code_Generation")
deactivate Intent

FastAPI -> FastAPI: Select appropriate AI Model based on Intent

== 3. AI Execution & Streaming Guardrails ==
FastAPI -> LLM: Initialize Stream Generation
activate LLM
loop Every Token Generated
    LLM --> FastAPI: Yield Token Chunk
    FastAPI -> Guard: Sanitize Token (PII / Secrets)
    activate Guard
    Guard -> Guard: Regex & NLP Masking
    Guard --> FastAPI: Safe Token
    deactivate Guard
    FastAPI --> Client: Server-Sent Event (SSE)\\nData: <Safe Token>
end
LLM --> FastAPI: [DONE] Signal
deactivate LLM
FastAPI --> Client: Close Connection
deactivate FastAPI

@enduml""",

    "architecture_platform": """@startuml
!theme plain
skinparam BackgroundColor #FDFDFD
skinparam DefaultFontName "Arial"
skinparam DefaultFontSize 14
skinparam RoundCorner 8
skinparam Shadowing 1

skinparam node {
    BackgroundColor #F2F4F8
    BorderColor #D0D4DC
    FontColor #111827
    FontSize 16
    FontStyle bold
    Padding 20
}

skinparam component {
    BackgroundColor #2563EB
    BorderColor #1D4ED8
    FontColor #FFFFFF
    FontSize 14
    Padding 10
}

skinparam database {
    BackgroundColor #059669
    BorderColor #047857
    FontColor #FFFFFF
    FontSize 14
    Padding 10
}

skinparam actor {
    BackgroundColor #DC2626
    BorderColor #B91C1C
}

skinparam ArrowColor #6B7280
skinparam ArrowThickness 2

node "Entry Layer (ai-gateway namespace)" {
  [WAF\\n(ModSecurity)] as waf
  [Kong Gateway\\n(Edge Microservice)] as kong
}

node "Application Layer (ai-application & ai-security)" {
  [FastAPI Orchestrator\\n(Core Microservice)] as fastapi
  [Intent Classifier\\n(ML Microservice)] as intent
  [Keycloak SSO] as keycloak
  [Open Policy Agent] as opa
  [Vault Secrets] as vault
}

node "Data Layer (ai-data namespace)" {
  database "Platform DB\\n(PostgreSQL)" as pg_platform
  database "Kong DB\\n(PostgreSQL)" as pg_kong
  database "Keycloak DB\\n(PostgreSQL)" as pg_keycloak
  database "Redis Quotas & Cache" as redis
  [Log Retention\\n(K8s CronJob)] as cron
}

node "AI Execution Layer (ai-execution namespace)" {
  [Ollama Local LLM\\n(AI Microservice)] as ollama
}

actor "User" as user

user -right-> waf : HTTPS Requests
waf -right-> kong : Traffic
kong -down-> keycloak : Authenticate
kong -down-> fastapi : Route AI Request

fastapi -right-> opa : Evaluate Policy
fastapi -right-> vault : Fetch Secrets
fastapi -down-> intent : Classify Intent
fastapi -down-> redis : Check Quota / Cache
fastapi -down-> pg_platform : Log / Verify
fastapi -down-> ollama : Execute Prompt

kong -down-> pg_kong
keycloak -down-> pg_keycloak
cron -up-> pg_platform : Prune Old Logs
@enduml"""
}

if not os.path.exists("images"):
    os.makedirs("images")

for name, puml in diagrams.items():
    generate_diagram(name, puml)
